Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288077AbSACAfp>; Wed, 2 Jan 2002 19:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288038AbSACAe2>; Wed, 2 Jan 2002 19:34:28 -0500
Received: from mxzilla2.xs4all.nl ([194.109.6.50]:64005 "EHLO
	mxzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S288067AbSACAcn>; Wed, 2 Jan 2002 19:32:43 -0500
Date: Thu, 3 Jan 2002 01:32:40 +0100
From: jtv <jtv@xs4all.nl>
To: dewar@gnat.com
Cc: jbuck@synopsys.COM, gcc@gcc.gnu.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.linuxppc.org, paulus@samba.org,
        trini@kernel.crashing.org, velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020103013240.F19933@xs4all.nl>
In-Reply-To: <20020103001241.E37DFF2EC6@nile.gnat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020103001241.E37DFF2EC6@nile.gnat.com>; from dewar@gnat.com on Wed, Jan 02, 2002 at 07:12:41PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 07:12:41PM -0500, dewar@gnat.com wrote:
>
> Note incidentally that the C rules that allow referencing the address just
> past the end of an array (an irregularity that recognizes the infeasibility
> of declaring the common idiom for (a=b;a<&b[10];a++)) has an interesting
> consequence on a segmented machine, namely that you cannot allocate an
> array too near the end of the segment.

At the risk of going off topic, you can take the non-element's address but
you can't actually touch it.  So provided your architecture supports 
pointer arithmetic beyond the end of the segment, your only remaining
worries are (1) that you don't stumble into the NULL address (which need
not be zero), and (2) that the address isn't reused as a valid element of
something else.  I'm not so sure the latter is even a requirement.

Which does tie in to what we were discussing: in "foo"+LARGE_CONSTANT,
the problem is that C makes no promises on where "foo" ends up in memory,
or if it's even a single place, or what is located at any given offset
from it, or that the sum is even something that can be considered an 
address in any way.  Nor does the compiler need to assume that the 
programmer knows better--bar some compiler-specific support for this 
trick.


Jeroen

(Yes, I'm a pedant.  I'm pining for the day when gcc will support the
options "-ffascist -Wanal")

