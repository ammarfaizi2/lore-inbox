Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129857AbRAERtU>; Fri, 5 Jan 2001 12:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129859AbRAERtK>; Fri, 5 Jan 2001 12:49:10 -0500
Received: from pony-express.cs.rit.edu ([129.21.30.24]:46787 "EHLO
	pony-express.cs.rit.edu") by vger.kernel.org with ESMTP
	id <S129857AbRAERtB>; Fri, 5 Jan 2001 12:49:01 -0500
Date: Fri, 5 Jan 2001 12:48:50 -0500 (EST)
From: Aaron Gaudio <adg1653@cs.rit.edu>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.0 pre, undefined symbol in atyfb.o
Message-ID: <Pine.GSO.4.04.10101051131220.4447-200000@smurfette.cs.rit.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-978716930=:4447"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-978716930=:4447
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE

I'm not a subscriber to this list, cause I don't usually muck around with
kernel code, so if anyone needs to reply to me, make sure to CC me in.

I was trying to compile the 2.4.0 prerelease with the aty framebuffer,
and the kernel failed to link due to an unresolved symbol in
drivers/video/atyfb.o (__bad_udelay). The problem seems to be that
in <asm/delay.h>, it doesn't allow arguments to udelay greater than=20
20000 (despite the warning in <linux/delay.h> indicating 50000 should be
the max). I patched atyfb.c to use mdelay here instead of udelay (line
1754 or thereabouts), and the kernel compiled and linked. I haven't been
able to reboot yet cause I have to do some work to justify my paycheck :)
FWIW, the tiny patch is included as an attachment.


--=20

Aaron Gaudio
icy_manipulator @ mindless.com
                             --------------
                       http://www.rit.edu/~adg1653
    "Information is free. Knowledge is expensive. Wisdom is priceless."
                             --------------
Email Usage Policy: http://www.rit.edu/~adg1653/email.shtml

Z=E0iji=E0n

---559023410-851401618-978716930=:4447
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN; name=atyfb-patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.04.10101051248500.4447@smurfette.cs.rit.edu>
Content-Description: 
Content-Disposition: attachment; filename=atyfb-patch

SGVsbG8gYWxsLiBJJ20gbm90IGEgc3Vic2NyaWJlciwgY2F1c2UgSSBkb24n
dCBub3JtYWxseSBtdWNoIGFyb3VuZCB3aXRoDQprZXJuZWwgY29kZSwgc28g
aWYgeW91IG5lZWQgdG8gcmVwbHkgdG8gbWUsIHBsZWFzZSBDQyBteSBlbWFp
bCBhZGRyZXNzDQooaWN5X21hbmlwdWxhdG9yQG1pbmRsZXNzLmNvbSkuDQoN
CkkgdHJpZWQgdG8gY29tcGlsZSB0aGUgbmV3IDIuNC4wIHByZXJlbGVhc2Ug
YW5kIGl0IGZhaWxzDQp3aGVuIHRyeWluZyB0byBsaW5rIHZtbGludXgsIGNv
bXBsYWluaW5nIHRoYXQgdGhlIHN5bWJvbCBfX2JhZF91ZGVsYXkNCmlzIHVu
ZGVmaW5lZCBpbiB0aGUgdGV4dCBzZWN0aW9uIG9mIGF0eV9zZXRfcGxsMTg4
MTggaW4gZHJpdmVycy92aWRlby9hdHlmYi5vLiANClVwb24gc29tZSBzaW1w
bGlzdGljIGluc3BlY3Rpb24sIGl0IHNlZW1zIHRoZSBjdWxwcml0IGlzIGxp
bmUgMTc1Nywgd2hpY2gNCmNhbGxzIHVkZWxheSg1MDAwMCkuIEluIDxhc20v
ZGVsYXkuaD4gKGluY2x1ZGVkIGJ5IDxsaW51eC9kZWxheS5oPiksDQpfX2Jh
ZF91ZGVsYXkgaXMgdXNlZCBpZiB0aGUgYXJndW1lbnQgdG8gdWRlbGF5IGlz
ID4gMjAwMDAsIDxsaW51eC9kZWxheS5oPg0KYWxzbyBtZW50aW9ucyB0aGF0
IG9uZSBzaG91bGRuJ3QgdXNlIG1vcmUgdGhhbiA1IG1pbGxpc2Vjb25kcyBm
b3IgdWRlbGF5LA0KcHJlZmVycmluZyBtZGVsYXkgaW4gdGhpcyBjYXNlLiBX
ZWxsLCB0aG9zZSAyIG51bWJlcnMgZG9uJ3Qgc2VlbSB0byBjb3JyZXNwb25k
LA0KYnV0IHJhdGhlciB0aGFuIGZ1dHogd2l0aCB0aGUgZGVmaW5pdGlvbnMg
b2YgdWRlbGF5IGFuZCBtZGVsYXkgKHdoaWNoIEkgcmVhbGx5DQpoYXZlIG5v
IGNsdWUgYWJvdXQpLCBJIGNoYW5nZWQgbGluZSAxNzU3IGluIGF0eWZiLmMg
dG8gY2FsbCBtZGVsYXkgaW5zdGVhZA0Kb2YgdWRlbGF5LCBhbmQgdGhlIHBh
dGNoIGZvciB0aGlzIGZvbGxvd3MgdGhpcyB0ZXh0LiBQZXJoYXBzIHRoYXQn
cyBub3QgdGhlDQpiZXN0IHNvbHV0aW9uLCBJJ2xsIGxldCB5b3UgZ3V5cyBk
ZWNpZGUgdGhhdCwgYnV0IGl0IGxldHMgbWUgY29tcGlsZSBhbmQgbGluaw0K
dGhlIGtlcm5lbCBpbWFnZS4gSGF2ZW4ndCB0cmllZCBhY3R1YWxseSBsb2Fk
aW5nIGl0IHlldCAoaGF2ZSB0byBkbyBzb21lIHdvcmsNCnRvIGp1c3RpZnkg
bXkgcGF5Y2hlY2sgZmlyc3QgOikuIA0KDQotLSANCg0KQWFyb24gR2F1ZGlv
DQppY3lfbWFuaXB1bGF0b3IgQCBtaW5kbGVzcy5jb20NCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgLS0tLS0tLS0tLS0tLS0NCiAgICAgICAgICAg
ICAgICAgICAgICAgaHR0cDovL3d3dy5yaXQuZWR1L35hZGcxNjUzDQogICAg
IkluZm9ybWF0aW9uIGlzIGZyZWUuIEtub3dsZWRnZSBpcyBleHBlbnNpdmUu
IFdpc2RvbSBpcyBwcmljZWxlc3MuIg0KICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAtLS0tLS0tLS0tLS0tLQ0KRW1haWwgVXNhZ2UgUG9saWN5OiBo
dHRwOi8vd3d3LnJpdC5lZHUvfmFkZzE2NTMvZW1haWwuc2h0bWwNCg0KWuBp
amngbg0K
---559023410-851401618-978716930=:4447--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
