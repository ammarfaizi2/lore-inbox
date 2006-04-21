Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWDUTWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWDUTWV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 15:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWDUTWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 15:22:21 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6156 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932206AbWDUTWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 15:22:20 -0400
Date: Fri, 21 Apr 2006 21:22:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Dmitry Fedorov <dm.fedorov@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: kfree(NULL)
Message-ID: <20060421192217.GI19754@stusta.de>
References: <200604210703.k3L73VZ6019794@dwalker1.mvista.com> <Pine.LNX.4.64.0604210322110.21429@d.namei> <20060421015412.49a554fa.akpm@osdl.org> <200604210656.40158.vernux@us.ibm.com> <7115951b0604210707q2113dd65tda67e24c07d6c0ad@mail.gmail.com> <Pine.LNX.4.61.0604211643350.31515@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0604211643350.31515@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 05:07:45PM +0200, Jan Engelhardt wrote:
> >> Maybe kfree should really be a wrapper around __kfree which does the real
> >> work.  Then kfree could be a inlined function or a #define that does the NULL
> >> pointer check.
> >
> >NULL pointer check in kfree saves lot of small code fragments in callers.
> >It is one of many reasons why kfree does it.
> >Making kfree inline wrapper eliminates this save.
> 
> How about
> 
> slab.h:
> #ifndef CONFIG_OPTIMIZING_FOR_SIZE
> static inline void kfree(const void *p) {
>     if(p != NULL)
>         __kfree(p);
> }
> #else
> extern void kfree(const void *);
> #endif
> 
> slab.c:
> #ifdef CONFIG_OPTIMIZING_FOR_SIZE
> void kfree(const void *p) {
>     if(p != NUILL)
>         _kfree(p);
> }
> #endif
> 
> That way, you get your time saving with -O2 and your space saving with -Os.


What makes you confident that the static inline version gives a time 
saving?


> Jan Engelhardt

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

