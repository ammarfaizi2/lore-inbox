Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264569AbTFKWTZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 18:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264601AbTFKWTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 18:19:25 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:29827 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264569AbTFKWTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 18:19:21 -0400
Date: Wed, 11 Jun 2003 19:32:21 -0300
From: Eduardo Pereira Habkost <ehabkost@conectiva.com.br>
To: "Michael H. Warfield" <mhw@wittsend.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][2.5] Fix compilation of ip2main
Message-ID: <20030611223221.GW4639@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PhxIMoEr374zxJm2"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PhxIMoEr374zxJm2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following patch fix compilation of drivers/char/ip2main.c. It was
broken by the removal of pci_present().

It just adds open and closing braces around the code that declares the
pci_dev_i variable. The rest of the patch just change the indentation.

--
Eduardo


diff -Nru a/drivers/char/ip2main.c b/drivers/char/ip2main.c
--- a/drivers/char/ip2main.c	Wed Jun 11 19:18:27 2003
+++ b/drivers/char/ip2main.c	Wed Jun 11 19:18:27 2003
@@ -691,40 +691,42 @@
 				}=20
 			}=20
 #else /* LINUX_VERSION_CODE > 2.1.99 */
-			struct pci_dev *pci_dev_i =3D NULL;
-			pci_dev_i =3D pci_find_device(PCI_VENDOR_ID_COMPUTONE,
-						  PCI_DEVICE_ID_COMPUTONE_IP2EX, pci_dev_i);
-			if (pci_dev_i !=3D NULL) {
-				unsigned int addr;
-				unsigned char pci_irq;
+			{
+				struct pci_dev *pci_dev_i =3D NULL;
+				pci_dev_i =3D pci_find_device(PCI_VENDOR_ID_COMPUTONE,
+							  PCI_DEVICE_ID_COMPUTONE_IP2EX, pci_dev_i);
+				if (pci_dev_i !=3D NULL) {
+					unsigned int addr;
+					unsigned char pci_irq;
=20
-				ip2config.type[i] =3D PCI;
-				status =3D
-				pci_read_config_dword(pci_dev_i, PCI_BASE_ADDRESS_1, &addr);
-				if ( addr & 1 ) {
-					ip2config.addr[i]=3D(USHORT)(addr&0xfffe);
-				} else {
-					printk( KERN_ERR "IP2: PCI I/O address error\n");
-				}
-				status =3D
-				pci_read_config_byte(pci_dev_i, PCI_INTERRUPT_LINE, &pci_irq);
+					ip2config.type[i] =3D PCI;
+					status =3D
+					pci_read_config_dword(pci_dev_i, PCI_BASE_ADDRESS_1, &addr);
+					if ( addr & 1 ) {
+						ip2config.addr[i]=3D(USHORT)(addr&0xfffe);
+					} else {
+						printk( KERN_ERR "IP2: PCI I/O address error\n");
+					}
+					status =3D
+					pci_read_config_byte(pci_dev_i, PCI_INTERRUPT_LINE, &pci_irq);
=20
 //		If the PCI BIOS assigned it, lets try and use it.  If we
 //		can't acquire it or it screws up, deal with it then.
=20
-//				if (!is_valid_irq(pci_irq)) {
-//					printk( KERN_ERR "IP2: Bad PCI BIOS IRQ(%d)\n",pci_irq);
-//					pci_irq =3D 0;
-//				}
-				ip2config.irq[i] =3D pci_irq;
-			} else {	// ann error
-				ip2config.addr[i] =3D 0;
-				if (status =3D=3D PCIBIOS_DEVICE_NOT_FOUND) {
-					printk( KERN_ERR "IP2: PCI board %d not found\n", i );
-				} else {
-					pcibios_strerror(status);
-				}
-			}=20
+//					if (!is_valid_irq(pci_irq)) {
+//						printk( KERN_ERR "IP2: Bad PCI BIOS IRQ(%d)\n",pci_irq);
+//						pci_irq =3D 0;
+//					}
+					ip2config.irq[i] =3D pci_irq;
+				} else {	// ann error
+					ip2config.addr[i] =3D 0;
+					if (status =3D=3D PCIBIOS_DEVICE_NOT_FOUND) {
+						printk( KERN_ERR "IP2: PCI board %d not found\n", i );
+					} else {
+						pcibios_strerror(status);
+					}
+				}=20
+			}
 #endif	/* ! 2_0_X */
 #else
 			printk( KERN_ERR "IP2: PCI card specified but PCI support not\n");

--PhxIMoEr374zxJm2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+5631caRJ66w1lWgRAhaoAJ4vpholzXMXpfoisUDtkR8pEu9ldwCgoVHj
CZzrZCzBE8crqDImUC+/cw8=
=h5hu
-----END PGP SIGNATURE-----

--PhxIMoEr374zxJm2--
