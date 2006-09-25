Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWIYOil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWIYOil (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 10:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWIYOil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 10:38:41 -0400
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:57835 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932204AbWIYOik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 10:38:40 -0400
Date: Mon, 25 Sep 2006 10:38:38 -0400
To: Dominique Dumont <domi.dumont@free.fr>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       alsa-user <alsa-user@lists.sourceforge.net>
Subject: Re: Pb with simultaneous SATA and ALSA I/O
Message-ID: <20060925143838.GQ13641@csclub.uwaterloo.ca>
References: <877izsp3dm.fsf@gandalf.hd.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877izsp3dm.fsf@gandalf.hd.free.fr>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2006 at 01:55:17PM +0200, Dominique Dumont wrote:
> I have some problem using the SPDIF output of my SB Live card while
> performing I/O on my SATA drive. (See [1] for the whole story on the
> ALSA mailing list)
> 
> My Yamaha amplifier does not recognize the AC3 (Dolby digital) stream
> from the sdpif plug while performing I/O on my SATA drive.
> 
> If I have a lot of I/O (e.g. running md5sum on a 4Gb file), the AC3
> stream is completely broken.
> 
> If I have some I/O (e.g. reading a Hi-def movie), I get some AC3
> drop-out even if the CPU is about 50%.
> 
> I have the same result with DTS output.
> 
> With PCM output, I've noticed a hi-frequency distortion, which means
> that the interaction between SATA and snd module occurs several
> thousands time per second.
> 
> My set up is:
> - Debian Linux kernel 2.6.17
> - Sound blaster SB Live 5.1 (snd_emu10k1 module)
> - SATA drive (sata_sil and libata module)
> - A7n8x deluxe mobo
> - AMD XP 3200 
> 
> So far I verified that:
> - AC3 output works fine when SATA drive is left alone
> - AC3 output works fine when running md5sum on a PATA drive
> - DTS output works fine on the mobo SPDIF output (snd_intel8x0 module)
>   even when running md5sum on the SATA drive. (cannot try AC3 stream
>   because of Soundstorm chip :-( )
> - Preemp kernel option does not fix the problem
> - when running md5sum on SATA drive, alsa driver report a starvation
>   (xrun) every few seconds, not thousands of time per second.
> 
> Could someone shed some light on this problem ?
> 
> What can I do to help debug this problem ?

Well i agree with the suggestion of trying a different PCI slot for the
sb live.  There is so much onboard stuff sharing interrupts on those
boards that you might have problems because of that.  Creative cards are
not very good at dealing with anything other than ideal conditions from
what I have gathered over the years.  The manual for the board will tell
you which IRQ goes to which slot, and I guess you want to avoid using a
slot that shares with the SATA controller.

--
Len Sorensen
