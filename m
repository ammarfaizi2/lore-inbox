Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWBSLSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWBSLSG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 06:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWBSLSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 06:18:06 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:24799 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932397AbWBSLSF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 06:18:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eJ6nVBN4yguG+UpUJej2WoKsiCIRXin7enQAM+JG1omqxwt8N6I4pFL1ugh7WSB+HDpPwtEW39W31E/nizMhkmMiNutaPMmcxhu4GvnnV1ZimzbfLq4ymy2Da2+J5+eOL3dyg0vYAF1pjZq8XcJ6Bp6++XVsCzo9zQ/g+erHY5o=
Message-ID: <7c3341450602190318o1c60e9b5w@mail.gmail.com>
Date: Sun, 19 Feb 2006 11:18:04 +0000
From: "Nick Warne" <nick@linicks.net>
Reply-To: "Nick Warne" <nick@linicks.net>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Subject: Re: No sound from SB live!
Cc: "Pavel Machek" <pavel@suse.cz>, tiwai@suse.de, ghrt@dial.kappa.ro,
       perex@suse.cz, "kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <9a8748490602190304w43c32ae6m5b610f2ec9ad46f2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060218231419.GA3219@elf.ucw.cz>
	 <9a8748490602190304w43c32ae6m5b610f2ec9ad46f2@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is definately something going on with these cards.

Ref. my LKML thread here:

http://lkml.org/lkml/2006/2/11/25

My card as reported in dmesg:

PCI: Found IRQ 12 for device 0000:00:0f.0
ALSA device list:
  #0: SBLive 5.1 [SB0060] (rev.7, serial:0x80611102) at 0xe000, irq 12

lspci:

00:0f.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
00:0f.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)

Now, I built and installed latest:

alsa-utils-1.0.11rc2
alsa-lib-1.0.11rc3

and _that_ appeared to fix my problem.  But I just rebooted, and prior
to reboot as root I issued alsactl restore ~ no problems.

Following reboot, I now get (different control error) this:

alsactl: set_control:888: warning: iface mismatch (3/2) for control #80
alsactl: set_control:890: warning: device mismatch (0/0) for control #80
alsactl: set_control:892: warning: subdevice mismatch (0/0) for control #80
alsactl: set_control:894: warning: name mismatch (EMU10K1 PCM Send
Routing/External Amplifier) for control #80
alsactl: set_control:896: warning: index mismatch (0/0) for control #80
alsactl: set_control:898: failed to obtain info for control #80
(Identifier removed)


And now the confusing bit.  If I run alsamixer but DO NOT DO ANYTHING,
exit, then issue 'alsactl store', then 'alsactl restore' works again
OK - until next reboot...

??

Nick
