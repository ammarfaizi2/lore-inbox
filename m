Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130317AbRCPHcF>; Fri, 16 Mar 2001 02:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130384AbRCPHbz>; Fri, 16 Mar 2001 02:31:55 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:6669 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S130317AbRCPHbq>; Fri, 16 Mar 2001 02:31:46 -0500
Message-ID: <3AB1CF32.F02D33FF@t-online.de>
Date: Fri, 16 Mar 2001 09:30:42 +0100
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: alan@lxorguk.ukuu.org.uk
CC: linux-kernel@vger.kernel.org
Subject: Patch(2.4.2): isapnp detect fix (wrong checksum)
Content-Type: multipart/mixed;
 boundary="------------B53AC69B36E4583888D1D0E5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B53AC69B36E4583888D1D0E5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,
this fix lets linux detect cards which don't
have a correct checksum.

These are probably common, it seems isapnptools _silently_
fixes this up !

Please apply if you like, comments welcome.

Regards, Gunther

--- linux/drivers/pnp/isapnp.c-2.4.2-orig       Fri Mar 16 09:08:47 2001
+++ linux/drivers/pnp/isapnp.c  Fri Mar 16 09:21:45 2001
@@ -993,10 +993,15 @@
                        header[4], header[5], header[6], header[7], header[8]);
                printk("checksum = 0x%x\n", checksum);
 #endif
-               if (checksum == 0x00 || checksum != header[8])  /* not valid CSN */
+               /* Don't be strict on the checksum, here !
+                   e.g. 'SCM SwapBox Plug and Play' has header[8]==0 (should be: b7)*/
+               if (header[8] == 0)
+                       ;
+               else if (checksum == 0x00 || checksum != header[8])     /* not valid CSN */
                        continue;
                if ((card = isapnp_alloc(sizeof(struct pci_bus))) == NULL)
                        continue;
+
                card->number = csn;
                card->vendor = (header[1] << 8) | header[0];
                card->device = (header[3] << 8) | header[2];
--------------B53AC69B36E4583888D1D0E5
Content-Type: application/octet-stream;
 name="gmdiff-242-isapnp-checksum-swapbox"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="gmdiff-242-isapnp-checksum-swapbox"

LS0tIGxpbnV4L2RyaXZlcnMvcG5wL2lzYXBucC5jLTIuNC4yLW9yaWcJRnJpIE1hciAxNiAw
OTowODo0NyAyMDAxCisrKyBsaW51eC9kcml2ZXJzL3BucC9pc2FwbnAuYwlGcmkgTWFyIDE2
IDA5OjIxOjQ1IDIwMDEKQEAgLTk5MywxMCArOTkzLDE1IEBACiAJCQloZWFkZXJbNF0sIGhl
YWRlcls1XSwgaGVhZGVyWzZdLCBoZWFkZXJbN10sIGhlYWRlcls4XSk7CiAJCXByaW50aygi
Y2hlY2tzdW0gPSAweCV4XG4iLCBjaGVja3N1bSk7CiAjZW5kaWYKLQkJaWYgKGNoZWNrc3Vt
ID09IDB4MDAgfHwgY2hlY2tzdW0gIT0gaGVhZGVyWzhdKQkvKiBub3QgdmFsaWQgQ1NOICov
CisJCS8qIERvbid0IGJlIHN0cmljdCBvbiB0aGUgY2hlY2tzdW0sIGhlcmUgIQorICAgICAg
ICAgICAgICAgICAgIGUuZy4gJ1NDTSBTd2FwQm94IFBsdWcgYW5kIFBsYXknIGhhcyBoZWFk
ZXJbOF09PTAgKHNob3VsZCBiZTogYjcpKi8KKwkJaWYgKGhlYWRlcls4XSA9PSAwKQorCQkJ
OworCQllbHNlIGlmIChjaGVja3N1bSA9PSAweDAwIHx8IGNoZWNrc3VtICE9IGhlYWRlcls4
XSkJLyogbm90IHZhbGlkIENTTiAqLwogCQkJY29udGludWU7CiAJCWlmICgoY2FyZCA9IGlz
YXBucF9hbGxvYyhzaXplb2Yoc3RydWN0IHBjaV9idXMpKSkgPT0gTlVMTCkKIAkJCWNvbnRp
bnVlOworCiAJCWNhcmQtPm51bWJlciA9IGNzbjsKIAkJY2FyZC0+dmVuZG9yID0gKGhlYWRl
clsxXSA8PCA4KSB8IGhlYWRlclswXTsKIAkJY2FyZC0+ZGV2aWNlID0gKGhlYWRlclszXSA8
PCA4KSB8IGhlYWRlclsyXTsK
--------------B53AC69B36E4583888D1D0E5--

