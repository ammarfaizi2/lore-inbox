Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263233AbTCSWKX>; Wed, 19 Mar 2003 17:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263234AbTCSWKX>; Wed, 19 Mar 2003 17:10:23 -0500
Received: from ns0.cobite.com ([208.222.80.10]:35335 "EHLO ns0.cobite.com")
	by vger.kernel.org with ESMTP id <S263233AbTCSWKU>;
	Wed, 19 Mar 2003 17:10:20 -0500
Date: Wed, 19 Mar 2003 17:21:12 -0500 (EST)
From: David Mansfield <lkml@dm.cobite.com>
X-X-Sender: david@admin
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] cvsps support for parsing BK->CVS kernel tree logs
In-Reply-To: <20030319213738.GR30541@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0303191715390.19298-200000@admin>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-556791216-1329757273-1048112472=:19298"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---556791216-1329757273-1048112472=:19298
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 19 Mar 2003, Andrea Arcangeli wrote:

> I'm downloading the new version now... ;) thanks
> 
> > The file is actualy a substring match.  If the -f argument matches as a 
> 
> so it doesn't sound a regex. Being able to specify more than 1 -f would
> be very useful. Either that or regex would do it fine too with
> '^net/core', so as far as I can write stuff like -f
> '^net/core|^net/ipv4' I'm fine.
> 
> I also think using match by default in the regex is cleaner. So I can
> write -f 'net/core|net/ipv4' w/o bothering about the ^ because it become
> implicit. And I can still use '.*net/core.*' if I want a substring
> regex. I think substring search will be not common.
> 
> But really, any kind of way you implement the 'multiple file' thing is
> fine as far as I can specify more than 1 file ;).
> 

Attached is a patch (on top of previous which is on top of 2.0b5) changes 
the -f to regex match.  The regex is of course slightly slower than 
'strstr' but I agree the advantage is worth it.

It differs slightly in syntax (c library regex just works this way):

cvsps -f '^net/core\|^net/ipv4'
                   ^
                   You must escape the | symbol to separate the regex.

Try it out!

David

-- 
/==============================\
| David Mansfield              |
| lkml@dm.cobite.com           |
\==============================/

---556791216-1329757273-1048112472=:19298
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="cvsps-regex-filematch.patch"
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: attachment; filename="cvsps-regex-filematch.patch"

PyBwMQ0KSW5kZXg6IGN2c3BzLmMNCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0N
ClJDUyBmaWxlOiAvc3VsdS9jdnNfbWFzdGVyL2N2c3BzL2N2c3BzLmMsdg0K
cmV0cmlldmluZyByZXZpc2lvbiA0LjcxDQpkaWZmIC1iIC11IC1yNC43MSBj
dnNwcy5jDQotLS0gY3ZzcHMuYwkxOSBNYXIgMjAwMyAyMjoxMTowOSAtMDAw
MAk0LjcxDQorKysgY3ZzcHMuYwkxOSBNYXIgMjAwMyAyMjoxNToyNiAtMDAw
MA0KQEAgLTc4LDcgKzc4LDggQEANCiBzdGF0aWMgY29uc3QgY2hhciAqIHJl
c3RyaWN0X2F1dGhvcjsNCiBzdGF0aWMgaW50IGhhdmVfcmVzdHJpY3RfbG9n
Ow0KIHN0YXRpYyByZWdleF90IHJlc3RyaWN0X2xvZzsNCi1zdGF0aWMgY29u
c3QgY2hhciAqIHJlc3RyaWN0X2ZpbGU7DQorc3RhdGljIGludCBoYXZlX3Jl
c3RyaWN0X2ZpbGU7DQorc3RhdGljIHJlZ2V4X3QgcmVzdHJpY3RfZmlsZTsN
CiBzdGF0aWMgdGltZV90IHJlc3RyaWN0X2RhdGVfc3RhcnQ7DQogc3RhdGlj
IHRpbWVfdCByZXN0cmljdF9kYXRlX2VuZDsNCiBzdGF0aWMgY29uc3QgY2hh
ciAqIHJlc3RyaWN0X2JyYW5jaDsNCkBAIC0xMDgsNyArMTA5LDEwIEBADQog
c3RhdGljIGludCBjb21wYXJlX3BhdGNoX3NldHMoY29uc3Qgdm9pZCAqLCBj
b25zdCB2b2lkICopOw0KIHN0YXRpYyBpbnQgY29tcGFyZV9wYXRjaF9zZXRz
X2J5dGltZShjb25zdCB2b2lkICosIGNvbnN0IHZvaWQgKik7DQogc3RhdGlj
IGludCBpc19yZXZpc2lvbl9tZXRhZGF0YShjb25zdCBjaGFyICopOw0KK3N0
YXRpYyBpbnQgcGF0Y2hfc2V0X21lbWJlcl9yZWdleChQYXRjaFNldCAqIHBz
LCByZWdleF90ICogcmVnKTsNCisjaWYgMA0KIHN0YXRpYyBpbnQgcGF0Y2hf
c2V0X2NvbnRhaW5zX21lbWJlcihQYXRjaFNldCAqLCBjb25zdCBjaGFyICop
Ow0KKyNlbmRpZg0KIHN0YXRpYyBpbnQgcGF0Y2hfc2V0X2FmZmVjdHNfYnJh
bmNoKFBhdGNoU2V0ICosIGNvbnN0IGNoYXIgKik7DQogc3RhdGljIHZvaWQg
ZG9fY3ZzX2RpZmYoUGF0Y2hTZXQgKik7DQogc3RhdGljIFBhdGNoU2V0ICog
Y3JlYXRlX3BhdGNoX3NldCgpOw0KQEAgLTU3NCwxMCArNTc4LDIwIEBADQog
DQogCWlmIChzdHJjbXAoYXJndltpXSwgIi1mIikgPT0gMCkNCiAJew0KKwkg
ICAgaW50IGVycjsNCisNCiAJICAgIGlmICgrK2kgPj0gYXJnYykNCiAJCXVz
YWdlKCJhcmd1bWVudCB0byAtZiBtaXNzaW5nIiwgIiIpOw0KIA0KLQkgICAg
cmVzdHJpY3RfZmlsZSA9IGFyZ3ZbaSsrXTsNCisJICAgIGlmICgoZXJyID0g
cmVnY29tcCgmcmVzdHJpY3RfZmlsZSwgYXJndltpKytdLCBSRUdfTk9TVUIp
KSAhPSAwKQ0KKwkgICAgew0KKwkJY2hhciBlcnJidWZbMjU2XTsNCisJCXJl
Z2Vycm9yKGVyciwgJnJlc3RyaWN0X2ZpbGUsIGVycmJ1ZiwgMjU2KTsNCisJ
CXVzYWdlKCJiYWQgcmVnZXggdG8gLWYiLCBlcnJidWYpOw0KKwkgICAgfQ0K
Kw0KKwkgICAgaGF2ZV9yZXN0cmljdF9maWxlID0gMTsNCisNCiAJICAgIGNv
bnRpbnVlOw0KIAl9DQogCQ0KQEAgLTEwODAsNyArMTA5NCw3IEBADQogICAg
IGlmIChoYXZlX3Jlc3RyaWN0X2xvZyAmJiByZWdleGVjKCZyZXN0cmljdF9s
b2csIHBzLT5kZXNjciwgMCwgTlVMTCwgMCkgIT0gMCkNCiAJcmV0dXJuOw0K
IA0KLSAgICBpZiAocmVzdHJpY3RfZmlsZSAmJiAhcGF0Y2hfc2V0X2NvbnRh
aW5zX21lbWJlcihwcywgcmVzdHJpY3RfZmlsZSkpDQorICAgIGlmIChoYXZl
X3Jlc3RyaWN0X2ZpbGUgJiYgIXBhdGNoX3NldF9tZW1iZXJfcmVnZXgocHMs
ICZyZXN0cmljdF9maWxlKSkNCiAJcmV0dXJuOw0KIA0KICAgICBpZiAocmVz
dHJpY3RfYnJhbmNoICYmICFwYXRjaF9zZXRfYWZmZWN0c19icmFuY2gocHMs
IHJlc3RyaWN0X2JyYW5jaCkpDQpAQCAtMTMyNyw2ICsxMzQxLDcgQEANCiAg
ICAgcmV0dXJuIDA7DQogfQ0KIA0KKyNpZiAwDQogc3RhdGljIGludCBwYXRj
aF9zZXRfY29udGFpbnNfbWVtYmVyKFBhdGNoU2V0ICogcHMsIGNvbnN0IGNo
YXIgKiBmaWxlKQ0KIHsNCiAgICAgc3RydWN0IGxpc3RfaGVhZCAqIG5leHQg
PSBwcy0+bWVtYmVycy5uZXh0Ow0KQEAgLTEzMzYsNiArMTM1MSwyNCBAQA0K
IAlQYXRjaFNldE1lbWJlciAqIHBzbSA9IGxpc3RfZW50cnkobmV4dCwgUGF0
Y2hTZXRNZW1iZXIsIGxpbmspOw0KIAkNCiAJaWYgKHN0cnN0cihwc20tPmZp
bGUtPmZpbGVuYW1lLCBmaWxlKSkNCisJICAgIHJldHVybiAxOw0KKw0KKwlu
ZXh0ID0gbmV4dC0+bmV4dDsNCisgICAgfQ0KKw0KKyAgICByZXR1cm4gMDsN
Cit9DQorI2VuZGlmIA0KKw0KK3N0YXRpYyBpbnQgcGF0Y2hfc2V0X21lbWJl
cl9yZWdleChQYXRjaFNldCAqIHBzLCByZWdleF90ICogcmVnKQ0KK3sNCisg
ICAgc3RydWN0IGxpc3RfaGVhZCAqIG5leHQgPSBwcy0+bWVtYmVycy5uZXh0
Ow0KKw0KKyAgICB3aGlsZSAobmV4dCAhPSAmcHMtPm1lbWJlcnMpDQorICAg
IHsNCisJUGF0Y2hTZXRNZW1iZXIgKiBwc20gPSBsaXN0X2VudHJ5KG5leHQs
IFBhdGNoU2V0TWVtYmVyLCBsaW5rKTsNCisJDQorCWlmIChyZWdleGVjKCZy
ZXN0cmljdF9maWxlLCBwc20tPmZpbGUtPmZpbGVuYW1lLCAwLCBOVUxMLCAw
KSA9PSAwKQ0KIAkgICAgcmV0dXJuIDE7DQogDQogCW5leHQgPSBuZXh0LT5u
ZXh0Ow0K
---556791216-1329757273-1048112472=:19298--
