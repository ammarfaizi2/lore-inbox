Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266488AbRHWOOg>; Thu, 23 Aug 2001 10:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266808AbRHWOO1>; Thu, 23 Aug 2001 10:14:27 -0400
Received: from duba06h06-0.dplanet.ch ([212.35.36.67]:50954 "EHLO
	duba06h06-0.dplanet.ch") by vger.kernel.org with ESMTP
	id <S266488AbRHWOOM>; Thu, 23 Aug 2001 10:14:12 -0400
Date: Thu, 23 Aug 2001 16:10:55 +0200
From: Roger Luethi <rl@hellgate.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH (URL), RFC] Stackable dmi_blacklist rules
Message-ID: <20010823161055.A1029@tm.hellgate.ch>
In-Reply-To: <20010823152200.A853@tm.hellgate.ch> <E15Zua2-0003sM-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <E15Zua2-0003sM-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Aug 23, 2001 at 02:31:30PM +0100
X-Operating-System: Linux 2.4.5-ac13 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Currently, we walk the list and throw out bad apples based on full
> > or partial strings we match against what we get from the BIOS.
> > Once a rule matches, the value is immutable.
> 
> Hardly. You can set it back, you can also access the fields to make 
> complex decisions after a match call. 

You'd have to write extra feature_off callback functions, though
(or change the existing ones, as I did), since currently no callback
function allows to reset a value once it was called. They are all
coded like this:

static __init int apm_is_horked(struct dmi_blacklist *d)
{
	if (apm_info.disabled == 0)
	
		apm_info.disabled = 1;
		printk(KERN_INFO "%s machine detected. Disabling APM.\n", d->ident);
	
	return 0;
}

What I was looking for was a solution which allows resetting values
simply by changing the dmi_blacklist.

One can of course argue that we can always add apm_is_not_horked_after_all()
should the need ever arise.

Roger Luethi
