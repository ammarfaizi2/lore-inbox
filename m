Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbTEHWLL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 18:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbTEHWLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 18:11:11 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:21895 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262169AbTEHWLJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 18:11:09 -0400
Date: Fri, 9 May 2003 00:22:50 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Felix von Leitner <felix-kernel@fefe.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.69: VIA IDE still broken
In-Reply-To: <20030508220910.GA1070@codeblau.de>
Message-ID: <Pine.SOL.4.30.0305090020480.9466-200000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-1052432570=:9466"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-1052432570=:9466
Content-Type: TEXT/PLAIN; charset=US-ASCII


Apply patch.

On Fri, 9 May 2003, Felix von Leitner wrote:

> I can't believe this still isn't fixed!
>
>  hda: dma_timer_expiry: dma status == 0x24
>  hda: lost interrupt
>  hda: dma_intr: bad DMA status (dma_stat=30)
>  hda: dma_intr: status=0x50 { DriveReady SeekComplete }
>
>  hda: dma_timer_expiry: dma status == 0x24
>  hda: lost interrupt
>  hda: dma_intr: bad DMA status (dma_stat=30)
>  hda: dma_intr: status=0x50 { DriveReady SeekComplete }
>
> My hda is in perfect health and this does not happen on the same
> hardware with 2.4.* or 2.5.63.  I reported this before and got the
> answer that to fix this, recent changes in the IDE code would have to be
> reverted.  Apparently I was unreasonably hasty in assuming that that
> would be done now that the need to do it has been established.
>
> I would appreciate it if the fix would be integrated into 2.5.70.
>
> Amazing: the only hardware components in my machine that actually work
> as expected with recent Linux 2.5 kernels are the network cards, the RAM
> and the keyboard, and I had to replace a tulip card with an eepro100 for
> that.  Even the CPU appears to run too hot with Linux, causing the
> system to boot spontaneously under load, and because ACPI is terminally
> broken in Linux and has been every time I tried it, I can't do much
> about it.  Firewire does not like me (modprobe eth1394 -> oops), IDE
> loses interrupts (see above), my USB mouse stops working as soon as I
> plug in my USB hard disk (which works fine on my notebook and under
> Windows), using my IDE CD-R causes the machine to freeze while cdrecord
> does OTP, finalizing or eject.  The nvidia graphics card takes major
> patching to work at all with X, and all of these components are
> well-known brand components from tier 1 suppliers that were chosen for
> reliability and market penetration over price.  I envy people who can
> still evangelize Linux under circumstances like this.  I sure as hell
> can not.
>
> Felix

So what are you waiting for? Stop whining and start hacking now!
--
Bartlomiej

---559023410-851401618-1052432570=:9466
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ide_masked_irq.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SOL.4.30.0305090022500.9466@mion.elka.pw.edu.pl>
Content-Description: 
Content-Disposition: attachment; filename="ide_masked_irq.patch"

DQojIEZpeCBtYXNrZWRfaXJxIGFyZyBoYW5kbGluZyBmb3IgaWRlX2RvX3Jl
cXVlc3QoKS4NCiMgU29sdmVzICJoZHg6IGxvc3QgaW50ZXJydXB0IiBidWcu
DQojDQojIEJhcnRsb21pZWogWm9sbmllcmtpZXdpY3ogPGJ6b2xuaWVyQGVs
a2EucHcuZWR1LnBsPg0KDQogZHJpdmVycy9pZGUvaWRlLWlvLmMgfCAgICA0
ICsrLS0NCiAxIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCg0KZGlmZiAtcHVOIGRyaXZlcnMvaWRlL2lkZS1pby5j
fmlkZV9tYXNrZWRfaXJxIGRyaXZlcnMvaWRlL2lkZS1pby5jDQotLS0gbGlu
dXgtMi41LjY5L2RyaXZlcnMvaWRlL2lkZS1pby5jfmlkZV9tYXNrZWRfaXJx
CVRodSBNYXkgIDggMTc6MTY6MjcgMjAwMw0KKysrIGxpbnV4LTIuNS42OS1y
b290L2RyaXZlcnMvaWRlL2lkZS1pby5jCVRodSBNYXkgIDggMTc6MTY6Mjcg
MjAwMw0KQEAgLTg1MCwxNCArODUwLDE0IEBAIHF1ZXVlX25leHQ6DQogCQkg
KiBoYXBwZW5zIGFueXdheSB3aGVuIGFueSBpbnRlcnJ1cHQgY29tZXMgaW4s
IElERSBvciBvdGhlcndpc2UNCiAJCSAqICAtLSB0aGUga2VybmVsIG1hc2tz
IHRoZSBJUlEgd2hpbGUgaXQgaXMgYmVpbmcgaGFuZGxlZC4NCiAJCSAqLw0K
LQkJaWYgKGh3aWYtPmlycSAhPSBtYXNrZWRfaXJxKQ0KKwkJaWYgKG1hc2tl
ZF9pcnEgIT0gSURFX05PX0lSUSAmJiBod2lmLT5pcnEgIT0gbWFza2VkX2ly
cSkNCiAJCQlkaXNhYmxlX2lycV9ub3N5bmMoaHdpZi0+aXJxKTsNCiAJCXNw
aW5fdW5sb2NrKCZpZGVfbG9jayk7DQogCQlsb2NhbF9pcnFfZW5hYmxlKCk7
DQogCQkJLyogYWxsb3cgb3RoZXIgSVJRcyB3aGlsZSB3ZSBzdGFydCB0aGlz
IHJlcXVlc3QgKi8NCiAJCXN0YXJ0c3RvcCA9IHN0YXJ0X3JlcXVlc3QoZHJp
dmUsIHJxKTsNCiAJCXNwaW5fbG9ja19pcnEoJmlkZV9sb2NrKTsNCi0JCWlm
IChod2lmLT5pcnEgIT0gbWFza2VkX2lycSkNCisJCWlmIChtYXNrZWRfaXJx
ICE9IElERV9OT19JUlEgJiYgaHdpZi0+aXJxICE9IG1hc2tlZF9pcnEpDQog
CQkJZW5hYmxlX2lycShod2lmLT5pcnEpOw0KIAkJaWYgKHN0YXJ0c3RvcCA9
PSBpZGVfcmVsZWFzZWQpDQogCQkJZ290byBxdWV1ZV9uZXh0Ow0KDQpfDQo=
---559023410-851401618-1052432570=:9466--
