Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132982AbRDYW4f>; Wed, 25 Apr 2001 18:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132984AbRDYW4Z>; Wed, 25 Apr 2001 18:56:25 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:25461 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S132982AbRDYW4S>; Wed, 25 Apr 2001 18:56:18 -0400
Date: Wed, 25 Apr 2001 18:56:14 -0400 (EDT)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: Nigel Gamble <nigel@nrg.org>
cc: Michael Rothwell <rothwell@holly-springs.nc.us>,
        linux-kernel@vger.kernel.org
Subject: Re: #define HZ 1024 -- negative effects
In-Reply-To: <Pine.LNX.4.05.10104251525130.4843-100000@cosmic.nrg.org>
Message-ID: <Pine.LNX.4.10.10104251850400.3127-300000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1904360410-1485817386-988239374=:3127"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1904360410-1485817386-988239374=:3127
Content-Type: TEXT/PLAIN; charset=US-ASCII

> > Are there any negative effects of editing include/asm/param.h to change 
> > HZ from 100 to 1024? Or any other number? This has been suggested as a 
> > way to improve the responsiveness of the GUI on a Linux system. Does it 
...
> Why not just run the X server at a realtime priority?  Then it will get
> to respond to existing events, such as keyboard and mouse input,
> promptly without creating lots of superfluous extra clock interrupts.
> I think you will find this is a better solution.

it's surprisingly ineffective; usually, if someone thinks responsiveness
is bad, there's a problem with the system.  for instance, if the system
is swapping, setting X (and wm, and clients) to RT makes little difference,
since the kernel is stealing pages from them, regardless of their scheduling
priority.

if you're curious, you might be interested in two toy programs
I've attached.  one is "setrealtime", which will make a pid RT, or else act
as a wrapper (ala /bin/time).  I have it installed suid root on my system,
though this is rather dangerous if your have lusers around.  the second is a
simple memory-hog: mmaps a bunch of ram, and keeps it active (printing out a
handy measure of how long it took to touch its pages...)

regards, mark hahn.

--1904360410-1485817386-988239374=:3127
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="useup.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.10.10104251856140.3127@coffee.psychology.mcmaster.ca>
Content-Description: useup.c
Content-Disposition: attachment; filename="useup.c"

I2luY2x1ZGUgPHVuaXN0ZC5oPg0KI2luY2x1ZGUgPHN0ZGxpYi5oPg0KI2lu
Y2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c3lzL3RpbWUuaD4NCiNpbmNs
dWRlIDxzeXMvbW1hbi5oPg0KDQp2b2xhdGlsZSB1bnNpZ25lZCBzaW5rOw0K
DQpkb3VibGUgc2Vjb25kKCkgew0KICAgIHN0cnVjdCB0aW1ldmFsIHR2Ow0K
ICAgIGdldHRpbWVvZmRheSgmdHYsMCk7DQogICAgcmV0dXJuIHR2LnR2X3Nl
YyArIDFlLTYgKiB0di50dl91c2VjOw0KfQ0KDQppbnQNCm1haW4oaW50IGFy
Z2MsIGNoYXIgKmFyZ3ZbXSkgew0KICAgIGludCBkb1dyaXRlID0gMTsNCiAg
ICB1bnNpZ25lZCBzaXplID0gODAgKiAxMDI0ICogMTAyNDsNCg0KICAgIGlu
dCBsZXR0ZXI7DQogICAgd2hpbGUgKChsZXR0ZXIgPSBnZXRvcHQoYXJnYywg
YXJndiwgInM6d3J2aD8iICkpICE9IC0xKSB7DQoJc3dpdGNoKGxldHRlcikg
ew0KCWNhc2UgJ3MnOiBzaXplID0gYXRvaShvcHRhcmcpICogMTAyNCAqIDEw
MjQ7IGJyZWFrOw0KCWNhc2UgJ3cnOiBkb1dyaXRlID0gMTsgYnJlYWs7DQoJ
ZGVmYXVsdDoNCgkgICAgZnByaW50ZihzdGRlcnIsInVzZXVwIFstcyBtYl1b
LXddXG4iKTsNCgkgICAgZXhpdCgxKTsNCgl9DQogICAgfQ0KICAgIGludCAq
YmFzZSA9IChpbnQqKSBtbWFwKDAsIHNpemUsIA0KCQkJICAgICAgUFJPVF9S
RUFEfFBST1RfV1JJVEUsIA0KCQkJICAgICAgTUFQX0FOT05ZTU9VU3xNQVBf
UFJJVkFURSwgMCwgMCk7DQogICAgaWYgKGJhc2UgPT0gTUFQX0ZBSUxFRCkg
ew0KCXBlcnJvcigibW1hcCBmYWlsZWQiKTsNCglleGl0KDEpOw0KICAgIH0N
Cg0KICAgIGludCAqZW5kID0gYmFzZSArIHNpemUvNDsNCg0KICAgIHdoaWxl
ICgxKSB7DQoJZG91YmxlIHN0YXJ0ID0gc2Vjb25kKCk7DQoJaWYgKGRvV3Jp
dGUpDQoJICAgIGZvciAoaW50ICpwID0gYmFzZTsgcCA8IGVuZDsgcCArPSAx
MDI0KQ0KCQkqcCA9IDA7DQoJZWxzZSB7DQoJICAgIHVuc2lnbmVkIHN1bSA9
IDA7DQoJICAgIGZvciAoaW50ICpwID0gYmFzZTsgcCA8IGVuZDsgcCArPSAx
MDI0KQ0KCQlzdW0gKz0gKnA7DQoJICAgIHNpbmsgPSBzdW07DQoJfQ0KCXBy
aW50ZigiJWZcbiIsMTAwMCooc2Vjb25kKCkgLSBzdGFydCkpOw0KICAgIH0N
Cn0NCg==
--1904360410-1485817386-988239374=:3127
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="setrealtime.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.10.10104251856141.3127@coffee.psychology.mcmaster.ca>
Content-Description: setrealtime.c
Content-Disposition: attachment; filename="setrealtime.c"

I2luY2x1ZGUgPHVuaXN0ZC5oPg0KI2luY2x1ZGUgPHN0ZGxpYi5oPg0KI2lu
Y2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c2NoZWQuaD4NCg0KaW50DQpt
YWluKGludCBhcmdjLCBjaGFyICphcmd2W10pIHsNCiAgICBpbnQgdWlkID0g
Z2V0dWlkKCk7DQogICAgaW50IHBpZCA9IGF0b2koYXJndlsxXSk7DQogICAg
aW50IHNjaGVkX2ZpZm9fbWluLCBzY2hlZF9maWZvX21heDsNCiAgICBzdGF0
aWMgc3RydWN0IHNjaGVkX3BhcmFtIHNjaGVkX3Bhcm1zOw0KDQogICAgaWYg
KCFwaWQpDQoJcGlkID0gZ2V0cGlkKCk7DQoNCiAgICBzY2hlZF9maWZvX21p
biA9IHNjaGVkX2dldF9wcmlvcml0eV9taW4oU0NIRURfRklGTyk7DQogICAg
c2NoZWRfZmlmb19tYXggPSBzY2hlZF9nZXRfcHJpb3JpdHlfbWF4KFNDSEVE
X0ZJRk8pOw0KICAgIHNjaGVkX3Bhcm1zLnNjaGVkX3ByaW9yaXR5ID0gc2No
ZWRfZmlmb19taW4gKyAxOw0KDQogICAgaWYgKHNjaGVkX3NldHNjaGVkdWxl
cihwaWQsIFNDSEVEX0ZJRk8sICZzY2hlZF9wYXJtcykgPT0gLTEpDQogICAg
ICAgIHBlcnJvcigiY2Fubm90IHNldCByZWFsdGltZSBzY2hlZHVsaW5nIHBv
bGljeSIpOw0KDQogICAgaWYgKHVpZCkNCglzZXR1aWQodWlkKTsNCg0KICAg
IGlmIChwaWQgPT0gZ2V0cGlkKCkpDQoJZXhlY3ZwKGFyZ3ZbMV0sJmFyZ3Zb
MV0pOw0KICAgIHJldHVybiAwOw0KfQ0K
--1904360410-1485817386-988239374=:3127--
