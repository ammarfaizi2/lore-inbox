Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280683AbRKNQiy>; Wed, 14 Nov 2001 11:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280690AbRKNQio>; Wed, 14 Nov 2001 11:38:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64261 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280683AbRKNQib> convert rfc822-to-8bit; Wed, 14 Nov 2001 11:38:31 -0500
Date: Wed, 14 Nov 2001 08:34:12 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Sebastian =?iso-8859-1?q?Dr=F6ge?= <sebastian.droege@gmx.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [VM] 2.4.14/15-pre4 too "swap-happy"?
In-Reply-To: <200111141243.fAEChS915731@neosilicon.transmeta.com>
Message-ID: <Pine.LNX.4.33.0111140821120.17217-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id IAA10584
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 Nov 2001, Sebastian Dröge wrote:
>
> The system has 256 MB RAM, nothing RAM-eating in the background I got many
> buffer-underuns just because of swapping. When I turn swap off everything
> works fine. I think it's something with the cache.

Can you do some statistics for me:

   cat /proc/meminfo
   cat /proc/slabinfo
   vmstat 1

while the worst swapping is going on..

> Leaving system 2 alone, just play mp3s over nfs:
>
> After two or three days the used swap-space is around 3 MB. I just played
> MP3s and no X and no other "big" applications were running. This isn't really
> a problem but it doesn't look good. Just because of cache swap gets full :(

That's normal and usually good. It's supposed to swap stuff out if it
really isn't needed, and that improves performance. Cache _is_ more
important than swap if the cache is active.

HOWEVER, there's probably something in your system that triggers this too
easily. Heavy NFS usage will do that, for example - as mentioned in
another thread on linux-kernel, the VM doesn't really understand
writebacks and asynchronous reads from filesystems that don't use buffers,
and so sometimes the heuristics get confused simply because NFS activity
can _look_ like page mapping to the VM.

Your MP3-over-NFS doesn't sound bad, though. 3MB of swap is perfectly
normal: that tends to be just the idle deamons etc which really _should_
go to swapspace.

The cdrecord thing is something else, though. I'd love to see the
statistics from that. Although it can, of course, just be another SCSI
allocation strangeness.

		Linus

