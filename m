Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbUDSQlz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 12:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbUDSQkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 12:40:40 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:12165 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S261451AbUDSQkA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 12:40:00 -0400
Subject: Re: NFS and kernel 2.6.x
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Marc Singer <elf@buici.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1082256704.3619.68.camel@lade.trondhjem.org>
References: <20040415185355.1674115b.akpm@osdl.org>
	 <1082084048.7141.142.camel@lade.trondhjem.org>
	 <20040416045924.GA4870@linuxace.com>
	 <1082093346.7141.159.camel@lade.trondhjem.org>
	 <pan.2004.04.17.16.44.00.630010@smurf.noris.de>
	 <1082225747.2580.18.camel@lade.trondhjem.org> <20040417183219.GB3856@flea>
	 <1082228313.2580.25.camel@lade.trondhjem.org> <20040417190107.GA4179@flea>
	 <1082228963.2580.34.camel@lade.trondhjem.org>
	 <20040417201914.B21974@flint.arm.linux.org.uk>
	 <1082256704.3619.68.camel@lade.trondhjem.org>
Content-Type: multipart/mixed; boundary="=-Y8rWLegEM4JA1/p+Ik2G"
Message-Id: <1082392797.2559.54.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 19 Apr 2004 12:39:57 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Y8rWLegEM4JA1/p+Ik2G
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2004-04-17 at 22:51, Trond Myklebust wrote:
> On Sat, 2004-04-17 at 12:19, Russell King wrote:
> 
> > Firstly, as far as I can see, args[] is uninitialised.  If match_token
> > doesn't touch args[] then we pass match_int some uninitialised kernel
> > memory.
> >
> > Secondly, we seem to exit if match_int doesn't parse a number.  Not
> > all options in "tokens" have a number associated with them, including
> > ones like "tcp".
> 
> Agreed. The correct fix should be something like the appended patch. It
> depends on all tokens that do take an integer argument being listed
> first in the enum.
> 
> Comments?

It turned out there were a few extra issues that weren't fixed by the
previous patch. Thanks to boris@macbeth.rhoen.de for helping debug them.

Hopefully this will be the final set of fixes.

Cheers,
  Trond



--=-Y8rWLegEM4JA1/p+Ik2G
Content-Description: 
Content-Disposition: inline; filename=linux-2.6.6-02-fix_nfsroot.dif
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=iso-8859-1

IG5mc3Jvb3QuYyB8ICAgMzMgKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQogMSBm
aWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAt
dSAtLXJlY3Vyc2l2ZSAtLW5ldy1maWxlIC0tc2hvdy1jLWZ1bmN0aW9uIGxpbnV4LTIuNi42LTAx
LXNvZnQvZnMvbmZzL25mc3Jvb3QuYyBsaW51eC0yLjYuNi0wMi1maXhfbmZzcm9vdC9mcy9uZnMv
bmZzcm9vdC5jDQotLS0gbGludXgtMi42LjYtMDEtc29mdC9mcy9uZnMvbmZzcm9vdC5jCTIwMDQt
MDQtMTcgMjM6MDE6MDkuMDAwMDAwMDAwIC0wNDAwDQorKysgbGludXgtMi42LjYtMDItZml4X25m
c3Jvb3QvZnMvbmZzL25mc3Jvb3QuYwkyMDA0LTA0LTE5IDEyOjA4OjMxLjAwMDAwMDAwMCAtMDQw
MA0KQEAgLTExNywxMSArMTE3LDE2IEBAIHN0YXRpYyBpbnQgbW91bnRfcG9ydCBfX2luaXRkYXRh
ID0gMDsJCS8NCiAgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLw0KIA0KIGVudW0gew0KKwkvKiBPcHRpb25z
IHRoYXQgdGFrZSBpbnRlZ2VyIGFyZ3VtZW50cyAqLw0KIAlPcHRfcG9ydCwgT3B0X3JzaXplLCBP
cHRfd3NpemUsIE9wdF90aW1lbywgT3B0X3JldHJhbnMsIE9wdF9hY3JlZ21pbiwNCi0JT3B0X2Fj
cmVnbWF4LCBPcHRfYWNkaXJtaW4sIE9wdF9hY2Rpcm1heCwgT3B0X3NvZnQsIE9wdF9oYXJkLCBP
cHRfaW50ciwNCisJT3B0X2FjcmVnbWF4LCBPcHRfYWNkaXJtaW4sIE9wdF9hY2Rpcm1heCwNCisJ
LyogT3B0aW9ucyB0aGF0IHRha2Ugbm8gYXJndW1lbnRzICovDQorCU9wdF9zb2Z0LCBPcHRfaGFy
ZCwgT3B0X2ludHIsDQogCU9wdF9ub2ludHIsIE9wdF9wb3NpeCwgT3B0X25vcG9zaXgsIE9wdF9j
dG8sIE9wdF9ub2N0bywgT3B0X2FjLCANCiAJT3B0X25vYWMsIE9wdF9sb2NrLCBPcHRfbm9sb2Nr
LCBPcHRfdjIsIE9wdF92MywgT3B0X3VkcCwgT3B0X3RjcCwNCi0JT3B0X2Jyb2tlbl9zdWlkLCBP
cHRfZXJyLA0KKwlPcHRfYnJva2VuX3N1aWQsDQorCS8qIEVycm9yIHRva2VuICovDQorCU9wdF9l
cnINCiB9Ow0KIA0KIHN0YXRpYyBtYXRjaF90YWJsZV90IHRva2VucyA9IHsNCkBAIC0xNDYsOSAr
MTUxLDEzIEBAIHN0YXRpYyBtYXRjaF90YWJsZV90IHRva2VucyA9IHsNCiAJe09wdF9ub2FjLCAi
bm9hYyJ9LA0KIAl7T3B0X2xvY2ssICJsb2NrIn0sDQogCXtPcHRfbm9sb2NrLCAibm9sb2NrIn0s
DQorCXtPcHRfdjIsICJuZnN2ZXJzPTIifSwNCiAJe09wdF92MiwgInYyIn0sDQorCXtPcHRfdjMs
ICJuZnN2ZXJzPTMifSwNCiAJe09wdF92MywgInYzIn0sDQorCXtPcHRfdWRwLCAicHJvdG89dWRw
In0sDQogCXtPcHRfdWRwLCAidWRwIn0sDQorCXtPcHRfdGNwLCAicHJvdG89dGNwIn0sDQogCXtP
cHRfdGNwLCAidGNwIn0sDQogCXtPcHRfYnJva2VuX3N1aWQsICJicm9rZW5fc3VpZCJ9LA0KIAl7
T3B0X2VyciwgTlVMTH0NCkBAIC0xNjIsMjUgKzE3MSwyMSBAQCBzdGF0aWMgbWF0Y2hfdGFibGVf
dCB0b2tlbnMgPSB7DQogc3RhdGljIGludCBfX2luaXQgcm9vdF9uZnNfcGFyc2UoY2hhciAqbmFt
ZSwgY2hhciAqYnVmKQ0KIHsNCiANCi0JY2hhciAqcDsNCisJY2hhciAqcCwgKnBhdGggPSBuYW1l
Ow0KIAlzdWJzdHJpbmdfdCBhcmdzW01BWF9PUFRfQVJHU107DQogCWludCBvcHRpb247DQogDQog
CWlmICghbmFtZSkNCiAJCXJldHVybiAxOw0KIA0KLQlpZiAobmFtZVswXSAmJiBzdHJjbXAobmFt
ZSwgImRlZmF1bHQiKSl7DQotCQlzdHJsY3B5KGJ1ZiwgbmFtZSwgTkZTX01BWFBBVEhMRU4pOw0K
LQkJcmV0dXJuIDE7DQotCX0NCiAJd2hpbGUgKChwID0gc3Ryc2VwICgmbmFtZSwgIiwiKSkgIT0g
TlVMTCkgew0KIAkJaW50IHRva2VuOyANCiAJCWlmICghKnApDQogCQkJY29udGludWU7DQogCQl0
b2tlbiA9IG1hdGNoX3Rva2VuKHAsIHRva2VucywgYXJncyk7DQogDQotCQkvKiAldSB0b2tlbnMg
b25seSAqLw0KLQkJaWYgKG1hdGNoX2ludCgmYXJnc1swXSwgJm9wdGlvbikpDQorCQkvKiAldSB0
b2tlbnMgb25seS4gQmV3YXJlIGlmIHlvdSBhZGQgbmV3IHRva2VucyEgKi8NCisJCWlmICh0b2tl
biA8IE9wdF9zb2Z0ICYmIG1hdGNoX2ludCgmYXJnc1swXSwgJm9wdGlvbikpDQogCQkJcmV0dXJu
IDA7DQogCQlzd2l0Y2ggKHRva2VuKSB7DQogCQkJY2FzZSBPcHRfcG9ydDoNCkBAIC0yNjUsNiAr
MjcwLDEzIEBAIHN0YXRpYyBpbnQgX19pbml0IHJvb3RfbmZzX3BhcnNlKGNoYXIgKm4NCiAJCQkJ
cmV0dXJuIDA7DQogCQl9DQogCX0NCisNCisJLyoNCisJICogQ29weSB0aGUgTkZTIHJlbW90ZSBw
YXRoIHRvIHRoZSBvdXRwdXQgYnVmZmVyLg0KKwkgKiBSZWxpZXMgb24gc3Ryc2VwKCkgaGF2aW5n
IGNvbnZlcnRlZCB0aGUgZGVsaW1pdGluZyAnLCcgdG8gJ1wwJy4NCisJICovDQorCWlmIChwYXRo
WzBdICE9ICdcMCcgJiYgc3RyY21wKHBhdGgsICJkZWZhdWx0IikgIT0gMCkNCisJCXN0cmxjcHko
YnVmLCBwYXRoLCBORlNfTUFYUEFUSExFTik7DQogCXJldHVybiAxOw0KIH0NCiANCkBAIC0yODMs
OSArMjk1LDYgQEAgc3RhdGljIGludCBfX2luaXQgcm9vdF9uZnNfbmFtZShjaGFyICpuYQ0KIAlu
ZnNfZGF0YS5mbGFncyAgICA9IE5GU19NT1VOVF9OT05MTTsJLyogTm8gbG9ja2QgaW4gbmZzIHJv
b3QgeWV0ICovDQogCW5mc19kYXRhLnJzaXplICAgID0gTkZTX0RFRl9GSUxFX0lPX0JVRkZFUl9T
SVpFOw0KIAluZnNfZGF0YS53c2l6ZSAgICA9IE5GU19ERUZfRklMRV9JT19CVUZGRVJfU0laRTsN
Ci0JbmZzX2RhdGEuYnNpemUJICA9IDA7DQotCW5mc19kYXRhLnRpbWVvICAgID0gNzsNCi0JbmZz
X2RhdGEucmV0cmFucyAgPSAzOw0KIAluZnNfZGF0YS5hY3JlZ21pbiA9IDM7DQogCW5mc19kYXRh
LmFjcmVnbWF4ID0gNjA7DQogCW5mc19kYXRhLmFjZGlybWluID0gMzA7DQo=

--=-Y8rWLegEM4JA1/p+Ik2G--
