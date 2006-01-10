Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030274AbWAJWnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbWAJWnK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 17:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbWAJWnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 17:43:09 -0500
Received: from smtpq3.groni1.gr.home.nl ([213.51.130.202]:20137 "EHLO
	smtpq3.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S1030259AbWAJWmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 17:42:39 -0500
Message-ID: <43C4388B.4060905@keyaccess.nl>
Date: Tue, 10 Jan 2006 23:43:23 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Sebastian <sebastian_ml@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: Digital Audio Extraction with ATAPI drives far from perfect
References: <20060107115449.GB20748@section_eight.mops.rwth-aachen.de> <20060107115947.GY3389@suse.de> <20060107140843.GA23699@section_eight.mops.rwth-aachen.de> <20060107142201.GC3389@suse.de> <20060107160622.GA25918@section_eight.mops.rwth-aachen.de> <43BFFE08.70808@wasp.net.au> <20060107180211.GA12209@section_eight.mops.rwth-aachen.de> <43C00C32.9050002@wasp.net.au> <20060109093025.GO3389@suse.de> <20060109094923.GA8373@section_eight.mops.rwth-aachen.de> <20060109100322.GP3389@suse.de>
In-Reply-To: <20060109100322.GP3389@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> Well it's actually a good thing, because then at least it's not a bug
> with the multi-frame extraction. So my guess would still be at the
> error correction possibilities that the application has, in which
> case CDROMREADAUDIO is just an inferior interface for this sort of
> thing. It also doesn't give the issuer a chance to look at potential
> error reasons, since the extended status isn't available.

For what it's worth; when allowing only flawless rips with cdparanoia 
(*) standard cdparanoia 9.8 and the SG_IO patched version of the same 
give me the exact same rips always, on my ATAPI Plextor "PlexWriter 
Premium", a drive that's specifically good at CDDA.

One thing that _is_ different is that the SG_IO version very frequently 
(soft) locks up the machine, with:

===
hdc: DMA timeout retry
hdc: timeout waiting for DMA
hdc: status error: status=0x7f { DriveReady DeviceFault SeekComplete 
DataRequest CorrectedError Index Error }
hdc: status error: error=0x7f { IllegalLengthIndication EndOfMedia 
AbortedCommand MediaChangeRequested LastFailedSense=0x07 }
ide: failed opcode was: unknown
hdc: drive not ready for command
hdc: ATAPI reset complete
hdc: irq timeout: status=0x80 { Busy }
ide: failed opcode was: unknown
hdc: ATAPI reset complete
hdc: irq timeout: status=0x80 { Busy }
ide: failed opcode was: unknown
hdc: status timeout: status=0x80 { Busy }
ide: failed opcode was: unknown
hdc: drive not ready for command
hdc: status timeout: status=0x80 { Busy }
ide: failed opcode was: unknown
hdc: DMA disabled
hdc: drive not ready for command
hdc: ATAPI reset complete
hdc: irq timeout: status=0x80 { Busy }
ide: failed opcode was: unknown
hdc: ATAPI reset complete
hdc: irq timeout: status=0x80 { Busy }
ide: failed opcode was: unknown
hdc: status timeout: status=0x80 { Busy }
ide: failed opcode was: unknown
hdc: drive not ready for command
BUG: soft lockup detected on CPU#0!

Pid: 0, comm:              swapper
EIP: 0060:[<c01d111f>] CPU: 0
EIP is at ide_inb+0x3/0x7
  EFLAGS: 00000206    Not tainted  (2.6.15-local-wc)
EAX: 00000180 EBX: c0329184 ECX: 2cb065ff EDX: 00000177
ESI: 00000282 EDI: 001403db EBP: c03290f0 DS: 007b ES: 007b
CR0: 8005003b CR2: b7c5d004 CR3: 1fd1f000 CR4: 000006d0
  [<c01d16ca>] ide_wait_stat+0xa0/0xfd
  [<c01d07cb>] start_request+0x10c/0x1a7
  [<c01d0b42>] ide_do_request+0x2bb/0x2f9
  [<c01d00c5>] ide_atapi_error+0x53/0x78
  [<c01da977>] cdrom_newpc_intr+0x0/0x2fd
  [<c01d0dfd>] ide_timer_expiry+0x195/0x1bf
  [<c0118ebe>] run_timer_softirq+0x140/0x181
  [<c01d0c68>] ide_timer_expiry+0x0/0x1bf
  [<c0115b01>] __do_softirq+0x35/0x7d
  [<c0103c54>] do_softirq+0x38/0x3f
  =======================
  [<c0115bda>] irq_exit+0x29/0x34
  [<c0103b84>] do_IRQ+0x46/0x4e
  [<c01026ce>] common_interrupt+0x1a/0x20
  [<c0100a73>] default_idle+0x2b/0x53
  [<c0100af0>] cpu_idle+0x41/0x63
  [<c02ea621>] start_kernel+0x13d/0x13f
hdc: status timeout: status=0x80 { Busy }
ide: failed opcode was: unknown
hdc: drive not ready for command
hdc: status timeout: status=0x80 { Busy }
ide: failed opcode was: unknown
===

Ad infitum. Needless to say, I switched back to regular (unpatched from 
upstream) cdparanoia which doesn't show this problem. The patching I did 
was from this message earlier in this thread:

http://marc.theaimsgroup.com/?l=linux-kernel&m=113665002702563&w=2

First I tried with only the .sgio and .labels patches from that src.rpm 
applied, saw the problem, then retried with all of redhat's patches 
applied (just in case) but did not see an improvement.

As said, when things do work, the rips are exactly the same as the rips 
made with the standard cdparanoia.

(*) by "allowing only flawless rips" I mean using "cdparanoia -v -z -B" 
and only ever allowing spaces in the progressbar cdparanoia leaves 
behind as it goes along. When anything else (-, +, !, ...) appears, I 
re-rip the entire track, or the bit in which the error occured, until I 
have a "spaces only" copy. Two of such rips are always the same while on 
the other hand a non-spaces-only rip generally differs from any other 
rip made of that same track.

Rene.

