Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753333AbWKCQKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333AbWKCQKd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 11:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753336AbWKCQKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 11:10:33 -0500
Received: from h216-170-215-245.216-170.unk.tds.net ([216.170.215.245]:2792
	"EHLO cave.trolltruffles.com") by vger.kernel.org with ESMTP
	id S1753335AbWKCQKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 11:10:32 -0500
Date: Fri, 3 Nov 2006 10:30:12 -0600
From: Jonathan Lemon <jlemon@flugsvamp.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [take22 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061103163012.GA84707@cave.trolltruffles.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <local.mail.linux-kernel/20061103084240.GB1184@2ka.mipt.ru>,
Evgeniy Polyakov  <johnpol@2ka.mipt.ru> wrote:
>On Thu, Nov 02, 2006 at 11:40:43AM -0800, Nate Diller
>(nate.diller@gmail.com) wrote:
>> Are you saying that the *only* reason we choose not to be
>> source-compatible with BSD is the 32 bit userland on 64 bit arch
>> problem?  I've followed every thread that gmail 'kqueue' search
>
>I.e. do you want that generic event handling mechanism would not work on
>x86_64? I doubt you do.
>
>> returns, which thread are you referring to?  Nicholas Miell, in "The
>> Proposed Linux kevent API" thread, seems to think that there are no
>> advantages over kqueue to justify the incompatibility, an argument you
>> made no effort to refute.  I've also read the Kevent wiki at
>> linux-net.osdl.org, but it too is lacking in any direct comparisons
>> (even theoretical, let alone benchmarks) of the flexibility,
>> performance, etc. between the two.
>> 
>> I'm not arguing that you've done a bad design, I'm asking you to brag
>> about the things you improved on vs. kqueue.  Your emphasis on
>> unifying all the different event types into one interface is really
>> cool, fill me in on why that can't be effectively done with the kqueue
>> compatability and I also will advocate for kevent inclusion.
>
>kqueue just can not be used as is in Linux (_maybe_ *bsd has different
>types, not those which I found in /usr/include in my FC5 and Debian
>distro). It will not work on x86_64 for example. Some kind of a pointer
>or unsigned long in structures which are transferred between kernelspace
>and userspace is so much questionable, than it is much better even do
>not see there... (if I would not have so political correctness, I would
>describe it in a much different words actually).
>So, kqueue API and structures can not be usd in Linux.

Let me be a little blunt here: that is just so much bullshit.

Yes, I understand the problem that 32-bit userspace on a 64-bit kernel has.
Mea culpa - I didn't forsee this years ago, and none of my many reviewers
caught it either.  It was designed for 32/32 and 64/64, not 32/64.

However, this is trivially fixed by adding a union to the structure, as
pointed out earlier on this list.  Code would still be source compatible
with any kqueue apps, which is what counts.  Even NetBSD and FreeBSD have
differing definitions of the kq constants, and nobody notices.

I really have no stake in this matter, so if you want to go invent a 
better mousetrap, more power to you.  But don't claim that "kqueue can
not be used on Linux"; this just makes you look foolish - I have code
running on x86_64 that trivially disproves your statement.
-- 
Jonathan
