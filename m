Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266535AbSLDNGS>; Wed, 4 Dec 2002 08:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266540AbSLDNF6>; Wed, 4 Dec 2002 08:05:58 -0500
Received: from [211.167.76.68] ([211.167.76.68]:14756 "HELO soulinfo")
	by vger.kernel.org with SMTP id <S266535AbSLDNFn>;
	Wed, 4 Dec 2002 08:05:43 -0500
Date: Wed, 4 Dec 2002 21:10:55 +0800
From: hugang <hugang@soulinfo.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [IDE-PATCH] Add piix fix up function into pii.c
Message-Id: <20021204211055.185221c0.hugang@soulinfo.com>
X-Mailer: Sylpheed version 0.8.5claws126 (GTK+ 1.2.10; )
Mime-Version: 1.0
=?ISO-8859-1?Q?=CA=D5=BC=FE=C8=CB=A3=BA: ?= Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.Odo:8wTM).,ivF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.Odo:8wTM).,ivF
Content-Type: multipart/mixed;
 boundary="Multipart_Wed__4_Dec_2002_21:10:55_+0800_08391700"


--Multipart_Wed__4_Dec_2002_21:10:55_+0800_08391700
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello all:

Please apply.
Index: drivers/ide//pci/piix.c
===================================================================
RCS file: /home/hugang/local/cvs/2.4/drivers/ide/pci/piix.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 piix.c
--- drivers/ide//pci/piix.c	28 Nov 2002 06:41:20 -0000	1.1.1.2
+++ drivers/ide//pci/piix.c	4 Dec 2002 13:02:36 -0000
@@ -652,6 +652,27 @@
  
 static void __init init_setup_piix (struct pci_dev *dev, ide_pci_device_t *d)
 {
+	int i;
+	unsigned short cmd;
+	unsigned long flags;
+	unsigned long base_address[4] = { 0x1f0, 0x3f4, 0x170, 0x374 };
+
+	printk(KERN_INFO "PIIX: fixup IDE controller\n");
+	local_irq_save(flags);
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	pci_write_config_word(dev, PCI_COMMAND, cmd & ~PCI_COMMAND_IO);
+	
+	for (i=0; i<4; i++) {
+		dev->resource[i].start = base_address[i];
+		dev->resource[i].flags |= PCI_BASE_ADDRESS_SPACE_IO;
+		pci_write_config_dword(dev,
+				       (PCI_BASE_ADDRESS_0 + (i * 4)),
+				       dev->resource[i].start);
+	}
+	
+	pci_write_config_word(dev, PCI_COMMAND, cmd);
+	local_irq_restore(flags);
+	
 	ide_setup_pci_device(dev, d);
 }
 


-- 
		- Hu Gang

--Multipart_Wed__4_Dec_2002_21:10:55_+0800_08391700
Content-Type: application/octet-stream;
 name="2.5.gz"
Content-Disposition: attachment;
 filename="2.5.gz"
Content-Transfer-Encoding: base64

H4sICMH97T0AAzIuNQClUmFP2zAQ/Zz8iic+oJY0TRqyMoV1atcWKZooiH6ZxJCVxU6xFuLOTkIl
xn77LmnHYICmaU7kS8537967c1xwsYnAtayFNp7kwvPWqfTWUm76qT36/2VfTJfIZC4ieNfqRnjX
1SopVl6u0iT30tp4QT/0HhP4Xb9X21qUWopaFitoMkaqAoN+8wQ2l1kGt4Krdx7saLuu+5okK3iL
haoR+H4AfxiFgyjw4fq0rF+4juO8mh5iJtJt9uAw8oPocLjNtsdjuMM3QW8IpzHBEcZjG7BhyqSU
KWolORiThSzRbMyIslqzBhcdU+oqLUGFGBc1DmjrgWqznUemgpXk7tq4sx1LFoRxTB9VYeSqEBzm
WukS6Q1/4s0V9S3Lk5V57v6SGMESzrUw5jK8wgh38DeDzO+ROczCxgyOtn9HIe4JgTDWmmp/7Xyc
XyxYvDg5w955HH+KaMKbao14NkeqilKrPBf6c7HXbeq2o2ZSf2MmqUWn5dMeNOK0SDijnEyu2K3S
vNNKP5/GbHp2ejpZzHrYJ1kP8bdaluIvCRSPffx45GPxWYtAb6Y0OnLkH0O+C2lznG7bU4tw3PfU
DVXpVFzKqz4Njno6etopeXX8YnCrCt9HLZMPk+WcTWazi/lyyZbnk+mcCLR5zyTwBw3NsWVhuzrP
YHw4xBsHCLvdp7EvE2/13m81/0Pj/pgYwZZKPx6aDau5mLvb+3A9t2hNOu5t2D8B/Tqn2lkEAAA=

--Multipart_Wed__4_Dec_2002_21:10:55_+0800_08391700--

--=.Odo:8wTM).,ivF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iEUEARECAAYFAj3t/uIACgkQpsLEGIbIYQ4mQgCY8Jy4JOa62k96k7eftL+qZFm4
wwCeJIkcEubMpDFBRzUJqP6bOI56nEc=
=leK0
-----END PGP SIGNATURE-----

--=.Odo:8wTM).,ivF--
