Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280059AbRKEAAl>; Sun, 4 Nov 2001 19:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280032AbRKEAAc>; Sun, 4 Nov 2001 19:00:32 -0500
Received: from druid.if.uj.edu.pl ([149.156.64.221]:26387 "HELO
	druid.if.uj.edu.pl") by vger.kernel.org with SMTP
	id <S280059AbRKEAAO>; Sun, 4 Nov 2001 19:00:14 -0500
Date: Mon, 5 Nov 2001 01:00:09 +0100 (CET)
From: Maciej Zenczykowski <maze@druid.if.uj.edu.pl>
To: Thomas Hood <jdthood@mail.com>
Cc: <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.12-ac3 floppy module requires 0x3f0-0x3f1 ioports
In-Reply-To: <1004752951.1104.4.camel@thanatos>
Message-ID: <Pine.LNX.4.33.0111050050160.27009-200000@druid.if.uj.edu.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1667900096-871493789-1004918409=:27009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1667900096-871493789-1004918409=:27009
Content-Type: TEXT/PLAIN; charset=US-ASCII

On 2 Nov 2001, Thomas Hood wrote:
> Alan Cox wrote:
> > Maciej Zenczykowski wrote:
> >> Is there any reason why the floppy module requires
> >> the ioport range 0x3f0-0x3f1 in order to load?  On
> >> my computer /proc/ioports reports this range as used
> >> by PnPBIOS PNP0c02, thus the floppy module cannot
> >> reserve the range 0x3f0-0x3f5 and refuses to load.
> >
> > This is a bug in the PnPBIOS experimental code -
> > turn off PnPBIOS and/or update for the moment
>
> A fix for this problem went in to 2.4.13-ac2.  Please
> try that kernel (or a later -ac kernel) and report back.

Well just tried kernel 2.4.13-ac6 and there is absolutely no difference.

After applying the attached patch all works OK...

Maciej Zenczykowski

nb. modprobe rivafb leaves the kernel's idea of whats on screen out of
sync with the truth.  i.e. modprobe rivafb on tty2 and you end up with
tty1 on the screen, but keypresses going to tty2...

---1667900096-871493789-1004918409=:27009
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=mz-floppy-patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0111050100090.27009@druid.if.uj.edu.pl>
Content-Description: floppy patch
Content-Disposition: attachment; filename=mz-floppy-patch

LS0tIGRyaXZlcnMvYmxvY2svZmxvcHB5LmMuYmVmb3JlLW1hemUJU3VuIE9j
dCAyMSAxOTowOToyMSAyMDAxDQorKysgZHJpdmVycy9ibG9jay9mbG9wcHku
YwlUdWUgT2N0IDMwIDIxOjQ2OjQ2IDIwMDENCkBAIC00MjI4LDcgKzQyMjgs
NyBAQA0KIAkJRkRDUy0+cmF3Y21kID0gMjsNCiAJCWlmICh1c2VyX3Jlc2V0
X2ZkYygtMSxGRF9SRVNFVF9BTFdBWVMsMCkpew0KICAJCQkvKiBmcmVlIGlv
cG9ydHMgcmVzZXJ2ZWQgYnkgZmxvcHB5X2dyYWJfaXJxX2FuZF9kbWEoKSAq
Lw0KLSAJCQlyZWxlYXNlX3JlZ2lvbihGRENTLT5hZGRyZXNzLCA2KTsNCisg
CQkJcmVsZWFzZV9yZWdpb24oRkRDUy0+YWRkcmVzcysyLCA0KTsNCiAgCQkJ
cmVsZWFzZV9yZWdpb24oRkRDUy0+YWRkcmVzcys3LCAxKTsNCiAJCQlGRENT
LT5hZGRyZXNzID0gLTE7DQogCQkJRkRDUy0+dmVyc2lvbiA9IEZEQ19OT05F
Ow0KQEAgLTQyMzgsNyArNDIzOCw3IEBADQogCQlGRENTLT52ZXJzaW9uID0g
Z2V0X2ZkY192ZXJzaW9uKCk7DQogCQlpZiAoRkRDUy0+dmVyc2lvbiA9PSBG
RENfTk9ORSl7DQogIAkJCS8qIGZyZWUgaW9wb3J0cyByZXNlcnZlZCBieSBm
bG9wcHlfZ3JhYl9pcnFfYW5kX2RtYSgpICovDQotIAkJCXJlbGVhc2VfcmVn
aW9uKEZEQ1MtPmFkZHJlc3MsIDYpOw0KKyAJCQlyZWxlYXNlX3JlZ2lvbihG
RENTLT5hZGRyZXNzKzIsIDQpOw0KICAJCQlyZWxlYXNlX3JlZ2lvbihGRENT
LT5hZGRyZXNzKzcsIDEpOw0KIAkJCUZEQ1MtPmFkZHJlc3MgPSAtMTsNCiAJ
CQljb250aW51ZTsNCkBAIC00MzE3LDggKzQzMTcsOCBAQA0KIA0KIAlmb3Ig
KGZkYz0wOyBmZGM8IE5fRkRDOyBmZGMrKyl7DQogCQlpZiAoRkRDUy0+YWRk
cmVzcyAhPSAtMSl7DQotCQkJaWYgKCFyZXF1ZXN0X3JlZ2lvbihGRENTLT5h
ZGRyZXNzLCA2LCAiZmxvcHB5IikpIHsNCi0JCQkJRFBSSU5UKCJGbG9wcHkg
aW8tcG9ydCAweCUwNGx4IGluIHVzZVxuIiwgRkRDUy0+YWRkcmVzcyk7DQor
CQkJaWYgKCFyZXF1ZXN0X3JlZ2lvbihGRENTLT5hZGRyZXNzICsgMiwgNCwg
ImZsb3BweSIpKSB7DQorCQkJCURQUklOVCgiRmxvcHB5IGlvLXBvcnQgMHgl
MDRseCBpbiB1c2VcbiIsIEZEQ1MtPmFkZHJlc3MgKyAyKTsNCiAJCQkJZ290
byBjbGVhbnVwMTsNCiAJCQl9DQogCQkJaWYgKCFyZXF1ZXN0X3JlZ2lvbihG
RENTLT5hZGRyZXNzICsgNywgMSwgImZsb3BweSBESVIiKSkgew0KQEAgLTQz
NDksMTIgKzQzNDksMTIgQEANCiAJaXJxZG1hX2FsbG9jYXRlZCA9IDE7DQog
CXJldHVybiAwOw0KIGNsZWFudXAyOg0KLQlyZWxlYXNlX3JlZ2lvbihGRENT
LT5hZGRyZXNzLCA2KTsNCisJcmVsZWFzZV9yZWdpb24oRkRDUy0+YWRkcmVz
cyArIDIsIDQpOw0KIGNsZWFudXAxOg0KIAlmZF9mcmVlX2lycSgpOw0KIAlm
ZF9mcmVlX2RtYSgpOw0KIAl3aGlsZSgtLWZkYyA+PSAwKSB7DQotCQlyZWxl
YXNlX3JlZ2lvbihGRENTLT5hZGRyZXNzLCA2KTsNCisJCXJlbGVhc2VfcmVn
aW9uKEZEQ1MtPmFkZHJlc3MgKyAyLCA0KTsNCiAJCXJlbGVhc2VfcmVnaW9u
KEZEQ1MtPmFkZHJlc3MgKyA3LCAxKTsNCiAJfQ0KIAlNT0RfREVDX1VTRV9D
T1VOVDsNCkBAIC00NDIxLDcgKzQ0MjEsNyBAQA0KIAlvbGRfZmRjID0gZmRj
Ow0KIAlmb3IgKGZkYyA9IDA7IGZkYyA8IE5fRkRDOyBmZGMrKykNCiAJCWlm
IChGRENTLT5hZGRyZXNzICE9IC0xKSB7DQotCQkJcmVsZWFzZV9yZWdpb24o
RkRDUy0+YWRkcmVzcywgNik7DQorCQkJcmVsZWFzZV9yZWdpb24oRkRDUy0+
YWRkcmVzcysyLCA0KTsNCiAJCQlyZWxlYXNlX3JlZ2lvbihGRENTLT5hZGRy
ZXNzKzcsIDEpOw0KIAkJfQ0KIAlmZGMgPSBvbGRfZmRjOw0K
---1667900096-871493789-1004918409=:27009--
