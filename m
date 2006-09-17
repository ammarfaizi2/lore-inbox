Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbWIQBO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWIQBO0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 21:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbWIQBO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 21:14:26 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59154 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964896AbWIQBOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 21:14:25 -0400
Date: Sun, 17 Sep 2006 03:13:52 +0200
From: Adrian Bunk <bunk@stusta.de>
To: rossb <rossb@google.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, mm-commits@vger.kernel.org, akpm@google.com,
       sam@ravnborg.org
Subject: Re: + allow-proc-configgz-to-be-built-as-a-module.patch added to -mm tree
Message-ID: <20060917011352.GM669@stusta.de>
References: <200609152158.k8FLw7ud018089@shell0.pdx.osdl.net> <20060915154752.d7bdb8a0.rdunlap@xenotime.net> <1158407250.5152.60.camel@laptopd505.fenrus.org> <d43160c70609161748n2af1c88cx33344e7da3e2b302@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d43160c70609161748n2af1c88cx33344e7da3e2b302@mail.google.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2006 at 08:48:26PM -0400, rossb wrote:
> On 9/16/06, Arjan van de Ven <arjan@infradead.org> wrote:
> >> > In some ways this is a bit risky, because the .config which is used for
> >> > compiling kernel/configs.c isn't necessarily the same as the .config 
> >which was
> >> > used to build vmlinux.
> >>
> >> and that's why a module wasn't allowed.
> >> It's not worth the risk IMO.
> 
> The problem is, the patch is basically s/bool/tristate/ so you can't
> really count on /proc/config.gz anyway.  It's a lot like security
> through obscurity.
> 
> >One hack we could do is make an md5sum or similar of the config and
> >stick that somewhere which is built in and always available (proc or
> >sysfs or something like that); that can be used to validate any config
> >basically to be "correct matching". In fact we could even make it
> >(optionally) part of the VERMAGIC to avoid any kind of mismatch at all.
> 
> Not a bad idea, but I think you want to be able to edit your config
> before compiling modules.  In particular, you might want to turn
> something from off to module.
> 
> How about we embed the md5sum of the config in the kernel, make it
> available via /proc or /sysfs and then have /proc/config.gz return an
> error in the event the md5sum doesn't match?

IMHO this all sounds like overdesigning something that is only a quick 
hack that is sometimes handy:

If you don't want to waste kernel memory, set CONFIG_IKCONFIG=n.

If you are building a kernel for a distribution kernel, set 
CONFIG_IKCONFIG=n and place the .config in /boot/config-*
(or a similar place).

We don't need a sophisticated well-defined semantics for the case when 
the .config changes due to additional modules selected or other special 
cases.

>    Ross

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

