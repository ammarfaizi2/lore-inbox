Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271124AbTG1VNY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 17:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271149AbTG1VNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 17:13:24 -0400
Received: from fmr03.intel.com ([143.183.121.5]:46547 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S271124AbTG1VNM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 17:13:12 -0400
Message-ID: <3F259195.7070707@intel.com>
Date: Mon, 28 Jul 2003 14:11:49 -0700
From: Arun Sharma <arun.sharma@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: binfmt handler searching issues
Content-Type: multipart/mixed;
 boundary="------------060605010007070605050505"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060605010007070605050505
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

A script such as

#!/bin/foo.bar
...

where /bin/foo.bar is handled by binfmt_misc, is not handled correctly i.e. the interpreter of foo.bar doesn't receive the correct arguments.

The binfmt_misc handler requires that bprm->filename is appropriately filled so that the argv[1] could be correctly passed to the interpreter.

However, binfmt_script, as it exists today doesn't populate bprm->filename correctly.

Another motivation for this patch is the output of ps. Emulators which use binfmt_misc may want to keep the output of ps consistent with native execution. This requires preserving bprm->filename. The attached patch guarantees this even if we have to go through several binfmt handlers (think of finite loops involving  binfmt_script and binfmt_misc).

        -Arun

--------------060605010007070605050505
Content-Type: text/plain;
 name="binfmt_interp.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="binfmt_interp.patch"

LS0tIGxpbnV4L2ZzL2V4ZWMuYy0JVGh1IE1hciAxMyAxMTo0Mjo1MSAyMDAzCisrKyBsaW51
eC9mcy9leGVjLmMJVGh1IE1hciAxMyAxMTo0MzowNSAyMDAzCkBAIC04ODIsNiArODgyLDcg
QEAKIAogCWJwcm0uZmlsZSA9IGZpbGU7CiAJYnBybS5maWxlbmFtZSA9IGZpbGVuYW1lOwor
CWJwcm0uaW50ZXJwID0gZmlsZW5hbWU7CiAJYnBybS5zaF9iYW5nID0gMDsKIAlicHJtLmxv
YWRlciA9IDA7CiAJYnBybS5leGVjID0gMDsKLS0tIGxpbnV4L2ZzL2JpbmZtdF9zY3JpcHQu
Yy0JVGh1IE1hciAxMyAxMjowOToyOCAyMDAzCisrKyBsaW51eC9mcy9iaW5mbXRfc2NyaXB0
LmMJVGh1IE1hciAxMyAxMjowOTo0NiAyMDAzCkBAIC03OCw2ICs3OCw4IEBACiAJcmV0dmFs
ID0gY29weV9zdHJpbmdzX2tlcm5lbCgxLCAmaV9uYW1lLCBicHJtKTsKIAlpZiAocmV0dmFs
KSByZXR1cm4gcmV0dmFsOyAKIAlicHJtLT5hcmdjKys7CisJYnBybS0+aW50ZXJwID0gaW50
ZXJwOworCQogCS8qCiAJICogT0ssIG5vdyByZXN0YXJ0IHRoZSBwcm9jZXNzIHdpdGggdGhl
IGludGVycHJldGVyJ3MgZGVudHJ5LgogCSAqLwotLS0gbGludXgvaW5jbHVkZS9saW51eC9i
aW5mbXRzLmgtCVRodSBNYXIgMTMgMTE6NDA6NDEgMjAwMworKysgbGludXgvaW5jbHVkZS9s
aW51eC9iaW5mbXRzLmgJVGh1IE1hciAxMyAxMTo0MjowNSAyMDAzCkBAIC0zMCw3ICszMCwx
MCBAQAogCWludCBlX3VpZCwgZV9naWQ7CiAJa2VybmVsX2NhcF90IGNhcF9pbmhlcml0YWJs
ZSwgY2FwX3Blcm1pdHRlZCwgY2FwX2VmZmVjdGl2ZTsKIAlpbnQgYXJnYywgZW52YzsKLQlj
aGFyICogZmlsZW5hbWU7CS8qIE5hbWUgb2YgYmluYXJ5ICovCisJY2hhciAqIGZpbGVuYW1l
OwkvKiBOYW1lIG9mIGJpbmFyeSBhcyBzZWVuIGJ5IHByb2NwcyAqLworCWNoYXIgKiBpbnRl
cnA7CQkvKiBOYW1lIG9mIHRoZSBiaW5hcnkgcmVhbGx5IGV4ZWN1dGVkLiBNb3N0CisJCQkJ
ICAgb2YgdGhlIHRpbWUgc2FtZSBhcyBmaWxlbmFtZSwgYnV0IGNvdWxkIGJlCisJCQkJICAg
ZGlmZmVyZW50IGZvciBiaW5mbXRfe21pc2Msc2NyaXB0fSAqLwogCXVuc2lnbmVkIGxvbmcg
bG9hZGVyLCBleGVjOwogfTsKCi0tLSBsaW51eC9mcy9iaW5mbXRfc2NyaXB0LmMtCU1vbiBN
YXIgMTcgMDg6MTA6NTYgMjAwMworKysgbGludXgvZnMvYmluZm10X3NjcmlwdC5jCU1vbiBN
YXIgMTcgMDg6MTM6MDcgMjAwMwpAQCAtNjcsNyArNjcsNyBAQAogCSAqIHVzZXIgZW52aXJv
bm1lbnQgYW5kIGFyZ3VtZW50cyBhcmUgc3RvcmVkLgogCSAqLwogCXJlbW92ZV9hcmdfemVy
byhicHJtKTsKLQlyZXR2YWwgPSBjb3B5X3N0cmluZ3Nfa2VybmVsKDEsICZicHJtLT5maWxl
bmFtZSwgYnBybSk7CisJcmV0dmFsID0gY29weV9zdHJpbmdzX2tlcm5lbCgxLCAmYnBybS0+
aW50ZXJwLCBicHJtKTsKIAlpZiAocmV0dmFsIDwgMCkgcmV0dXJuIHJldHZhbDsgCiAJYnBy
bS0+YXJnYysrOwogCWlmIChpX2FyZykgewogCi0tLSBsaW51eC9mcy9iaW5mbXRfbWlzYy5j
Lm9yaWcJV2VkIE1hciAxOSAxNTo0NTozNCAyMDAzCisrKyBsaW51eC9mcy9iaW5mbXRfbWlz
Yy5jCVdlZCBNYXIgMTkgMTU6NDk6MzkgMjAwMwpAQCAtNTgsNyArNTgsNyBAQAogICovCiBz
dGF0aWMgTm9kZSAqY2hlY2tfZmlsZShzdHJ1Y3QgbGludXhfYmlucHJtICpicHJtKQogewot
CWNoYXIgKnAgPSBzdHJyY2hyKGJwcm0tPmZpbGVuYW1lLCAnLicpOworCWNoYXIgKnAgPSBz
dHJyY2hyKGJwcm0tPmludGVycCwgJy4nKTsKIAlzdHJ1Y3QgbGlzdF9oZWFkICpsOwogCiAJ
Zm9yIChsID0gZW50cmllcy5uZXh0OyBsICE9ICZlbnRyaWVzOyBsID0gbC0+bmV4dCkgewpA
QCAtMTI1LDEzICsxMjUsMTMgQEAKIAlpZiAoIShmbXQtPmZsYWdzICYgTUlTQ19GTVRfUFJF
U0VSVkVfQVJHVjApKSB7CiAJCXJlbW92ZV9hcmdfemVybyhicHJtKTsKIAl9Ci0JcmV0dmFs
ID0gY29weV9zdHJpbmdzX2tlcm5lbCgxLCAmYnBybS0+ZmlsZW5hbWUsIGJwcm0pOworCXJl
dHZhbCA9IGNvcHlfc3RyaW5nc19rZXJuZWwoMSwgJmJwcm0tPmludGVycCwgYnBybSk7CiAJ
aWYgKHJldHZhbCA8IDApIGdvdG8gX3JldDsgCiAJYnBybS0+YXJnYysrOwogCXJldHZhbCA9
IGNvcHlfc3RyaW5nc19rZXJuZWwoMSwgJmluYW1lX2FkZHIsIGJwcm0pOwogCWlmIChyZXR2
YWwgPCAwKSBnb3RvIF9yZXQ7IAogCWJwcm0tPmFyZ2MrKzsKLQlicHJtLT5maWxlbmFtZSA9
IGluYW1lOwkvKiBmb3IgYmluZm10X3NjcmlwdCAqLworCWJwcm0tPmludGVycCA9IGluYW1l
OwkvKiBmb3IgYmluZm10X3NjcmlwdCAqLwogCiAJZmlsZSA9IG9wZW5fZXhlYyhpbmFtZSk7
CiAJcmV0dmFsID0gUFRSX0VSUihmaWxlKTsK
--------------060605010007070605050505--

