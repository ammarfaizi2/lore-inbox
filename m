Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129772AbRB0TYG>; Tue, 27 Feb 2001 14:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129774AbRB0TX4>; Tue, 27 Feb 2001 14:23:56 -0500
Received: from mailout00.sul.t-online.com ([194.25.134.16]:11018 "EHLO
	mailout00.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129772AbRB0TXn>; Tue, 27 Feb 2001 14:23:43 -0500
Message-ID: <3A9C0CE4.EAE660CE@t-online.de>
Date: Tue, 27 Feb 2001 21:24:04 +0100
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com
CC: linux-kernel@vger.kernel.org
Subject: Patch(2.4.2): Fix Timdia/Sunix serial PCI cards
Content-Type: multipart/mixed;
 boundary="------------2EC01E6A7F5BEEE672C2C9BD"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2EC01E6A7F5BEEE672C2C9BD
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,
this patch fixes subvendor vs. subdevice and
makes my serial PCI card happy again.

Linus, please apply if you like.

Regards, Gunther

--- linux/drivers/char/serial.c-241-orig        Sat Feb  3 13:00:53 2001
+++ linux/drivers/char/serial.c Sat Feb  3 13:31:33 2001
@@ -3845,7 +3845,6 @@
        offset = board->first_uart_offset;
 
        /* Timedia/SUNIX uses a mixture of BARs and offsets */
-       /* Ugh, this is ugly as all hell --- TYT */
        if(dev->vendor == PCI_VENDOR_ID_TIMEDIA )  /* 0x1409 */
                switch(idx) {
                        case 0: base_idx=0;
@@ -4175,12 +4174,17 @@
        for (i=0; timedia_data[i].num; i++) {
                ids = timedia_data[i].ids;
                for (j=0; ids[j]; j++) {
-                       if (pci_get_subvendor(dev) == ids[j]) {
+                       if (pci_get_subdevice(dev) == ids[j]) {
                                board->num_ports = timedia_data[i].num;
+                               printk("serial: Timedia/Sunix/Exsys PCI with %d ports (%x:%x)\n",
+                                       board->num_ports, pci_get_subvendor(dev),
+                                       pci_get_subdevice(dev));
                                return 0;
                        }
                }
        }
+       printk("serial: ignoring unknown Timedia/Sunix card (%x:%x)\n",
+               pci_get_subvendor(dev),pci_get_subdevice(dev));
        return 0;
 }
--------------2EC01E6A7F5BEEE672C2C9BD
Content-Type: application/octet-stream;
 name="gmdiff-lx241-serial-timedia-fix"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="gmdiff-lx241-serial-timedia-fix"

LS0tIGxpbnV4L2RyaXZlcnMvY2hhci9zZXJpYWwuYy0yNDEtb3JpZwlTYXQgRmViICAzIDEz
OjAwOjUzIDIwMDEKKysrIGxpbnV4L2RyaXZlcnMvY2hhci9zZXJpYWwuYwlTYXQgRmViICAz
IDEzOjMxOjMzIDIwMDEKQEAgLTM4NDUsNyArMzg0NSw2IEBACiAJb2Zmc2V0ID0gYm9hcmQt
PmZpcnN0X3VhcnRfb2Zmc2V0OwogCiAJLyogVGltZWRpYS9TVU5JWCB1c2VzIGEgbWl4dHVy
ZSBvZiBCQVJzIGFuZCBvZmZzZXRzICovCi0JLyogVWdoLCB0aGlzIGlzIHVnbHkgYXMgYWxs
IGhlbGwgLS0tIFRZVCAqLwogCWlmKGRldi0+dmVuZG9yID09IFBDSV9WRU5ET1JfSURfVElN
RURJQSApICAvKiAweDE0MDkgKi8KIAkJc3dpdGNoKGlkeCkgewogCQkJY2FzZSAwOiBiYXNl
X2lkeD0wOwpAQCAtNDE3NSwxMiArNDE3NCwxNyBAQAogCWZvciAoaT0wOyB0aW1lZGlhX2Rh
dGFbaV0ubnVtOyBpKyspIHsKIAkJaWRzID0gdGltZWRpYV9kYXRhW2ldLmlkczsKIAkJZm9y
IChqPTA7IGlkc1tqXTsgaisrKSB7Ci0JCQlpZiAocGNpX2dldF9zdWJ2ZW5kb3IoZGV2KSA9
PSBpZHNbal0pIHsKKwkJCWlmIChwY2lfZ2V0X3N1YmRldmljZShkZXYpID09IGlkc1tqXSkg
ewogCQkJCWJvYXJkLT5udW1fcG9ydHMgPSB0aW1lZGlhX2RhdGFbaV0ubnVtOworCQkJCXBy
aW50aygic2VyaWFsOiBUaW1lZGlhL1N1bml4L0V4c3lzIFBDSSB3aXRoICVkIHBvcnRzICgl
eDoleClcbiIsCisJCQkJCWJvYXJkLT5udW1fcG9ydHMsIHBjaV9nZXRfc3VidmVuZG9yKGRl
diksCisJCQkJCXBjaV9nZXRfc3ViZGV2aWNlKGRldikpOwogCQkJCXJldHVybiAwOwogCQkJ
fQogCQl9CiAJfQorCXByaW50aygic2VyaWFsOiBpZ25vcmluZyB1bmtub3duIFRpbWVkaWEv
U3VuaXggY2FyZCAoJXg6JXgpXG4iLAorCQlwY2lfZ2V0X3N1YnZlbmRvcihkZXYpLHBjaV9n
ZXRfc3ViZGV2aWNlKGRldikpOwogCXJldHVybiAwOwogfQogCg==
--------------2EC01E6A7F5BEEE672C2C9BD--

