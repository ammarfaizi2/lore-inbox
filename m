Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288075AbSACBNO>; Wed, 2 Jan 2002 20:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288097AbSACBNE>; Wed, 2 Jan 2002 20:13:04 -0500
Received: from dot.cygnus.com ([205.180.230.224]:16139 "HELO dot.cygnus.com")
	by vger.kernel.org with SMTP id <S288075AbSACBMt>;
	Wed, 2 Jan 2002 20:12:49 -0500
Date: Wed, 2 Jan 2002 17:12:24 -0800
From: Richard Henderson <rth@redhat.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: jtv <jtv@xs4all.nl>, Momchil Velikov <velco@fadata.bg>,
        linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020102171224.D10659@redhat.com>
Mail-Followup-To: Richard Henderson <rth@redhat.com>,
	Tom Rini <trini@kernel.crashing.org>, jtv <jtv@xs4all.nl>,
	Momchil Velikov <velco@fadata.bg>, linux-kernel@vger.kernel.org,
	gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org,
	Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
	Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Corey Minyard <minyard@acm.org>
In-Reply-To: <87g05py8qq.fsf@fadata.bg> <20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net> <20020102133632.C10362@redhat.com> <20020102220548.GL1803@cpe-24-221-152-185.az.sprintbbd.net> <20020102232320.A19933@xs4all.nl> <20020102231243.GO1803@cpe-24-221-152-185.az.sprintbbd.net> <20020103004514.B19933@xs4all.nl> <20020103000118.GR1803@cpe-24-221-152-185.az.sprintbbd.net> <20020102160739.A10659@redhat.com> <20020103001605.GS1803@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020103001605.GS1803@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Wed, Jan 02, 2002 at 05:16:05PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 05:16:05PM -0700, Tom Rini wrote:
> > Ignore strcpy.  Yes, that's what visibly causing a failure here,
> > but the bug is in the funny pointer arithmetic.  Leave that in
> > there and the compiler _will_ bite your ass sooner or later.
> 
> Er, which part of the 'funny pointer arithmetic'?

What's currently inside RELOC.

> We need to do funny things here, and thus need a way to tell gcc to just
> do what we're saying.

While it's true that you have requirements on doing runtime
relocation, what you absolutely do not want to do is expose
this to gcc.

Hide it inside inline assembly if you must.  Better is to 
do your relocation before you enter C at all.


r~
