Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288338AbSACWVM>; Thu, 3 Jan 2002 17:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288343AbSACWU5>; Thu, 3 Jan 2002 17:20:57 -0500
Received: from cj44686-b.reston1.va.home.com ([24.18.166.90]:14597 "EHLO
	cj44686-b.reston1.va.home.com") by vger.kernel.org with ESMTP
	id <S288336AbSACWUH>; Thu, 3 Jan 2002 17:20:07 -0500
Date: Thu, 3 Jan 2002 17:41:17 -0500
From: Tim Hollebeek <tim@hollebeek.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Richard Henderson <rth@redhat.com>, Tom Rini <trini@kernel.crashing.org>,
        jtv <jtv@xs4all.nl>, Momchil Velikov <velco@fadata.bg>,
        linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020103174117.A27739@cj44686-b.reston1.va.home.com>
Reply-To: tim@hollebeek.com
In-Reply-To: <20020102133632.C10362@redhat.com> <20020102220548.GL1803@cpe-24-221-152-185.az.sprintbbd.net> <20020102232320.A19933@xs4all.nl> <20020102231243.GO1803@cpe-24-221-152-185.az.sprintbbd.net> <20020103004514.B19933@xs4all.nl> <20020103000118.GR1803@cpe-24-221-152-185.az.sprintbbd.net> <20020102160739.A10659@redhat.com> <15411.49911.958835.299377@argo.ozlabs.ibm.com> <20020103003240.A10838@redhat.com> <15412.11822.811712.207946@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <15412.11822.811712.207946@argo.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Also, what does the standard say about casting pointers to integral
> types?  IIRC you aren't entitled to assume that a pointer will fit in
> any integral type, or anything about the bit patterns that you get.

Yes, but you're on much safer ground here, since the conversion is
implementation defined.  Practical considerations almost guarantee the
implementation choice will be "int == address" for targets where this
makes sense (e.g. has a simple, flat, contiguous address space).

Also, in the latest version of the C standard, you do have a int type
that can contain a pointer.

Allowing people to treat pointers as if they were "just" integers
prevents a whole slew of interesting and useful compiler
transformations, which is why the standard frowns upon such behavior.
Buffer overflow checks are an example.  It's possible to build bounded
pointer implementations for strict ANSI C, but impossible for the "all
pointers are just integers" variant.

Do the compiler a favor.  If you're playing with pointers as if they
are integers, make them integers.  Types are your friend.

-Tim
