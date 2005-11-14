Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbVKNXx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbVKNXx0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 18:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbVKNXx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 18:53:26 -0500
Received: from ns2.g-housing.de ([81.169.133.75]:41444 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S932173AbVKNXxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 18:53:25 -0500
Message-ID: <43792372.2010409@g-house.de>
Date: Tue, 15 Nov 2005 00:53:22 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
Subject: 2.6.14-mm2: no .config.old any more?
Content-Type: multipart/mixed;
 boundary="------------070603000701090703080403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070603000701090703080403
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


hi,

i noticed that 2.6.14-mm2 does not generate a .config.old anymore, so that 
i can undo changes. i see that the Kconfig system is probably in flux 
again ("Why did oldconfig's behavior change in 2.6.15-rc1?"), but i have 
not seen this issue being reported:

% cp .config .config.really-old
% make menuconfig
[...]
scripts/kconfig/mconf arch/x86_64/Kconfig
#
# using defaults found in .config
#

*** End of Linux kernel configuration.
*** Execute 'make' to build the kernel or try 'make help'.

% diff .config.really-old .config
4c4
< # Tue Nov 15 00:23:53 2005
---
 > # Tue Nov 15 00:24:41 2005
1454c1454
< CONFIG_PRINTK_TIME=y
---
 > # CONFIG_PRINTK_TIME is not set

% ls .config.old
ls: .config.old: No such file or directory

attached patch reverts one change introduced in 2.6.14-mm1 and fixes it 
for me, but i doubt that it is the right thing to do....

thanks,
Christian.
-- 
BOFH excuse #404:

Sysadmin accidentally destroyed pager with a large hammer.

--------------070603000701090703080403
Content-Type: text/plain;
 name="2.6.14-mm2-config.old.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="2.6.14-mm2-config.old.diff"

LS0tIGxpbnV4LTIuNi1tbS9zY3JpcHRzL2tjb25maWcvY29uZmRhdGEuYy4yLjYuMTQtbW0y
CTIwMDUtMTEtMTUgMDA6NDE6MjkuNjQ3Mzk5NDY0ICswMTAwCisrKyBsaW51eC0yLjYtbW0v
c2NyaXB0cy9rY29uZmlnL2NvbmZkYXRhLmMJMjAwNS0xMS0xNSAwMDo0NToyMS4yOTExODQy
NTYgKzAxMDAKQEAgLTUxOCwyMyArNTE4LDEzIEBAIGludCBjb25mX3dyaXRlKGNvbnN0IGNo
YXIgKm5hbWUpCiAJCWlmICghbmFtZSkKIAkJCW5hbWUgPSBjb25mX2RlZl9maWxlbmFtZTsK
IAkJc3ByaW50Zih0bXBuYW1lLCAiJXMub2xkIiwgbmFtZSk7Ci0vLwkJcHJpbnRmKCJyZW5h
bWUxKCVzLCAlcylcbiIsIG5hbWUsIHRtcG5hbWUpOwotLy8JCXJlbmFtZShuYW1lLCB0bXBu
YW1lKTsKKwkJcmVuYW1lKG5hbWUsIHRtcG5hbWUpOwogCX0KIAlzcHJpbnRmKHRtcG5hbWUs
ICIlcyVzIiwgZGlybmFtZSwgYmFzZW5hbWUpOwotLy8JcHJpbnRmKCJyZW5hbWUyKCVzLCAl
cylcbiIsIG5ld25hbWUsIHRtcG5hbWUpOwotI2lmIDAKIAlpZiAocmVuYW1lKG5ld25hbWUs
IHRtcG5hbWUpKQogCQlyZXR1cm4gMTsKLSNlbHNlCi0JewotCQljaGFyIGJ1ZlsyNTZdOwot
CQlzcHJpbnRmKGJ1ZiwgImNwICVzICVzIiwgbmV3bmFtZSwgdG1wbmFtZSk7Ci0JCXN5c3Rl
bShidWYpOwotCQl1bmxpbmsobmV3bmFtZSk7Ci0JfQotI2VuZGlmCi0gCXN5bV9jaGFuZ2Vf
Y291bnQgPSAwOwotIAorCisJc3ltX2NoYW5nZV9jb3VudCA9IDA7CisKIAlyZXR1cm4gMDsK
IH0K
--------------070603000701090703080403--
