Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266864AbUIAXOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266864AbUIAXOA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268114AbUIAXNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 19:13:37 -0400
Received: from baikonur.stro.at ([213.239.196.228]:151 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S264726AbUIAXIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 19:08:46 -0400
Date: Thu, 2 Sep 2004 01:08:40 +0200
From: maximilian attems <janitor@sternwelten.at>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, kj <kernel-janitors@osdl.org>
Subject: Re: [patch 21/25]  hvc_console: replace schedule_timeout() with msleep()
Message-ID: <20040901230840.GG7467@stro.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, kj <kernel-janitors@osdl.org>
References: <E1C2cAg-0007UH-3I@sputnik> <20040901153034.35104957.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040901153034.35104957.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Sep 2004, Andrew Morton wrote:

> janitor@sternwelten.at wrote:
> >
> > -#define TIMEOUT		((HZ + 99) / 100)
> > +#define TIMEOUT		10
> >  
> >  static struct tty_driver *hvc_driver;
> >  static int hvc_offset;
> > @@ -276,8 +277,7 @@ int khvcd(void *unused)
> >  			for (i = 0; i < MAX_NR_HVC_CONSOLES; ++i)
> >  				hvc_poll(i);
> >  		}
> > -		set_current_state(TASK_INTERRUPTIBLE);
> > -		schedule_timeout(TIMEOUT);
> > +		msleep(TIMEOUT);
> 
> This one is wrong: we need to sleep in interruptible state here, otherwise
> this kernel thread will contribute to the system load average.

could we add for such cases msleep_interruptible()?
patch for that function was sent separately.
 
> Several other of your msleep conversion patches actually fix bugs.  You've
> found drivers which want to sleep for a fixed period, but they do that with
> TASK_INTERRUPTIBLE.  If someone sends the calling process a signal, these
> drivers will end up not sleeping at all and may fail.

i'll instantly queue some more msleep conversions up.
 
> I'll going through these patches and shall apply the ones which look right.
> Please consider them all to have been handled, thanks.

thanks cool :)
 
--
maks
kernel janitor  	http://janitor.kernelnewbies.org/

