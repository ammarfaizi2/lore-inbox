Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267698AbUBTCJu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 21:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267697AbUBTCJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 21:09:49 -0500
Received: from smtp-out1.xs4all.nl ([194.109.24.11]:25099 "EHLO
	smtp-out1.xs4all.nl") by vger.kernel.org with ESMTP id S267675AbUBTCHz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 21:07:55 -0500
Subject: [PATCH] : Megaraid patch for 2.6 3/5
From: Paul Wagland <paul@wagland.net>
To: Linux SCSI mailing list <linux-scsi@vger.kernel.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: James.Bottomley@HansenPartnership.com, atulm@lsil.com
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9pyMzlPfstJiTnotuj9L"
Message-Id: <1077242864.12565.86.camel@morsel.kungfoocoder.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 20 Feb 2004 03:07:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9pyMzlPfstJiTnotuj9L
Content-Type: multipart/mixed; boundary="=-Fz9ImZs8zD42RZMKAbnb"


--=-Fz9ImZs8zD42RZMKAbnb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi all,

LSI have released a new driver for the 2.4 series of kernels, but the
2.6 driver is still based on a much older version of this driver. This
is the beginnings of my efforts to update the 2.6 driver so that it is
up to date. This patch removes the local copying of the pdev structure,
this has two advantages, a) the error handling is simpler, since we
don't need to clean up memory anymore, and b) the code is smaller, this
change saves about 500 bytes in the module size.

patch is attached and below.

diff --recursive --ignore-all-space --unified linux-2.6.2.o/drivers/scsi/me=
garaid.c linux-2.6.2.megaraid/drivers/scsi/megaraid.c
--- linux-2.6.2.o/drivers/scsi/megaraid.c	2004-02-20 01:32:26.000000000 +01=
00
+++ linux-2.6.2.megaraid/drivers/scsi/megaraid.c	2004-02-20 01:32:30.000000=
000 +0100
@@ -2338,13 +2338,9 @@
 	struct pci_dev	*pdev;
 	int	len =3D 0;
=20
-	if( make_local_pdev(adapter, &pdev) !=3D 0 ) {
-		*eof =3D 1;
-		return len;
-	}
+	pdev =3D adapter->dev;
=20
 	if( (inquiry =3D mega_allocate_inquiry(&dma_handle, pdev)) =3D=3D NULL ) =
{
-		free_local_pdev(pdev);
 		*eof =3D 1;
 		return len;
 	}
@@ -2357,8 +2353,6 @@
=20
 		mega_free_inquiry(inquiry, dma_handle, pdev);
=20
-		free_local_pdev(pdev);
-
 		*eof =3D 1;
=20
 		return len;
@@ -2377,8 +2371,6 @@
=20
 	mega_free_inquiry(inquiry, dma_handle, pdev);
=20
-	free_local_pdev(pdev);
-
 	*eof =3D 1;
=20
 	return len;
@@ -2408,13 +2400,9 @@
 	char	str[256];
 	int	len =3D 0;
=20
-	if( make_local_pdev(adapter, &pdev) !=3D 0 ) {
-		*eof =3D 1;
-		return len;
-	}
+	pdev =3D adapter->dev;
=20
 	if( (inquiry =3D mega_allocate_inquiry(&dma_handle, pdev)) =3D=3D NULL ) =
{
-		free_local_pdev(pdev);
 		*eof =3D 1;
 		return len;
 	}
@@ -2427,8 +2415,6 @@
=20
 		mega_free_inquiry(inquiry, dma_handle, pdev);
=20
-		free_local_pdev(pdev);
-
 		*eof =3D 1;
=20
 		return len;
@@ -2476,8 +2462,6 @@
=20
 	mega_free_inquiry(inquiry, dma_handle, pdev);
=20
-	free_local_pdev(pdev);
-
 	*eof =3D 1;
=20
 	return len;
@@ -2599,12 +2583,9 @@
 	char	str[80];
 	int	i;
=20
-	if( make_local_pdev(adapter, &pdev) !=3D 0 ) {
-		return len;
-	}
+	pdev =3D adapter->dev;
=20
 	if( (inquiry =3D mega_allocate_inquiry(&dma_handle, pdev)) =3D=3D NULL ) =
{
-		free_local_pdev(pdev);
 		return len;
 	}
=20
@@ -2616,8 +2597,6 @@
=20
 		mega_free_inquiry(inquiry, dma_handle, pdev);
=20
-		free_local_pdev(pdev);
-
 		return len;
 	}
=20
@@ -2629,8 +2608,6 @@
=20
 		mega_free_inquiry(inquiry, dma_handle, pdev);
=20
-		free_local_pdev(pdev);
-
 		return len;
 	}
=20
@@ -2713,8 +2690,6 @@
=20
 	mega_free_inquiry(inquiry, dma_handle, pdev);
=20
-	free_local_pdev(pdev);
-
 	return len;
 }
=20
@@ -2883,12 +2858,9 @@
 	int	len =3D 0;
 	int	i;
=20
-	if( make_local_pdev(adapter, &pdev) !=3D 0 ) {
-		return len;
-	}
+	pdev =3D adapter->dev;
=20
 	if( (inquiry =3D mega_allocate_inquiry(&dma_handle, pdev)) =3D=3D NULL ) =
{
-		free_local_pdev(pdev);
 		return len;
 	}
=20
@@ -2900,8 +2872,6 @@
=20
 		mega_free_inquiry(inquiry, dma_handle, pdev);
=20
-		free_local_pdev(pdev);
-
 		return len;
 	}
=20
@@ -2932,8 +2902,6 @@
=20
 		mega_free_inquiry(inquiry, dma_handle, pdev);
=20
-		free_local_pdev(pdev);
-
 		return len;
 	}
=20
@@ -2952,8 +2920,6 @@
 			pci_free_consistent(pdev, array_sz, disk_array,
 					disk_array_dma_handle);
=20
-			free_local_pdev(pdev);
-
 			return len;
 		}
=20
@@ -2977,8 +2943,6 @@
 						disk_array,
 						disk_array_dma_handle);
=20
-				free_local_pdev(pdev);
-
 				return len;
 			}
 		}
@@ -3103,8 +3067,6 @@
 	pci_free_consistent(pdev, array_sz, disk_array,
 			disk_array_dma_handle);
=20
-	free_local_pdev(pdev);
-
 	return len;
 }
=20
@@ -3478,8 +3440,7 @@
 		 * For all internal commands, the buffer must be allocated in
 		 * <4GB address range
 		 */
-		if( make_local_pdev(adapter, &pdev) !=3D 0 )
-			return -EIO;
+		pdev =3D adapter->dev;
=20
 		/* Is it a passthru command or a DCMD */
 		if( uioc.uioc_rmbox[0] =3D=3D MEGA_MBOXCMD_PASSTHRU ) {
@@ -3490,7 +3451,6 @@
 					&pthru_dma_hndl);
=20
 			if( pthru =3D=3D NULL ) {
-				free_local_pdev(pdev);
 				return (-ENOMEM);
 			}
=20
@@ -3509,8 +3469,6 @@
 						sizeof(mega_passthru), pthru,
 						pthru_dma_hndl);
=20
-				free_local_pdev(pdev);
-
 				return (-EFAULT);
 			}
=20
@@ -3528,8 +3486,6 @@
 							pthru,
 							pthru_dma_hndl);
=20
-					free_local_pdev(pdev);
-
 					return (-ENOMEM);
 				}
=20
@@ -3598,8 +3554,6 @@
 			pci_free_consistent(pdev, sizeof(mega_passthru),
 					pthru, pthru_dma_hndl);
=20
-			free_local_pdev(pdev);
-
 			return rval;
 		}
 		else {
@@ -3613,7 +3567,6 @@
 						uioc.xferlen, &data_dma_hndl);
=20
 				if( data =3D=3D NULL ) {
-					free_local_pdev(pdev);
 					return (-ENOMEM);
 				}
=20
@@ -3634,8 +3587,6 @@
 							uioc.xferlen,
 							data, data_dma_hndl);
=20
-					free_local_pdev(pdev);
-
 					return (-EFAULT);
 				}
 			}
@@ -3658,8 +3609,6 @@
 							data_dma_hndl);
 				}
=20
-				free_local_pdev(pdev);
-
 				return rval;
 			}
=20
@@ -3680,8 +3629,6 @@
 						data_dma_hndl);
 			}
=20
-			free_local_pdev(pdev);
-
 			return rval;
 		}
=20
@@ -4413,13 +4360,12 @@
 	 * For all internal commands, the buffer must be allocated in <4GB
 	 * address range
 	 */
-	if( make_local_pdev(adapter, &pdev) !=3D 0 ) return -1;
+	pdev =3D adapter->dev;
=20
 	pthru =3D pci_alloc_consistent(pdev, sizeof(mega_passthru),
 			&pthru_dma_handle);
=20
 	if( pthru =3D=3D NULL ) {
-		free_local_pdev(pdev);
 		return -1;
 	}
=20
@@ -4455,8 +4401,6 @@
 	pci_free_consistent(pdev, sizeof(mega_passthru), pthru,
 			pthru_dma_handle);
=20
-	free_local_pdev(pdev);
-
 	return rval;
 }
=20
@@ -4590,29 +4534,6 @@
 }
=20
=20
-static inline int
-make_local_pdev(adapter_t *adapter, struct pci_dev **pdev)
-{
-	*pdev =3D kmalloc(sizeof(struct pci_dev), GFP_KERNEL);
-
-	if( *pdev =3D=3D NULL ) return -1;
-
-	memcpy(*pdev, adapter->dev, sizeof(struct pci_dev));
-
-	if( pci_set_dma_mask(*pdev, 0xffffffff) !=3D 0 ) {
-		kfree(*pdev);
-		return -1;
-	}
-
-	return 0;
-}
-
-static inline void
-free_local_pdev(struct pci_dev *pdev)
-{
-	kfree(pdev);
-}
-
 static struct scsi_host_template megaraid_template =3D {
 	.module				=3D THIS_MODULE,
 	.name				=3D "MegaRAID",
diff --recursive --ignore-all-space --unified linux-2.6.2.o/drivers/scsi/me=
garaid.h linux-2.6.2.megaraid/drivers/scsi/megaraid.h
--- linux-2.6.2.o/drivers/scsi/megaraid.h	2004-02-20 00:40:05.000000000 +01=
00
+++ linux-2.6.2.megaraid/drivers/scsi/megaraid.h	2004-02-20 01:32:30.000000=
000 +0100
@@ -1055,8 +1055,6 @@
 static int mega_internal_dev_inquiry(adapter_t *, u8, u8, dma_addr_t);
 static inline caddr_t mega_allocate_inquiry(dma_addr_t *, struct pci_dev *=
);
 static inline void mega_free_inquiry(caddr_t, dma_addr_t, struct pci_dev *=
);
-static inline int make_local_pdev(adapter_t *, struct pci_dev **);
-static inline void free_local_pdev(struct pci_dev *);
=20
 static int mega_support_ext_cdb(adapter_t *);
 static mega_passthru* mega_prepare_passthru(adapter_t *, scb_t *,


--=-Fz9ImZs8zD42RZMKAbnb
Content-Disposition: attachment; filename=3-megaraid.pdev.patch
Content-Type: text/x-patch; name=3-megaraid.pdev.patch; charset=UTF-8
Content-Transfer-Encoding: base64

ZGlmZiAtLXJlY3Vyc2l2ZSAtLWlnbm9yZS1hbGwtc3BhY2UgLS11bmlmaWVkIGxpbnV4LTIuNi4y
Lm8vZHJpdmVycy9zY3NpL21lZ2FyYWlkLmMgbGludXgtMi42LjIubWVnYXJhaWQvZHJpdmVycy9z
Y3NpL21lZ2FyYWlkLmMNCi0tLSBsaW51eC0yLjYuMi5vL2RyaXZlcnMvc2NzaS9tZWdhcmFpZC5j
CTIwMDQtMDItMjAgMDE6MzI6MjYuMDAwMDAwMDAwICswMTAwDQorKysgbGludXgtMi42LjIubWVn
YXJhaWQvZHJpdmVycy9zY3NpL21lZ2FyYWlkLmMJMjAwNC0wMi0yMCAwMTozMjozMC4wMDAwMDAw
MDAgKzAxMDANCkBAIC0yMzM4LDEzICsyMzM4LDkgQEANCiAJc3RydWN0IHBjaV9kZXYJKnBkZXY7
DQogCWludAlsZW4gPSAwOw0KIA0KLQlpZiggbWFrZV9sb2NhbF9wZGV2KGFkYXB0ZXIsICZwZGV2
KSAhPSAwICkgew0KLQkJKmVvZiA9IDE7DQotCQlyZXR1cm4gbGVuOw0KLQl9DQorCXBkZXYgPSBh
ZGFwdGVyLT5kZXY7DQogDQogCWlmKCAoaW5xdWlyeSA9IG1lZ2FfYWxsb2NhdGVfaW5xdWlyeSgm
ZG1hX2hhbmRsZSwgcGRldikpID09IE5VTEwgKSB7DQotCQlmcmVlX2xvY2FsX3BkZXYocGRldik7
DQogCQkqZW9mID0gMTsNCiAJCXJldHVybiBsZW47DQogCX0NCkBAIC0yMzU3LDggKzIzNTMsNiBA
QA0KIA0KIAkJbWVnYV9mcmVlX2lucXVpcnkoaW5xdWlyeSwgZG1hX2hhbmRsZSwgcGRldik7DQog
DQotCQlmcmVlX2xvY2FsX3BkZXYocGRldik7DQotDQogCQkqZW9mID0gMTsNCiANCiAJCXJldHVy
biBsZW47DQpAQCAtMjM3Nyw4ICsyMzcxLDYgQEANCiANCiAJbWVnYV9mcmVlX2lucXVpcnkoaW5x
dWlyeSwgZG1hX2hhbmRsZSwgcGRldik7DQogDQotCWZyZWVfbG9jYWxfcGRldihwZGV2KTsNCi0N
CiAJKmVvZiA9IDE7DQogDQogCXJldHVybiBsZW47DQpAQCAtMjQwOCwxMyArMjQwMCw5IEBADQog
CWNoYXIJc3RyWzI1Nl07DQogCWludAlsZW4gPSAwOw0KIA0KLQlpZiggbWFrZV9sb2NhbF9wZGV2
KGFkYXB0ZXIsICZwZGV2KSAhPSAwICkgew0KLQkJKmVvZiA9IDE7DQotCQlyZXR1cm4gbGVuOw0K
LQl9DQorCXBkZXYgPSBhZGFwdGVyLT5kZXY7DQogDQogCWlmKCAoaW5xdWlyeSA9IG1lZ2FfYWxs
b2NhdGVfaW5xdWlyeSgmZG1hX2hhbmRsZSwgcGRldikpID09IE5VTEwgKSB7DQotCQlmcmVlX2xv
Y2FsX3BkZXYocGRldik7DQogCQkqZW9mID0gMTsNCiAJCXJldHVybiBsZW47DQogCX0NCkBAIC0y
NDI3LDggKzI0MTUsNiBAQA0KIA0KIAkJbWVnYV9mcmVlX2lucXVpcnkoaW5xdWlyeSwgZG1hX2hh
bmRsZSwgcGRldik7DQogDQotCQlmcmVlX2xvY2FsX3BkZXYocGRldik7DQotDQogCQkqZW9mID0g
MTsNCiANCiAJCXJldHVybiBsZW47DQpAQCAtMjQ3Niw4ICsyNDYyLDYgQEANCiANCiAJbWVnYV9m
cmVlX2lucXVpcnkoaW5xdWlyeSwgZG1hX2hhbmRsZSwgcGRldik7DQogDQotCWZyZWVfbG9jYWxf
cGRldihwZGV2KTsNCi0NCiAJKmVvZiA9IDE7DQogDQogCXJldHVybiBsZW47DQpAQCAtMjU5OSwx
MiArMjU4Myw5IEBADQogCWNoYXIJc3RyWzgwXTsNCiAJaW50CWk7DQogDQotCWlmKCBtYWtlX2xv
Y2FsX3BkZXYoYWRhcHRlciwgJnBkZXYpICE9IDAgKSB7DQotCQlyZXR1cm4gbGVuOw0KLQl9DQor
CXBkZXYgPSBhZGFwdGVyLT5kZXY7DQogDQogCWlmKCAoaW5xdWlyeSA9IG1lZ2FfYWxsb2NhdGVf
aW5xdWlyeSgmZG1hX2hhbmRsZSwgcGRldikpID09IE5VTEwgKSB7DQotCQlmcmVlX2xvY2FsX3Bk
ZXYocGRldik7DQogCQlyZXR1cm4gbGVuOw0KIAl9DQogDQpAQCAtMjYxNiw4ICsyNTk3LDYgQEAN
CiANCiAJCW1lZ2FfZnJlZV9pbnF1aXJ5KGlucXVpcnksIGRtYV9oYW5kbGUsIHBkZXYpOw0KIA0K
LQkJZnJlZV9sb2NhbF9wZGV2KHBkZXYpOw0KLQ0KIAkJcmV0dXJuIGxlbjsNCiAJfQ0KIA0KQEAg
LTI2MjksOCArMjYwOCw2IEBADQogDQogCQltZWdhX2ZyZWVfaW5xdWlyeShpbnF1aXJ5LCBkbWFf
aGFuZGxlLCBwZGV2KTsNCiANCi0JCWZyZWVfbG9jYWxfcGRldihwZGV2KTsNCi0NCiAJCXJldHVy
biBsZW47DQogCX0NCiANCkBAIC0yNzEzLDggKzI2OTAsNiBAQA0KIA0KIAltZWdhX2ZyZWVfaW5x
dWlyeShpbnF1aXJ5LCBkbWFfaGFuZGxlLCBwZGV2KTsNCiANCi0JZnJlZV9sb2NhbF9wZGV2KHBk
ZXYpOw0KLQ0KIAlyZXR1cm4gbGVuOw0KIH0NCiANCkBAIC0yODgzLDEyICsyODU4LDkgQEANCiAJ
aW50CWxlbiA9IDA7DQogCWludAlpOw0KIA0KLQlpZiggbWFrZV9sb2NhbF9wZGV2KGFkYXB0ZXIs
ICZwZGV2KSAhPSAwICkgew0KLQkJcmV0dXJuIGxlbjsNCi0JfQ0KKwlwZGV2ID0gYWRhcHRlci0+
ZGV2Ow0KIA0KIAlpZiggKGlucXVpcnkgPSBtZWdhX2FsbG9jYXRlX2lucXVpcnkoJmRtYV9oYW5k
bGUsIHBkZXYpKSA9PSBOVUxMICkgew0KLQkJZnJlZV9sb2NhbF9wZGV2KHBkZXYpOw0KIAkJcmV0
dXJuIGxlbjsNCiAJfQ0KIA0KQEAgLTI5MDAsOCArMjg3Miw2IEBADQogDQogCQltZWdhX2ZyZWVf
aW5xdWlyeShpbnF1aXJ5LCBkbWFfaGFuZGxlLCBwZGV2KTsNCiANCi0JCWZyZWVfbG9jYWxfcGRl
dihwZGV2KTsNCi0NCiAJCXJldHVybiBsZW47DQogCX0NCiANCkBAIC0yOTMyLDggKzI5MDIsNiBA
QA0KIA0KIAkJbWVnYV9mcmVlX2lucXVpcnkoaW5xdWlyeSwgZG1hX2hhbmRsZSwgcGRldik7DQog
DQotCQlmcmVlX2xvY2FsX3BkZXYocGRldik7DQotDQogCQlyZXR1cm4gbGVuOw0KIAl9DQogDQpA
QCAtMjk1Miw4ICsyOTIwLDYgQEANCiAJCQlwY2lfZnJlZV9jb25zaXN0ZW50KHBkZXYsIGFycmF5
X3N6LCBkaXNrX2FycmF5LA0KIAkJCQkJZGlza19hcnJheV9kbWFfaGFuZGxlKTsNCiANCi0JCQlm
cmVlX2xvY2FsX3BkZXYocGRldik7DQotDQogCQkJcmV0dXJuIGxlbjsNCiAJCX0NCiANCkBAIC0y
OTc3LDggKzI5NDMsNiBAQA0KIAkJCQkJCWRpc2tfYXJyYXksDQogCQkJCQkJZGlza19hcnJheV9k
bWFfaGFuZGxlKTsNCiANCi0JCQkJZnJlZV9sb2NhbF9wZGV2KHBkZXYpOw0KLQ0KIAkJCQlyZXR1
cm4gbGVuOw0KIAkJCX0NCiAJCX0NCkBAIC0zMTAzLDggKzMwNjcsNiBAQA0KIAlwY2lfZnJlZV9j
b25zaXN0ZW50KHBkZXYsIGFycmF5X3N6LCBkaXNrX2FycmF5LA0KIAkJCWRpc2tfYXJyYXlfZG1h
X2hhbmRsZSk7DQogDQotCWZyZWVfbG9jYWxfcGRldihwZGV2KTsNCi0NCiAJcmV0dXJuIGxlbjsN
CiB9DQogDQpAQCAtMzQ3OCw4ICszNDQwLDcgQEANCiAJCSAqIEZvciBhbGwgaW50ZXJuYWwgY29t
bWFuZHMsIHRoZSBidWZmZXIgbXVzdCBiZSBhbGxvY2F0ZWQgaW4NCiAJCSAqIDw0R0IgYWRkcmVz
cyByYW5nZQ0KIAkJICovDQotCQlpZiggbWFrZV9sb2NhbF9wZGV2KGFkYXB0ZXIsICZwZGV2KSAh
PSAwICkNCi0JCQlyZXR1cm4gLUVJTzsNCisJCXBkZXYgPSBhZGFwdGVyLT5kZXY7DQogDQogCQkv
KiBJcyBpdCBhIHBhc3N0aHJ1IGNvbW1hbmQgb3IgYSBEQ01EICovDQogCQlpZiggdWlvYy51aW9j
X3JtYm94WzBdID09IE1FR0FfTUJPWENNRF9QQVNTVEhSVSApIHsNCkBAIC0zNDkwLDcgKzM0NTEs
NiBAQA0KIAkJCQkJJnB0aHJ1X2RtYV9obmRsKTsNCiANCiAJCQlpZiggcHRocnUgPT0gTlVMTCAp
IHsNCi0JCQkJZnJlZV9sb2NhbF9wZGV2KHBkZXYpOw0KIAkJCQlyZXR1cm4gKC1FTk9NRU0pOw0K
IAkJCX0NCiANCkBAIC0zNTA5LDggKzM0NjksNiBAQA0KIAkJCQkJCXNpemVvZihtZWdhX3Bhc3N0
aHJ1KSwgcHRocnUsDQogCQkJCQkJcHRocnVfZG1hX2huZGwpOw0KIA0KLQkJCQlmcmVlX2xvY2Fs
X3BkZXYocGRldik7DQotDQogCQkJCXJldHVybiAoLUVGQVVMVCk7DQogCQkJfQ0KIA0KQEAgLTM1
MjgsOCArMzQ4Niw2IEBADQogCQkJCQkJCXB0aHJ1LA0KIAkJCQkJCQlwdGhydV9kbWFfaG5kbCk7
DQogDQotCQkJCQlmcmVlX2xvY2FsX3BkZXYocGRldik7DQotDQogCQkJCQlyZXR1cm4gKC1FTk9N
RU0pOw0KIAkJCQl9DQogDQpAQCAtMzU5OCw4ICszNTU0LDYgQEANCiAJCQlwY2lfZnJlZV9jb25z
aXN0ZW50KHBkZXYsIHNpemVvZihtZWdhX3Bhc3N0aHJ1KSwNCiAJCQkJCXB0aHJ1LCBwdGhydV9k
bWFfaG5kbCk7DQogDQotCQkJZnJlZV9sb2NhbF9wZGV2KHBkZXYpOw0KLQ0KIAkJCXJldHVybiBy
dmFsOw0KIAkJfQ0KIAkJZWxzZSB7DQpAQCAtMzYxMyw3ICszNTY3LDYgQEANCiAJCQkJCQl1aW9j
LnhmZXJsZW4sICZkYXRhX2RtYV9obmRsKTsNCiANCiAJCQkJaWYoIGRhdGEgPT0gTlVMTCApIHsN
Ci0JCQkJCWZyZWVfbG9jYWxfcGRldihwZGV2KTsNCiAJCQkJCXJldHVybiAoLUVOT01FTSk7DQog
CQkJCX0NCiANCkBAIC0zNjM0LDggKzM1ODcsNiBAQA0KIAkJCQkJCQl1aW9jLnhmZXJsZW4sDQog
CQkJCQkJCWRhdGEsIGRhdGFfZG1hX2huZGwpOw0KIA0KLQkJCQkJZnJlZV9sb2NhbF9wZGV2KHBk
ZXYpOw0KLQ0KIAkJCQkJcmV0dXJuICgtRUZBVUxUKTsNCiAJCQkJfQ0KIAkJCX0NCkBAIC0zNjU4
LDggKzM2MDksNiBAQA0KIAkJCQkJCQlkYXRhX2RtYV9obmRsKTsNCiAJCQkJfQ0KIA0KLQkJCQlm
cmVlX2xvY2FsX3BkZXYocGRldik7DQotDQogCQkJCXJldHVybiBydmFsOw0KIAkJCX0NCiANCkBA
IC0zNjgwLDggKzM2MjksNiBAQA0KIAkJCQkJCWRhdGFfZG1hX2huZGwpOw0KIAkJCX0NCiANCi0J
CQlmcmVlX2xvY2FsX3BkZXYocGRldik7DQotDQogCQkJcmV0dXJuIHJ2YWw7DQogCQl9DQogDQpA
QCAtNDQxMywxMyArNDM2MCwxMiBAQA0KIAkgKiBGb3IgYWxsIGludGVybmFsIGNvbW1hbmRzLCB0
aGUgYnVmZmVyIG11c3QgYmUgYWxsb2NhdGVkIGluIDw0R0INCiAJICogYWRkcmVzcyByYW5nZQ0K
IAkgKi8NCi0JaWYoIG1ha2VfbG9jYWxfcGRldihhZGFwdGVyLCAmcGRldikgIT0gMCApIHJldHVy
biAtMTsNCisJcGRldiA9IGFkYXB0ZXItPmRldjsNCiANCiAJcHRocnUgPSBwY2lfYWxsb2NfY29u
c2lzdGVudChwZGV2LCBzaXplb2YobWVnYV9wYXNzdGhydSksDQogCQkJJnB0aHJ1X2RtYV9oYW5k
bGUpOw0KIA0KIAlpZiggcHRocnUgPT0gTlVMTCApIHsNCi0JCWZyZWVfbG9jYWxfcGRldihwZGV2
KTsNCiAJCXJldHVybiAtMTsNCiAJfQ0KIA0KQEAgLTQ0NTUsOCArNDQwMSw2IEBADQogCXBjaV9m
cmVlX2NvbnNpc3RlbnQocGRldiwgc2l6ZW9mKG1lZ2FfcGFzc3RocnUpLCBwdGhydSwNCiAJCQlw
dGhydV9kbWFfaGFuZGxlKTsNCiANCi0JZnJlZV9sb2NhbF9wZGV2KHBkZXYpOw0KLQ0KIAlyZXR1
cm4gcnZhbDsNCiB9DQogDQpAQCAtNDU5MCwyOSArNDUzNCw2IEBADQogfQ0KIA0KIA0KLXN0YXRp
YyBpbmxpbmUgaW50DQotbWFrZV9sb2NhbF9wZGV2KGFkYXB0ZXJfdCAqYWRhcHRlciwgc3RydWN0
IHBjaV9kZXYgKipwZGV2KQ0KLXsNCi0JKnBkZXYgPSBrbWFsbG9jKHNpemVvZihzdHJ1Y3QgcGNp
X2RldiksIEdGUF9LRVJORUwpOw0KLQ0KLQlpZiggKnBkZXYgPT0gTlVMTCApIHJldHVybiAtMTsN
Ci0NCi0JbWVtY3B5KCpwZGV2LCBhZGFwdGVyLT5kZXYsIHNpemVvZihzdHJ1Y3QgcGNpX2Rldikp
Ow0KLQ0KLQlpZiggcGNpX3NldF9kbWFfbWFzaygqcGRldiwgMHhmZmZmZmZmZikgIT0gMCApIHsN
Ci0JCWtmcmVlKCpwZGV2KTsNCi0JCXJldHVybiAtMTsNCi0JfQ0KLQ0KLQlyZXR1cm4gMDsNCi19
DQotDQotc3RhdGljIGlubGluZSB2b2lkDQotZnJlZV9sb2NhbF9wZGV2KHN0cnVjdCBwY2lfZGV2
ICpwZGV2KQ0KLXsNCi0Ja2ZyZWUocGRldik7DQotfQ0KLQ0KIHN0YXRpYyBzdHJ1Y3Qgc2NzaV9o
b3N0X3RlbXBsYXRlIG1lZ2FyYWlkX3RlbXBsYXRlID0gew0KIAkubW9kdWxlCQkJCT0gVEhJU19N
T0RVTEUsDQogCS5uYW1lCQkJCT0gIk1lZ2FSQUlEIiwNCmRpZmYgLS1yZWN1cnNpdmUgLS1pZ25v
cmUtYWxsLXNwYWNlIC0tdW5pZmllZCBsaW51eC0yLjYuMi5vL2RyaXZlcnMvc2NzaS9tZWdhcmFp
ZC5oIGxpbnV4LTIuNi4yLm1lZ2FyYWlkL2RyaXZlcnMvc2NzaS9tZWdhcmFpZC5oDQotLS0gbGlu
dXgtMi42LjIuby9kcml2ZXJzL3Njc2kvbWVnYXJhaWQuaAkyMDA0LTAyLTIwIDAwOjQwOjA1LjAw
MDAwMDAwMCArMDEwMA0KKysrIGxpbnV4LTIuNi4yLm1lZ2FyYWlkL2RyaXZlcnMvc2NzaS9tZWdh
cmFpZC5oCTIwMDQtMDItMjAgMDE6MzI6MzAuMDAwMDAwMDAwICswMTAwDQpAQCAtMTA1NSw4ICsx
MDU1LDYgQEANCiBzdGF0aWMgaW50IG1lZ2FfaW50ZXJuYWxfZGV2X2lucXVpcnkoYWRhcHRlcl90
ICosIHU4LCB1OCwgZG1hX2FkZHJfdCk7DQogc3RhdGljIGlubGluZSBjYWRkcl90IG1lZ2FfYWxs
b2NhdGVfaW5xdWlyeShkbWFfYWRkcl90ICosIHN0cnVjdCBwY2lfZGV2ICopOw0KIHN0YXRpYyBp
bmxpbmUgdm9pZCBtZWdhX2ZyZWVfaW5xdWlyeShjYWRkcl90LCBkbWFfYWRkcl90LCBzdHJ1Y3Qg
cGNpX2RldiAqKTsNCi1zdGF0aWMgaW5saW5lIGludCBtYWtlX2xvY2FsX3BkZXYoYWRhcHRlcl90
ICosIHN0cnVjdCBwY2lfZGV2ICoqKTsNCi1zdGF0aWMgaW5saW5lIHZvaWQgZnJlZV9sb2NhbF9w
ZGV2KHN0cnVjdCBwY2lfZGV2ICopOw0KIA0KIHN0YXRpYyBpbnQgbWVnYV9zdXBwb3J0X2V4dF9j
ZGIoYWRhcHRlcl90ICopOw0KIHN0YXRpYyBtZWdhX3Bhc3N0aHJ1KiBtZWdhX3ByZXBhcmVfcGFz
c3RocnUoYWRhcHRlcl90ICosIHNjYl90ICosDQo=

--=-Fz9ImZs8zD42RZMKAbnb--

--=-9pyMzlPfstJiTnotuj9L
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBANWvwtch0EvEFvxURArfQAKDKl/Ac5ea+AA1cJKTN2iZ5pV2S5gCfTgLU
URtJBMWfMuOaHycJhqaPmf4=
=shIK
-----END PGP SIGNATURE-----

--=-9pyMzlPfstJiTnotuj9L--

