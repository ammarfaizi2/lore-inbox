Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267826AbTBVG5F>; Sat, 22 Feb 2003 01:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267827AbTBVG5F>; Sat, 22 Feb 2003 01:57:05 -0500
Received: from packet.digeo.com ([12.110.80.53]:15242 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267826AbTBVG5E>;
	Sat, 22 Feb 2003 01:57:04 -0500
Date: Fri, 21 Feb 2003 23:07:16 -0800
From: Andrew Morton <akpm@digeo.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [ak@suse.de: Re: iosched: impact of streaming read on
 read-many-files]
Message-Id: <20030221230716.630934cf.akpm@digeo.com>
In-Reply-To: <20030222054307.GA22074@wotan.suse.de>
References: <20030222054307.GA22074@wotan.suse.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Feb 2003 07:07:06.0819 (UTC) FILETIME=[026C8130:01C2DA41]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> ..
> > 
> > The correct way to design such an application is to use an RT thread to
> > perform the display/audio device I/O and a non-RT thread to perform the disk
> > I/O.  The disk IO thread keeps the shared 8 megabyte buffer full.  The RT
> > thread mlocks that buffer.
> 
> This requires making xmms suid root. Do you really want to do that?
> 
> Also who takes care about all the security holes that would cause?
> 
> If you require applications doing such things to work around VM/scheduler
> breakage

It is utterly unreasonable to characterise this as "breakage". 

No, we do not really need to implement RLIM_MEMLOCK for such applications.
They can leave their memory unlocked for any reasonable loads.

Yes, we _do_ need to give these applications at least elevated scheduling
priority, if not policy, so they get the CPU in a reasonable period of
time.

> But both is quite a bit of work, especially the later and may impact
> other loads. Fixing the IO scheduler for them is probably easier.
> 

You have not defined "fix".  An IO scheduler which attempts to serve every
request within ten milliseconds is an impossibility.  Attempting to 
achieve it will result in something which seeks all over the place.

The best solution is to implement five or ten seconds worth of buffering
in the application and for the kernel to implement a high throughput general
purpose I/O scheduler which does not suffer from starvation.

