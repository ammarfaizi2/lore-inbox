Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261679AbSJQMd3>; Thu, 17 Oct 2002 08:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261681AbSJQMd3>; Thu, 17 Oct 2002 08:33:29 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:59384 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S261679AbSJQMd0>; Thu, 17 Oct 2002 08:33:26 -0400
Date: Thu, 17 Oct 2002 05:30:14 -0700
From: Chris Wright <chris@wirex.com>
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] 2.5.42: remove capable(CAP_SYS_RAWIO) check from open_kmem
Message-ID: <20021017053014.C26442@figure1.int.wirex.com>
Mail-Followup-To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <87smza1p7f.fsf@goat.bogus.local> <87bs5tba9j.fsf@goat.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <87bs5tba9j.fsf@goat.bogus.local>; from olaf.dietsche#list.linux-kernel@t-online.de on Thu, Oct 17, 2002 at 01:00:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Olaf Dietsche (olaf.dietsche#list.linux-kernel@t-online.de) wrote:
> Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de> writes:
> 
> > In drivers/char/mem.c there's open_port(), which is used as open_mem()
> > and open_kmem() as well. I don't see the benefit of this, since
> > /dev/mem and /dev/kmem are already protected by filesystem
> > permissions.
> >
> > mem.c, line 526:
> > static int open_port(struct inode * inode, struct file * filp)
> > {
> > 	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
> > }
> >
> > If anyone knows, why this is done this way, please let me
> > know. Otherwise, I suggest the patch below.
> 
> I haven't got a convincing answer against this patch, so far. The
> patch applies to 2.5.43 as well.
> Linus, please apply.

No way.  This is clearly a bad idea.  CAP_SYS_RAWIO should be treated very
seriously, look at what it enables.  CAP_DAC_OVERRIDE is substantially
less powerful, and if you remove this check, it would be the only
capability protecting this.

-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
