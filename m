Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268035AbUIAXN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268035AbUIAXN5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267556AbUIAXJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 19:09:11 -0400
Received: from users.linvision.com ([62.58.92.114]:29917 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S267507AbUIAXEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 19:04:50 -0400
Date: Thu, 2 Sep 2004 01:04:47 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Driver retries disk errors.
Message-ID: <20040901230447.GB28809@bitwizard.nl>
References: <fa.d48te6f.1ol6tbb@ifi.uio.no> <fa.eti1vu1.2nqlj5@ifi.uio.no> <002e01c48eef$e3e2dc40$6601a8c0@northbrook>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002e01c48eef$e3e2dc40$6601a8c0@northbrook>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 06:17:24PM -0600, Robert Hancock wrote:
> Quite likely, in that case the drive has exhausted its spare pool, and 
> there are a bunch of bad sectors that have already been reallocated. Some 
> drives will reallocate sectors if they are still readable but the sector 
> appears to be marginal.

I agree that this is the theory. In practise however, I've never
seen it work correctly. We've seen several disks with say 1-5 bad
blocks and nothing else, and "dd if=/dev/zero of=/dev/<disk>" doesn't
seem to cure them.

I know how to check SMART, and I can see that some of these disks
have NEVER reallocated a block. Stuff like that. 

	Roger. 


> ----- Original Message ----- 
> From: "Rogier Wolff" <R.E.Wolff@harddisk-recovery.nl>
> Newsgroups: fa.linux.kernel
> To: "Theodore Ts'o" <tytso@mit.edu>; <linux-kernel@vger.kernel.org>; 
> <linux-ide@vger.kernel.org>
> Sent: Monday, August 30, 2004 4:19 PM
> Subject: Re: Driver retries disk errors.
> 
> 
> >On Mon, Aug 30, 2004 at 01:46:32PM -0400, Theodore Ts'o wrote:
> >>> a filesystem: if we recover one block this way, the next block will be
> >>> errorred and the filesystem "crashes" anyway. In fact this behaviour
> >>> may masquerade the first warnings that something is going wrong....
> >>
> >>If the block gets successfully read after 2 or 3 tries, it might be a
> >>good idea for the kernel to automatically do a forced rewrite of the
> >>block, which should cause the disk to do its own disk block
> >>sparing/reassignment.
> >
> >Hi Ted,
> >
> >I agree that this is the theory. In practise however, I've never
> >seen it work correctly. We've seen several disks with say 1-5 bad
> >blocks and nothing else, and "dd if=/dev/zero of=/dev/<disk>" doesn't
> >seem to cure them.
> >
> >Roger.
> >
> >-- 
> >+-- Rogier Wolff -- www.harddisk-recovery.nl -- 0800 220 20 20 --
> >| Files foetsie, bestanden kwijt, alle data weg?!
> >| Blijf kalm en neem contact op met Harddisk-recovery.nl!
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/ 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
