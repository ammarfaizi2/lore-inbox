Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264561AbUGHVlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264561AbUGHVlz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 17:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263761AbUGHVly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 17:41:54 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:39300 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S264561AbUGHVln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 17:41:43 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-mm6: system hang with KAMix on dual Opteron w/ NUMA
Date: Thu, 8 Jul 2004 23:50:52 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200407082324.55181.rjwysocki@sisk.pl> <20040708142153.60c2cb69.akpm@osdl.org>
In-Reply-To: <20040708142153.60c2cb69.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407082350.52483.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 of July 2004 23:21, Andrew Morton wrote:
> "R. J. Wysocki" <rjwysocki@sisk.pl> wrote:
> >  I've just discovered that I'm (consistently) able to hang the system
> > solid by trying to adjust the sound volume using KAMix on 2.6.7-mm6 (SuSE
> > 9.1/ AMD64).
>
> Please ensure that your kernel has this patch:
>
> --- 25/sound/core/control.c~snd_ctl_read-locking-fix-fix	2004-07-06
> 21:27:51.618683360 -0700 +++ 25-akpm/sound/core/control.c	2004-07-06
> 21:27:51.622682752 -0700 @@ -1116,7 +1116,7 @@ static ssize_t
> snd_ctl_read(struct file
>  			wait_queue_t wait;
>  			if ((file->f_flags & O_NONBLOCK) != 0 || result > 0) {
>  				err = -EAGAIN;
> -				goto out;
> +				goto __end;
>  			}
>  			init_waitqueue_entry(&wait, current);
>  			add_wait_queue(&ctl->change_sleep, &wait);
> @@ -1137,7 +1137,7 @@ static ssize_t snd_ctl_read(struct file
>  		kfree(kev);
>  		if (copy_to_user(buffer, &ev, sizeof(snd_ctl_event_t))) {
>  			err = -EFAULT;
> -			goto __end;
> +			goto out;
>  		}
>  		spin_lock_irq(&ctl->read_lock);
>  		buffer += sizeof(snd_ctl_event_t);
> _

It hadn't and the patch fixed the issue. :-)

Thanks,
rjw

-- 
Rafael J. Wysocki
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
