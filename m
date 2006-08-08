Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWHHJX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWHHJX7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 05:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWHHJX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 05:23:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:41651 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932162AbWHHJX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 05:23:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l9iBFDgSQ4OpM8KLw4lVHDaBJt1qW7iGcb0i7IlStNvA6maMupyh8iC/VWWfqR0vAGv2ICEm0xiD2SiVZUBc7ClB/FZKHgDR6C1uII9rH7wU50sP+gUA1ckEu4IwuylbWm8ZtUdz3/g3sAiRBxLMrl9CMKNMqzvg7eq3wGBA+ME=
Message-ID: <41840b750608080223q3e00370bsaf9893dcac57c8a6@mail.gmail.com>
Date: Tue, 8 Aug 2006 12:23:57 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Pavel Machek" <pavel@suse.cz>
Subject: Re: [PATCH 01/12] thinkpad_ec: New driver for ThinkPad embedded controller access
Cc: "Robert Love" <rlove@rlove.org>, "Jean Delvare" <khali@linux-fr.org>,
       "Greg Kroah-Hartman" <gregkh@suse.de>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
In-Reply-To: <20060807231557.GA2759@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11548492171301-git-send-email-multinymous@gmail.com>
	 <11548492242899-git-send-email-multinymous@gmail.com>
	 <20060807134440.GD4032@ucw.cz>
	 <41840b750608070813s6d3ffc2enefd79953e0b55caa@mail.gmail.com>
	 <20060807231557.GA2759@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/06, Pavel Machek <pavel@suse.cz> wrote:
> Okay... but do we really need try_lock variant?

We need a nonlocking, nonsleeping variant to do the query in the timer
function (softirq context).


> but what is try_lock semantics when taking multiple locks...?

Currently, the same as the undelying down_trylock().


> > >> +     if (!check_dmi_for_ec()) {
> > >> +             printk(KERN_ERR "thinkpad_ec: no ThinkPad embedded
> > >controller!\n");
> > >> +             return -ENODEV;
> > >
> > >KERN_ERR is little strong here, no?
> >
> > Not sure what's the right one. The user tried to load a module and the
> > module can't do that; I saw some drivers use KERN_ERR some
> > KERN_WARNING in similar cases. Is there some guideline on choosing
> > printk levels?
>
> Well, this will also trigger for thinkpad module compiled into kernel,
> right?

OK, I'm changing the DMI failure to KERN_WARNING. Subsequent hardware
checks remains KERN_ERR, since failing those after passing the DMI
check really is abnormal (and indicative of danger).

  Shem
