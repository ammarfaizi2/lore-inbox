Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317610AbSHaQEh>; Sat, 31 Aug 2002 12:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317616AbSHaQEh>; Sat, 31 Aug 2002 12:04:37 -0400
Received: from the.brain.uni-freiburg.de ([132.230.63.27]:3855 "EHLO
	the.brain.uni-freiburg.de") by vger.kernel.org with ESMTP
	id <S317610AbSHaQEg>; Sat, 31 Aug 2002 12:04:36 -0400
Date: Sat, 31 Aug 2002 18:09:03 +0200 (CEST)
From: Patrick McHardy <kaber@the.brain.uni-freiburg.de>
To: alan@lxorguk.ukuu.org.uk
cc: linux-kernel@vger.kernel.org
Subject: i810_audio problems + patch
Message-ID: <Pine.LNX.4.44.0208311757120.24208-200000@the.brain.uni-freiburg.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-427549889-1644595638-1030810143=:24208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---427549889-1644595638-1030810143=:24208
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi Alan,
somewhere between 2.4.18 and 2.4.19 i810_audio.c was changed to exclude
softmodems from initilization. Since then, i cannot use the mixer anymore
and also 44.1khz rates don't work anymore. Reverting the change made these
things work again.
I don't know if it's right what i did, could you please have a look at the
attached patch ?
For completeness, here is the output of dmesg and lspci -vv:

non-working:
i810: Intel 440MX found at IO 0x8400 and 0x8200, IRQ 5
i810_audio: Audio Controller supports 2 channels.
ac97_codec: AC97 Audio codec, id: 0x4358:0x5442 (Unknown)
i810_audio: codec 0 is a softmodem - skipping.

working:
i810: Intel 440MX found at IO 0x8400 and 0x8200, IRQ 5
i810_audio: Audio Controller supports 2 channels.
ac97_codec: AC97 Audio codec, id: 0x4358:0x5442 (Unknown)
i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not
present), total channels = 2

00:00.1 Multimedia audio controller: Intel Corp. 82440MX AC'97 Audio
Controller
        Subsystem: Samsung Electronics Co Ltd: Unknown device 2325
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 5
        Region 0: I/O ports at 8200 [size=256]
        Region 1: I/O ports at 8400 [size=64]

Thanks & bye,
Patrick

---427549889-1644595638-1030810143=:24208
Content-Type: TEXT/plain; name="i810_audio.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0208311809030.24208@the.brain.uni-freiburg.de>
Content-Description: 
Content-Disposition: attachment; filename="i810_audio.diff"

ZGlmZiAtdXJOIGxpbnV4LTIuNC4yMC1wcmU0LWNsZWFuL2RyaXZlcnMvc291
bmQvaTgxMF9hdWRpby5jIGxpbnV4LTIuNC4yMC1wcmU0L2RyaXZlcnMvc291
bmQvaTgxMF9hdWRpby5jDQotLS0gbGludXgtMi40LjIwLXByZTQtY2xlYW4v
ZHJpdmVycy9zb3VuZC9pODEwX2F1ZGlvLmMJMjAwMi0wOC0yOSAwMTo1Njow
My4wMDAwMDAwMDAgKzAyMDANCisrKyBsaW51eC0yLjQuMjAtcHJlNC9kcml2
ZXJzL3NvdW5kL2k4MTBfYXVkaW8uYwkyMDAyLTA4LTMxIDE3OjQ0OjM2LjAw
MDAwMDAwMCArMDIwMA0KQEAgLTI2OTcsMTQgKzI2OTcsNiBAQA0KIAkJCWJy
ZWFrOw0KIAkJfQ0KIAkJDQotCQljb2RlYy0+Y29kZWNfd3JpdGUoY29kZWMs
IEFDOTdfRVhURU5ERURfTU9ERU1fSUQsIDBMKTsNCi0JCWlmKGNvZGVjLT5j
b2RlY19yZWFkKGNvZGVjLCBBQzk3X0VYVEVOREVEX01PREVNX0lEKSkNCi0J
CXsNCi0JCQlwcmludGsoS0VSTl9XQVJOSU5HICJpODEwX2F1ZGlvOiBjb2Rl
YyAlZCBpcyBhIHNvZnRtb2RlbSAtIHNraXBwaW5nLlxuIiwgbnVtX2FjOTcp
Ow0KLQkJCWtmcmVlKGNvZGVjKTsNCi0JCQljb250aW51ZTsNCi0JCX0NCi0J
DQogCQljYXJkLT5hYzk3X2ZlYXR1cmVzID0gZWlkOw0KIAkJCQkNCiAJCS8q
IE5vdyBjaGVjayB0aGUgY29kZWMgZm9yIHVzZWZ1bCBmZWF0dXJlcyB0byBt
YWtlIHVwIGZvcg0K
---427549889-1644595638-1030810143=:24208--
