Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751695AbWD0Vh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbWD0Vh5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 17:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbWD0Vh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 17:37:57 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:9224 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751694AbWD0Vh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 17:37:56 -0400
Date: Thu, 27 Apr 2006 23:37:54 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Woodhouse <dwmw2@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Simple header cleanups
Message-ID: <20060427213754.GU3570@stusta.de>
References: <1146104023.2885.15.camel@hades.cambridge.redhat.com> <Pine.LNX.4.64.0604261917270.3701@g5.osdl.org> <1146105458.2885.37.camel@hades.cambridge.redhat.com> <Pine.LNX.4.64.0604261954480.3701@g5.osdl.org> <1146107871.2885.60.camel@hades.cambridge.redhat.com> <Pine.LNX.4.64.0604262028130.3701@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604262028130.3701@g5.osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 08:31:00PM -0700, Linus Torvalds wrote:
> 
> On Thu, 27 Apr 2006, David Woodhouse wrote:
> > 
> > Agreed. And distributions and library maintainers _will_ fix them. Are
> > we to deny those people the tools which will help them to keep track of
> > our breakage and submit patches to fix it?
> 
> No. As mentioned, as long as the target audience is distributions and 
> library maintainers, I definitely think we should do help them as much as 
> possible. Our problems have historically been "random people" who have 
> /usr/include/linux being the symlink to "kernel source of the day", which 
> is an unsupportable situation.
>...


A definition of the kernel <-> userspace ABI is required.

Currently, each distribution does it slightly different.

Currently we might accidentially touch the userspace ABI of the kernel 
without even noticing it.


I'd like to do the following:

Create an include/kabi/linux/ with the following properties:
- the goal is that include/kabi/linux an be copied verbatim to
  /usr/include/ (by distributions and library maintainers, normal users
  should use the copy installed by their distribution in /usr/include/)
- kernel code outside include/ wouldn't notice, since for each ABI 
  header include/kabi/linux/foo.h there's a header include/linux/foo.h 
  that does #include <kabi/linux/foo.h>
- moving stuff to kabi/linux can happen incrementially
- once the move is complete, we can announce this as the official ABI 
  headers
- moving to the kabi/ headers shouldn't cause compile time or
  runtime breakages for userspace software [1]


I'd be willing to work on this, but if you have any problems with this 
approach, I'd like to understand them


> 		Linus


cu
Adrian

[1] with the exception of header abuses like the MySQL asm/atomic.h usage

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

