Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288097AbSACBRe>; Wed, 2 Jan 2002 20:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288101AbSACBRY>; Wed, 2 Jan 2002 20:17:24 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:32133
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S288097AbSACBRL>; Wed, 2 Jan 2002 20:17:11 -0500
Date: Wed, 2 Jan 2002 18:17:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: jtv <jtv@xs4all.nl>
Cc: Momchil Velikov <velco@fadata.bg>, paulus@samba.org,
        linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020103011709.GV1803@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <87g05py8qq.fsf@fadata.bg> <20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net> <15411.37817.753683.914033@argo.ozlabs.ibm.com> <877kr0uyc5.fsf@fadata.bg> <20020102233452.GQ1803@cpe-24-221-152-185.az.sprintbbd.net> <20020103011905.D19933@xs4all.nl> <20020103002935.GT1803@cpe-24-221-152-185.az.sprintbbd.net> <20020103020358.G19933@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020103020358.G19933@xs4all.nl>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2002 at 02:03:58AM +0100, jtv wrote:
> On Wed, Jan 02, 2002 at 05:29:35PM -0700, Tom Rini wrote:
>
> > > As far as I'm concerned the options are: fix RELOC;
> > 
> > How?
> 
> That's the EUR 64 * 10^6 question, isn't it?  It's likely to cost some
> performance, but I suspect this would be the easiest solution.

I'm partial to Paul's' suggestion of redoing RELOC and friends in asm.

> > > obviate RELOC; use
> > > an appropriate gcc option if available (-fPIC might be it, -ffreestanding
> > > certainly isn't--see above);
> > 
> > Maybe for 2.5.  Too invasive for 2.4.x (initially at least).
>  
> I'm not saying these are attractive or even feasible, just prioritizing
> the options I see.  I'm sure I'll have forgotten some, but I'm convinced
> -ffreestanding isn't among them.

Well, Franz Sirl mentioned this before as a possible (or rather, why
aren't we doing it like this?), so maybe later someone will look into
this.

> Let's say RELOC also broke in other places, for the exact same reason but
> without (names familiar from) the standard library come into play.  How
> would one recognize those cases?  And once diagnosed, how to go about
> working around them?  Even worse, what if gcc tries to help but still
> uses the stricter assumptions in some forgotten case?

Well,  RELOC _always_ is doing funny arithmetic, and there's not much we
can do about it.  At this point in the bootup we aren't running where
things think we are yet, and have to adjust things as such.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
