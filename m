Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315415AbSIDVGp>; Wed, 4 Sep 2002 17:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315427AbSIDVGp>; Wed, 4 Sep 2002 17:06:45 -0400
Received: from web13808.mail.yahoo.com ([216.136.175.18]:22276 "HELO
	web13808.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S315415AbSIDVGo>; Wed, 4 Sep 2002 17:06:44 -0400
Message-ID: <20020904211118.37877.qmail@web13808.mail.yahoo.com>
Date: Wed, 4 Sep 2002 14:11:18 -0700 (PDT)
From: "M.L.PrasannaK.R." <mlpkr@yahoo.com>
Subject: fsuid0 caps
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-18106085-1031173878=:37422"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-18106085-1031173878=:37422
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In reply to
ttp://www.uwsg.iu.edu/hypermail/linux/kernel/0204.3/0380.html

This is documentation error. There is also a break in default
semantics of uid0 that needs to be fixed.
It is not a security hole as it results in the reduced capabilities
rather than in the increased capabilities.

setresuid(x,x,-1) clears effective caps.
setfsuid(0) rstores CAP_FS_MASK effective caps.
setresuid(-1,-1,x) clears both effective and permitted caps.
Both fs and non fs caps are lost.

This results in uid0 with no capabilties and no way of
restoring them. If this is valid issue, something like
the following patch fixes it.

Thanks,
MLPKR.



__________________________________________________
Do You Yahoo!?
Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com
--0-18106085-1031173878=:37422
Content-Type: application/x-unknown; name="fsuid_caps.patch"
Content-Transfer-Encoding: base64
Content-Description: fsuid_caps.patch
Content-Disposition: attachment; filename="fsuid_caps.patch"

LS0tIHN5cy5jCUZyaSBBdWcgMzAgMTg6NDI6MjAgMjAwMgorKysgL3RtcC9z
eXMuYwlXZWQgU2VwICA0IDIwOjEyOjUxIDIwMDIKQEAgLTQ1MCw3ICs0NTAs
NyBAQAogICoKICAqICAxKSBXaGVuIHNldCp1aWRpbmcgX2Zyb21fIG9uZSBv
ZiB7cixlLHN9dWlkID09IDAgX3RvXyBhbGwgb2YKICAqICB7cixlLHN9dWlk
ICE9IDAsIHRoZSBwZXJtaXR0ZWQgYW5kIGVmZmVjdGl2ZSBjYXBhYmlsaXRp
ZXMgYXJlCi0gKiAgY2xlYXJlZC4KKyAqICBjbGVhcmVkIHdpdGggdGhlIGV4
Y2VwdGlvbiBjYXNlIHJlbGF0ZWQgdG8gZnN1aWQuIFNlZSBiZWxvdy4KICAq
CiAgKiAgMikgV2hlbiBzZXQqdWlkaW5nIF9mcm9tXyBldWlkID09IDAgX3Rv
XyBldWlkICE9IDAsIHRoZSBlZmZlY3RpdmUKICAqICBjYXBhYmlsaXRpZXMg
b2YgdGhlIHByb2Nlc3MgYXJlIGNsZWFyZWQuCkBAIC00NzIsNiArNDcyLDE1
IEBACiAgKiBLZWVwaW5nIHVpZCAwIGlzIG5vdCBhbiBvcHRpb24gYmVjYXVz
ZSB1aWQgMCBvd25zIHRvbyBtYW55IHZpdGFsCiAgKiBmaWxlcy4uCiAgKiBU
aGFua3MgdG8gT2xhZiBLaXJjaCBhbmQgUGV0ZXIgQmVuaWUgZm9yIHNwb3R0
aW5nIHRoaXMuCisgKgorICogQ2hhbmdlOgorICogIEludmFyaWFudCBmc3Vp
ZCA9MCBpZmYgb25lIG9mIHRoZSB7cixlLHN9dWlkID09IDAgaXMgbm8gbW9y
ZSB2YWxpZC4KKyAqICBTbyBydWxlIDEgc2hvdWxkIGJlIG1vZGlmaWVkIGFz
CisgKiAgNCkgV2hlbiBzZXQqdWlkaW5nIF9mcm9tXyBvbmUgb2Yge3IsZSxz
fXVpZCA9PSAwIF90b18gYWxsIG9mCisgKiAge3IsZSxzfXVpZCAhPSAwLCB0
aGUgZmlsZSBzeXN0ZW0gcGVybWl0dGVkIGFuZCBlZmZlY3RpdmUgCisgKiAg
Y2FwYWJpbGl0aWVzIGFyZSBjbGVhcmVkIGJhc2VkIG9uIHRoZSB2YWx1ZSBv
ZiBmc3VpZCAhPSAwLCAKKyAqICBhbmQgb3RoZXIgZWZmZWN0aXZlIGFuZCBw
ZXJtaXR0ZWQgY2FwYWJpbHRpZXMgd2lsbCBiZSBjbGVhcmVkIAorICogIHJl
Z2FyZGxlc3Mgb2YgdGhlIHZhbHVlIG9mIGZzdWlkLgogICovCiBzdGF0aWMg
aW5saW5lIHZvaWQgY2FwX2VtdWxhdGVfc2V0eHVpZChpbnQgb2xkX3J1aWQs
IGludCBvbGRfZXVpZCwgCiAJCQkJICAgICAgIGludCBvbGRfc3VpZCkKQEAg
LTQ3OSw4ICs0ODgsMTQgQEAKIAlpZiAoKG9sZF9ydWlkID09IDAgfHwgb2xk
X2V1aWQgPT0gMCB8fCBvbGRfc3VpZCA9PSAwKSAmJgogCSAgICAoY3VycmVu
dC0+dWlkICE9IDAgJiYgY3VycmVudC0+ZXVpZCAhPSAwICYmIGN1cnJlbnQt
PnN1aWQgIT0gMCkgJiYKIAkgICAgIWN1cnJlbnQtPmtlZXBfY2FwYWJpbGl0
aWVzKSB7Ci0JCWNhcF9jbGVhcihjdXJyZW50LT5jYXBfcGVybWl0dGVkKTsK
LQkJY2FwX2NsZWFyKGN1cnJlbnQtPmNhcF9lZmZlY3RpdmUpOworCQlpZiAo
Y3VycmVudC0+ZnN1aWQgIT0gMCkgeworCQkJY2FwX2NsZWFyKGN1cnJlbnQt
PmNhcF9wZXJtaXR0ZWQpOworCQkJY2FwX2NsZWFyKGN1cnJlbnQtPmNhcF9l
ZmZlY3RpdmUpOworCQl9CisJCWVsc2UgeworCQkJY2FwX3QoY3VycmVudC0+
Y2FwX2VmZmVjdGl2ZSkgJj0gQ0FQX0ZTX01BU0s7CisJCQljYXBfdChjdXJy
ZW50LT5jYXBfcGVybWl0dGVkKSAmPSBDQVBfRlNfTUFTSzsKKwkJfQogCX0K
IAlpZiAob2xkX2V1aWQgPT0gMCAmJiBjdXJyZW50LT5ldWlkICE9IDApIHsK
IAkJY2FwX2NsZWFyKGN1cnJlbnQtPmNhcF9lZmZlY3RpdmUpOwo=

--0-18106085-1031173878=:37422--
