Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288619AbSADMdO>; Fri, 4 Jan 2002 07:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288620AbSADMdE>; Fri, 4 Jan 2002 07:33:04 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:50831
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288619AbSADMc4>; Fri, 4 Jan 2002 07:32:56 -0500
Date: Fri, 4 Jan 2002 07:19:40 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Erik Andersen <andersen@codepoet.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: LSB1.1: /proc/cpuinfo
Message-ID: <20020104071940.A10172@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Erik Andersen <andersen@codepoet.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020103190219.B27938@thyrsus.com> <Pine.GSO.4.21.0201031944320.23693-100000@weyl.math.psu.edu> <20020103195207.A31252@thyrsus.com> <20020104081802.GC5587@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020104081802.GC5587@codepoet.org>; from andersen@codepoet.org on Fri, Jan 04, 2002 at 01:18:02AM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen <andersen@codepoet.org>:
> I once wrote up /dev/ps and /dev/mounts drivers to eliminate proc
> for embedded systems (pointer available if you care).  It was not
> warmly received, but I did form some opinions in the process.

Sure, I'd like to see this work.
 
> The main things to think about are
>     1) machine readability
> 	Generally speaking the kernel gods have decided that
> 	ASCII is good, binary structures and such are bad (think
> 	endiannes, nfs exports, and similar oddness).

I agree with this decision.  Binary structures would be false economy,
trading away readability and flexibility for a marginal speed gain.

>     2) typing
> 	Right now, if some /proc file prints a number, user space
> 	has to go digging about in the kernel sources to find
> 	what type that thing is -- int, uint, long, long long, etc.
> 	Cant tell without digging in the source.  And what if
> 	someone then changes the type next week -- userspace
> 	then overflows.

I'm not very worried about this.  On modern machines int == long 
and the only case that's a potential headache is long long.  If
longer than int-size data is labeled, we'll be OK.

>     3) field length
> 	When coping a string from /proc (say /proc/mounts),
> 	userspace has to go digging in the kernel source to
> 	find the field length.  So if I copy things into a
> 	static buffer, I may be fine.

I think the right answer to this is usually "don't use a language that
has static buffers". :-)

> So what is needed is a kernelfs virtual filesystem that provides
> kernel info to user space.

I don't care what it's called.  I've seen `sys', 'system', and 'archfs'
thrown around.
 
> It needs a format that provides information as an organized
> directory hierarchy, which each directory and filename
> identifying the nature of the provided information.  Files should
> provide information in ASCII with one value per file (to avoid
> all the tedious parsing), but also provides along with that bit
> of information type and or/length information.  
> 
> In some cases I guess we may also need more complex classes on
> information.  (lists of key-value stuff for example).

One value per *file*?  That seems excessively fine-grained.  Sometimes
you want multiple values per file because the information is a functional
unit for reporting to humans.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Americans have the will to resist because you have weapons. 
If you don't have a gun, freedom of speech has no power.
         -- Yoshimi Ishikawa, Japanese author, in the LA Times 15 Oct 1992
