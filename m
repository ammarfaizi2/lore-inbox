Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289876AbSBFAOv>; Tue, 5 Feb 2002 19:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289877AbSBFAOd>; Tue, 5 Feb 2002 19:14:33 -0500
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:31191 "EHLO
	snipe.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S289876AbSBFAO2>; Tue, 5 Feb 2002 19:14:28 -0500
Message-ID: <3C607558.9090409@attglobal.net>
Date: Tue, 05 Feb 2002 17:14:16 -0700
From: "Ian S. Nelson" <nelcomp@attglobal.net>
Reply-To: nelcomp@attglobal.net
Organization: Nelson Computing LLC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
In-Reply-To: <UTC200202052356.g15Nu1w00794.aeb@apps.cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:

>    > I would be surprised if there is anyone on this list
>    > who has not lost at some point either the .config, the
>    > ksyms, or something similar associated with at least
>    > one build they've made.
>
>    Sure.  And people have lost their root filesystems due to "rm -rf /".
>    That doesn't mean we build the entire (real) root filesystem into
>    the kernel.
>
>	-hpa
>
>Peter, in my eyes this is an unreasonable answer.
>
>For debugging and other purposes it is good to have some
>information. One may wish to know about a certain kernel image
>what Linux kernel version that was, with what patches, compiled
>with what options, by which compiler. Or one may want to know
>such things about the currently running kernel. Even user-space
>programs (like mount) may want to know (what NFS version? do we
>have CONFIG_JOLIET?).
>
>Today we supply a little of this information.
>For example, /proc/version supplies information on version
>and compiler and date. Why? One might as well keep this compiler
>info in a separate file. What a waste of unswappable kernel memory!
>
>You see - this is not a matter of absolutes.
>In the good old days, when an operating system had to fit in 4k
>and a device driver in 128 words, putting a 100-char text like
>the one found in /proc/version into the system would be ridiculous.
>Today nobody worries about a hundred bytes paid for some useful info.
>
>So, the question is: how useful is the information, and how expensive
>is it to store it. Consider the config options. How much space do they
>take? Typically 1-5 kB (compressed). If this is stored at the end of
>a kernel image file, and not loaded into memory, then the kernel memory
>cost is zero. If this is made part of the kernel itself, say accessible
>via /proc, then the cost is 1-5 kB.
>
>So, you should ponder whether it is worthwhile to pay this cost of zero,
>and ponder whether it is worthwhile to pay this cost of 5 kB.
>

I think it's insanely useful at times.  Especially if you're doing 
something like building an embedded box where you're building some of 
your own drivers and making some kernel mods.  And you've got a team of 
5 or more people.  

I've written a simple hack that puts .config in the proc filesystem. 
 I'll send it if you want.  It bzip2 the .config file and then you can 
bzcat /proc/kernconfig to see what your kernel was made with.  It's not 
a good general purpose solution but it worked for what I was doing.

Ian

-- 
Ian S. Nelson <nelcomp@attglobal.net>        303-666-0315
Nelson Computing of Boulder Colorado
Networking/Contracting/Custom Software/Linux Fast and Personal service



