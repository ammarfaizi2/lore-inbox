Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271767AbRHURzt>; Tue, 21 Aug 2001 13:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271768AbRHURzj>; Tue, 21 Aug 2001 13:55:39 -0400
Received: from ns.ithnet.com ([217.64.64.10]:40199 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S271767AbRHURz3>;
	Tue, 21 Aug 2001 13:55:29 -0400
Date: Tue, 21 Aug 2001 19:55:25 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: With Daniel Phillips Patch (was: aic7xxx with 2.4.9 on 7899P)
Message-Id: <20010821195525.05d0f8bf.skraw@ithnet.com>
In-Reply-To: <20010821172029Z16065-32384+285@humbolt.nl.linux.org>
In-Reply-To: <20010820230909.A28422@oisec.net>
	<20010821150202Z16034-32383+699@humbolt.nl.linux.org>
	<15234.37073.974320.621770@abasin.nj.nec.com>
	<20010821172029Z16065-32384+285@humbolt.nl.linux.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2001 19:26:58 +0200
Daniel Phillips <phillips@bonn-fries.net> wrote:

> On August 21, 2001 06:48 pm, Sven Heinicke wrote:
> > Yes, highmem was on, the stystem got 4G of memory.  I turned off
> > highmem and got no messages apart from one:
> > 
> > Aug 21 07:29:19 ps1 kernel: (scsi0:A:0:0): Locking max tag count at 64
> > 
> > which I was getting before.
> >
> > Disk access is faster then before but still slower then the IDE
> > drive.  Any ideas?
> 
> Two separate problems, I think.  I don't know anything about the aic7xxx 
> driver but I can take a look at the highmem problem.  First, can you try
> it with highmem enabled, on a recent -ac kernel, say 2.4.8-ac7.

Ok, Daniel, here are the results of the german jury :-) (EU insider joke)

Aug 21 19:46:40 admin kernel: __alloc_pages: 2-order allocation failed (gfp=0x20/0).
Aug 21 19:46:40 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 21 19:46:40 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 21 19:46:40 admin kernel: __alloc_pages: 2-order allocation failed (gfp=0x20/0).
Aug 21 19:46:40 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 21 19:46:40 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 21 19:46:40 admin kernel: __alloc_pages: 2-order allocation failed (gfp=0x20/0).
Aug 21 19:46:40 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 21 19:46:40 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 21 19:46:40 admin kernel: __alloc_pages: 2-order allocation failed (gfp=0x20/0).

And what may be of big interest for Justin: I am using the _old_ AIC7xxx driver. 

The problem can quite easily be produced on my side. All you need is a (problem) host with NFS-server running and a client system. Then simply copy a lot of big files to the server. If you now go and read CD on the server you are in big trouble:
cpu load is shot through the ceiling and you cannot even type chars in a shell after about 3 minutes. Remember I am sitting in front of a dual P-III 1GHz with 1 GB of RAM and U160 SCSI, I simply cannot believe this. I have never seen such a thing under 2.2.

Regards,
Stephan

PS: I try to disable HighMem next.
