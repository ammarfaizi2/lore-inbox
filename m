Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265684AbUAHSEJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 13:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265820AbUAHSEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 13:04:09 -0500
Received: from web13909.mail.yahoo.com ([216.136.172.94]:50792 "HELO
	web13909.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265684AbUAHSDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 13:03:03 -0500
Message-ID: <20040108180302.17660.qmail@web13909.mail.yahoo.com>
X-RocketYMMF: knobi.rm
Date: Thu, 8 Jan 2004 10:03:02 -0800 (PST)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Re: Any changes in Multicast code between 2.4.20 and 2.4.22/23 ? -> New Info
To: David Stevens <dlstevens@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
In-Reply-To: <OFFB53E1E3.C0B1F8BC-ON88256E14.003560C9@us.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-11662705-1073584982=:16859"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-11662705-1073584982=:16859
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

--- David Stevens <dlstevens@us.ibm.com> wrote:
> 
> 
> 
> 
>       There were some unwanted side-effects in multicast delivery
> because
> of the source filtering but I'm pretty sure those fixes are in the
> 2.4
> line.
> 
David,

 maybe they are not :-)

 After some more playing with printk-s and a bit of gross hacking I
think I am up to something.

 Please look at the appended patch on top of 2.4.22. It adds some
printk-s and also makes some of the V2 pathes trigger by adding "1 ||"
to some statemens.

 With this all of a sudden the external packets to the 239.2.11.71
group of Ganglia come in again.

 Now, what does it mean?

a) IGMP_V2_SEEN does not work as expected ?
b) something with the timer codes is fishy ?
c) whatever ...

 Again, hope this helps to shed light on the problem.

Martin

=====
------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
--0-11662705-1073584982=:16859
Content-Type: application/octet-stream; name="igmp.diff"
Content-Transfer-Encoding: base64
Content-Description: igmp.diff
Content-Disposition: attachment; filename="igmp.diff"

LS0tIC4uLy4uLy4uL2xpbnV4LTIuNC4yMi0zLW1zYy9uZXQvaXB2NC9pZ21w
LmMJTW9uIEF1ZyAyNSAxMzo0NDo0NCAyMDAzCisrKyAuL2lnbXAuYwlUaHUg
SmFuICA4IDE4OjM5OjQ4IDIwMDQKQEAgLTQ3Nyw2ICs0NzcsNyBAQAogCXN0
cnVjdCBza19idWZmICpza2IgPSAwOwogCWludCB0eXBlOwogCisJcHJpbnRr
KEtFUk5fREVCVUcgImlnbXB2M19zZW5kX3JlcG9ydFxuIik7CiAJaWYgKCFw
bWMpIHsKIAkJcmVhZF9sb2NrKCZpbl9kZXYtPmxvY2spOwogCQlmb3IgKHBt
Yz1pbl9kZXYtPm1jX2xpc3Q7IHBtYzsgcG1jPXBtYy0+bmV4dCkgewpAQCAt
NjA5LDYgKzYxMCw3IEBACiAJdTMyCWdyb3VwID0gcG1jID8gcG1jLT5tdWx0
aWFkZHIgOiAwOwogCXUzMglkc3Q7CiAKKwlwcmludGsoS0VSTl9ERUJVRyAi
aWdtcF9zZW5kX3JlcG9ydDogJTB4ICVkXG4iLGdyb3VwLCB0eXBlKTsKIAlp
ZiAodHlwZSA9PSBJR01QVjNfSE9TVF9NRU1CRVJTSElQX1JFUE9SVCkKIAkJ
cmV0dXJuIGlnbXB2M19zZW5kX3JlcG9ydChpbl9kZXYsIHBtYyk7CiAJZWxz
ZSBpZiAodHlwZSA9PSBJR01QX0hPU1RfTEVBVkVfTUVTU0FHRSkKQEAgLTcw
OCw5ICs3MTAsMTAgQEAKIAlpbS0+cmVwb3J0ZXIgPSAxOwogCXNwaW5fdW5s
b2NrKCZpbS0+bG9jayk7CiAKKwlwcmludGsoS0VSTl9ERUJVRyAiaWdtcF90
aW1lcl9leHBpcmVcbiIpOwogCWlmIChJR01QX1YxX1NFRU4oaW5fZGV2KSkK
IAkJaWdtcF9zZW5kX3JlcG9ydChpbl9kZXYsIGltLCBJR01QX0hPU1RfTUVN
QkVSU0hJUF9SRVBPUlQpOwotCWVsc2UgaWYgKElHTVBfVjJfU0VFTihpbl9k
ZXYpKQorCWVsc2UgaWYgKDEgfHwgSUdNUF9WMl9TRUVOKGluX2RldikpCiAJ
CWlnbXBfc2VuZF9yZXBvcnQoaW5fZGV2LCBpbSwgSUdNUFYyX0hPU1RfTUVN
QkVSU0hJUF9SRVBPUlQpOwogCWVsc2UKIAkJaWdtcF9zZW5kX3JlcG9ydChp
bl9kZXYsIGltLCBJR01QVjNfSE9TVF9NRU1CRVJTSElQX1JFUE9SVCk7CkBA
IC03NzQsNiArNzc3LDcgQEAKIAkJCQlJR01QX1YxX1JvdXRlcl9QcmVzZW50
X1RpbWVvdXQ7CiAJCQlncm91cCA9IDA7CiAJCX0gZWxzZSB7CisJCQlwcmlu
dGsoS0VSTl9ERUJVRyAiaWdtcF9oZWFyZF9xdWVyeSBmb3IgVjJcbiIpOwog
CQkJLyogdjIgcm91dGVyIHByZXNlbnQgKi8KIAkJCW1heF9kZWxheSA9IGlo
LT5jb2RlKihIWi9JR01QX1RJTUVSX1NDQUxFKTsKIAkJCWluX2Rldi0+bXJf
djJfc2VlbiA9IGppZmZpZXMgKwpAQCAtODQwLDExICs4NDQsMTMgQEAKIAlz
dHJ1Y3QgaW5fZGV2aWNlICppbl9kZXYgPSBpbl9kZXZfZ2V0KHNrYi0+ZGV2
KTsKIAlpbnQgbGVuID0gc2tiLT5sZW47CiAKKwlwcmludGsoS0VSTl9ERUJV
RyAiaWdtcF9yY3Y6IGVudGVyZWRcbiIpOwogCWlmIChpbl9kZXY9PU5VTEwp
IHsKIAkJa2ZyZWVfc2tiKHNrYik7CiAJCXJldHVybiAwOwogCX0KIAorCXBy
aW50ayhLRVJOX0RFQlVHICJpZ21wX3JjdjogMVxuIik7CiAJaWYgKHNrYl9p
c19ub25saW5lYXIoc2tiKSkgewogCQlpZiAoc2tiX2xpbmVhcml6ZShza2Is
IEdGUF9BVE9NSUMpICE9IDApIHsKIAkJCWtmcmVlX3NrYihza2IpOwpAQCAt
ODUzLDEyICs4NTksMTQgQEAKIAkJaWggPSBza2ItPmguaWdtcGg7CiAJfQog
CisJcHJpbnRrKEtFUk5fREVCVUcgImlnbXBfcmN2OiAyXG4iKTsKIAlpZiAo
bGVuIDwgc2l6ZW9mKHN0cnVjdCBpZ21waGRyKSB8fCBpcF9jb21wdXRlX2Nz
dW0oKHZvaWQgKilpaCwgbGVuKSkgewogCQlpbl9kZXZfcHV0KGluX2Rldik7
CiAJCWtmcmVlX3NrYihza2IpOwogCQlyZXR1cm4gMDsKIAl9CiAKKwlwcmlu
dGsoS0VSTl9ERUJVRyAiaWdtcF9yY3Y6IDNcbiIpOwogCXN3aXRjaCAoaWgt
PnR5cGUpIHsKIAljYXNlIElHTVBfSE9TVF9NRU1CRVJTSElQX1FVRVJZOgog
CQlpZ21wX2hlYXJkX3F1ZXJ5KGluX2RldiwgaWgsIGxlbik7CkBAIC05MDks
NiArOTE3LDcgQEAKIAkgICBpZiAoZGV2LT5tY19saXN0ICYmIGRldi0+Zmxh
Z3MmSUZGX01VTFRJQ0FTVCkgeyBkbyBpdDsgfQogCSAgIC0tQU5LCiAJICAg
Ki8KKwlwcmludGsoS0VSTl9ERUJVRyAiaXBfbWNfZmlsdGVyX2FkZDogJXMg
JXhcbiIsZGV2LT5uYW1lLGFkZHIpOwogCWlmIChhcnBfbWNfbWFwKGFkZHIs
IGJ1ZiwgZGV2LCAwKSA9PSAwKQogCQlkZXZfbWNfYWRkKGRldixidWYsZGV2
LT5hZGRyX2xlbiwwKTsKIH0KQEAgLTEwNTIsNyArMTA2MSw3IEBACiAJaWYg
KGluX2Rldi0+ZGV2LT5mbGFncyAmIElGRl9VUCkgewogCQlpZiAoSUdNUF9W
MV9TRUVOKGluX2RldikpCiAJCQlnb3RvIGRvbmU7Ci0JCWlmIChJR01QX1Yy
X1NFRU4oaW5fZGV2KSkgeworCQlpZiAoMSB8fCBJR01QX1YyX1NFRU4oaW5f
ZGV2KSkgewogCQkJaWYgKHJlcG9ydGVyKQogCQkJCWlnbXBfc2VuZF9yZXBv
cnQoaW5fZGV2LCBpbSwgSUdNUF9IT1NUX0xFQVZFX01FU1NBR0UpOwogCQkJ
Z290byBkb25lOwpAQCAtMTA3MSwxNiArMTA4MCwxOSBAQAogewogCXN0cnVj
dCBpbl9kZXZpY2UgKmluX2RldiA9IGltLT5pbnRlcmZhY2U7CiAKKwlwcmlu
dGsoS0VSTl9ERUJVRyAiaWdtcF9ncm91cF9hZGRlZDogMVxuIik7CiAJaWYg
KGltLT5sb2FkZWQgPT0gMCkgewogCQlpbS0+bG9hZGVkID0gMTsKIAkJaXBf
bWNfZmlsdGVyX2FkZChpbl9kZXYsIGltLT5tdWx0aWFkZHIpOwogCX0KIAog
I2lmZGVmIENPTkZJR19JUF9NVUxUSUNBU1QKKwlwcmludGsoS0VSTl9ERUJV
RyAiaWdtcF9ncm91cF9hZGRlZDogMlxuIik7CiAJaWYgKGltLT5tdWx0aWFk
ZHIgPT0gSUdNUF9BTExfSE9TVFMpCiAJCXJldHVybjsKIAotCWlmIChJR01Q
X1YxX1NFRU4oaW5fZGV2KSB8fCBJR01QX1YyX1NFRU4oaW5fZGV2KSkgewor
CXByaW50ayhLRVJOX0RFQlVHICJpZ21wX2dyb3VwX2FkZGVkOiAzXG4iKTsK
KwlpZiAoMSB8fCBJR01QX1YxX1NFRU4oaW5fZGV2KSB8fCBJR01QX1YyX1NF
RU4oaW5fZGV2KSkgewogCQlzcGluX2xvY2tfYmgoJmltLT5sb2NrKTsKIAkJ
aWdtcF9zdGFydF90aW1lcihpbSwgSUdNUF9Jbml0aWFsX1JlcG9ydF9EZWxh
eSk7CiAJCXNwaW5fdW5sb2NrX2JoKCZpbS0+bG9jayk7CkBAIC0xMDg4LDYg
KzExMDAsNyBAQAogCX0KIAkvKiBlbHNlLCB2MyAqLwogCisJcHJpbnRrKEtF
Uk5fREVCVUcgImlnbXBfZ3JvdXBfYWRkZWQ6IDRcbiIpOwogCWltLT5jcmNv
dW50ID0gaW5fZGV2LT5tcl9xcnYgPyBpbl9kZXYtPm1yX3FydiA6CiAJCUlH
TVBfVW5zb2xpY2l0ZWRfUmVwb3J0X0NvdW50OwogCWlnbXBfaWZjX2V2ZW50
KGluX2Rldik7CkBAIC0xMTEwLDYgKzExMjMsNyBAQAogCiAJQVNTRVJUX1JU
TkwoKTsKIAorCXByaW50ayhLRVJOX0RFQlVHICJpcF9tY19pbmNfZ3JvdXA6
ICVzICV4XG4iLGluX2Rldi0+ZGV2LT5uYW1lLGFkZHIpOwogCWZvciAoaW09
aW5fZGV2LT5tY19saXN0OyBpbTsgaW09aW0tPm5leHQpIHsKIAkJaWYgKGlt
LT5tdWx0aWFkZHIgPT0gYWRkcikgewogCQkJaW0tPnVzZXJzKys7CkBAIC0x
MTM1LDYgKzExNDksNyBAQAogCWltLT5jcmNvdW50ID0gMDsKIAlhdG9taWNf
c2V0KCZpbS0+cmVmY250LCAxKTsKIAlzcGluX2xvY2tfaW5pdCgmaW0tPmxv
Y2spOworCXByaW50ayhLRVJOX0RFQlVHICJpcF9tY19pbmNfZ3JvdXA6IDFc
biIpOwogI2lmZGVmIENPTkZJR19JUF9NVUxUSUNBU1QKIAlpbS0+dG1fcnVu
bmluZz0wOwogCWluaXRfdGltZXIoJmltLT50aW1lcik7Cg==

--0-11662705-1073584982=:16859--
