Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129529AbQKWA6b>; Wed, 22 Nov 2000 19:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129586AbQKWA6V>; Wed, 22 Nov 2000 19:58:21 -0500
Received: from Cantor.suse.de ([194.112.123.193]:63241 "HELO Cantor.suse.de")
        by vger.kernel.org with SMTP id <S129529AbQKWA6M>;
        Wed, 22 Nov 2000 19:58:12 -0500
Date: Thu, 23 Nov 2000 01:28:10 +0100
From: Andi Kleen <ak@suse.de>
To: Kurt Garloff <garloff@suse.de>, Andi Kleen <ak@suse.de>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Speed up interrupt entry
Message-ID: <20001123012810.A1040@gruyere.muc.suse.de>
In-Reply-To: <20001118112009.A23763@gruyere.muc.suse.de> <20001122232415.A30911@garloff.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001122232415.A30911@garloff.etpnet.phys.tue.nl>; from garloff@suse.de on Wed, Nov 22, 2000 at 11:24:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2000 at 11:24:16PM +0100, Kurt Garloff wrote:
> On Sat, Nov 18, 2000 at 11:20:09AM +0100, Andi Kleen wrote:
> > Index: include/asm-i386/hw_irq.h
> > ===================================================================
> > RCS file: /cvs/linux/include/asm-i386/hw_irq.h,v
> > retrieving revision 1.11
> > diff -u -u -r1.11 hw_irq.h
> > --- include/asm-i386/hw_irq.h	2000/05/16 16:08:15	1.11
> > +++ include/asm-i386/hw_irq.h	2000/11/18 10:33:48
> > @@ -103,9 +107,12 @@
> >  	"pushl %edx\n\t" \
> >  	"pushl %ecx\n\t" \
> >  	"pushl %ebx\n\t" \
> > -	"movl $" STR(__KERNEL_DS) ",%edx\n\t" \
>                                  ^^^
> > -	"movl %edx,%ds\n\t" \
> > -	"movl %edx,%es\n\t"
> > +	"movl $" STR(__KERNEL_DS),%eax\n\t" \
>                                  ^
> 
> You missed a ' "'

It contained a wrong hunk that was not supposed to be included.

> Apart from that it
> (a) makes sense
> (b) survived real world usage ...

Please back it out, the patch has some strange problems. I'm working
on a better one.



-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
