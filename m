Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268082AbUIAXoC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268082AbUIAXoC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267968AbUIAXmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 19:42:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:58500 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268095AbUIAXdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 19:33:09 -0400
Date: Wed, 1 Sep 2004 16:36:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: maximilian attems <janitor@sternwelten.at>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@osdl.org
Subject: Re: [patch 21/25]  hvc_console: replace schedule_timeout() with
 msleep()
Message-Id: <20040901163649.7e4f1060.akpm@osdl.org>
In-Reply-To: <20040901230840.GG7467@stro.at>
References: <E1C2cAg-0007UH-3I@sputnik>
	<20040901153034.35104957.akpm@osdl.org>
	<20040901230840.GG7467@stro.at>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

maximilian attems <janitor@sternwelten.at> wrote:
>
> > janitor@sternwelten.at wrote:
> > >
> > > -#define TIMEOUT		((HZ + 99) / 100)
> > > +#define TIMEOUT		10
> > >  
> > >  static struct tty_driver *hvc_driver;
> > >  static int hvc_offset;
> > > @@ -276,8 +277,7 @@ int khvcd(void *unused)
> > >  			for (i = 0; i < MAX_NR_HVC_CONSOLES; ++i)
> > >  				hvc_poll(i);
> > >  		}
> > > -		set_current_state(TASK_INTERRUPTIBLE);
> > > -		schedule_timeout(TIMEOUT);
> > > +		msleep(TIMEOUT);
> > 
> > This one is wrong: we need to sleep in interruptible state here, otherwise
> > this kernel thread will contribute to the system load average.
> 
> could we add for such cases msleep_interruptible()?

Sure.

Note that you're raising patches against some ancient kernel and that this
particular function has changed.
