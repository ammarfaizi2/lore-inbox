Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289000AbSAFSdO>; Sun, 6 Jan 2002 13:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289001AbSAFSdE>; Sun, 6 Jan 2002 13:33:04 -0500
Received: from vega.digitel2002.hu ([213.163.0.181]:49109 "EHLO
	vega.digitel2002.hu") by vger.kernel.org with ESMTP
	id <S289000AbSAFSc6>; Sun, 6 Jan 2002 13:32:58 -0500
Date: Sun, 6 Jan 2002 19:32:46 +0100
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: Marcin Tustin <mt500@ecs.soton.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Whizzy New Feature: Paged segmented memory
Message-ID: <20020106183246.GA593@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
In-Reply-To: <Pine.LNX.4.33.0201061408540.7398-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201061408540.7398-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
X-Operating-System: vega Linux 2.4.17 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2002 at 02:14:30PM +0000, Marcin Tustin wrote:
> 	Any comments on how useful it would be to have paged, segmented,
> memory support for Pentium? I was thinking that by having separate
> segments for text, stack, and heap, buffer overrun exploits would be
> eliminated (I'm aware that this would require GCC patching as well).
> 	Obviously, I'm thinking that I (and any similar fools I could rope
> in) would try this (Probably delivering for a kernel at least a year out
> of date by the time we had a patch).

It would break everything. Nowdays, Linux (and most OSes afaik) uses a
'flat' memory modell, well at least from the point of view of a process.
This will cause that you can address any part of process memory with a
single offset (it's another question that paging may deny some access). If
you create costum separated segments (with the right limit) for stack, code
and data, you won't address the address space of the process with a single
offset. You will also need segment registers to choose the right selector
which points to the descriptor table. Imho this would break almost anything.

And more: buffer overrun exploits WON'T BE eliminated entirely: let's
inmagine, that you have a char p[40]. If you don't check the data size eg
read to that place it will overwrite memory areas after p. Well, writing a
buffer overrun exploit may be harder but it would not be impossible. By the
way, non-executable stack kernel patches (like Solar Designer's one) made
the stack non-executable too, but that is not a whole solution as well, of
course (and see the problems of that kind of patches, eg gcc trampolines -
or whatever, I can't remember - and so on).

- Gabor
