Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287181AbSABXOE>; Wed, 2 Jan 2002 18:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287173AbSABXNy>; Wed, 2 Jan 2002 18:13:54 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:8068 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S287972AbSABXNl>; Wed, 2 Jan 2002 18:13:41 -0500
Date: Wed, 2 Jan 2002 16:12:43 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: jtv <jtv@xs4all.nl>
Cc: Richard Henderson <rth@redhat.com>, Momchil Velikov <velco@fadata.bg>,
        linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020102231243.GO1803@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <87g05py8qq.fsf@fadata.bg> <20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net> <20020102133632.C10362@redhat.com> <20020102220548.GL1803@cpe-24-221-152-185.az.sprintbbd.net> <20020102232320.A19933@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020102232320.A19933@xs4all.nl>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 11:23:21PM +0100, jtv wrote:
> On Wed, Jan 02, 2002 at 03:05:48PM -0700, Tom Rini wrote:
> > 
> > Well, the problem is that we aren't running where the compiler thinks we
> > are yet.  So what would the right fix be for this?
> 
> Obviously -ffreestanding isn't, because this problem could crop up pretty
> much anywhere.  The involvement of standard library functions is almost
> coincidence and so -ffreestanding would only fix the current symptom.

After thinking about this a bit more, why wouldn't this be the fix?  The
problem is that gcc is assuming that this is a 'normal' program (or in
this case, part of a program) and that it, and that the standard rules
apply, so it optimizes the strcpy into a memcpy.  But in this small bit
of the kernel, it's not.  It's not even using the 'standard library
functions', but what the kernel provides.  This problem can only crop up
in the time before we finish moving ourself around.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
