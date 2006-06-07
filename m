Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbWFGSu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWFGSu4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 14:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWFGSu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 14:50:56 -0400
Received: from mx0.towertech.it ([213.215.222.73]:15239 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S1751255AbWFGSuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 14:50:54 -0400
Date: Wed, 7 Jun 2006 20:50:27 +0200
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrew Victor <andrew@sanpeople.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RTC: Ensure that time being passed to set_alarm() is
 valid.
Message-ID: <20060607205027.3016d386@inspiron>
In-Reply-To: <20060607113911.1dd03687.akpm@osdl.org>
References: <1149704455.20386.90.camel@fuzzie.sanpeople.com>
	<20060607113911.1dd03687.akpm@osdl.org>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2006 11:39:11 -0700
Andrew Morton <akpm@osdl.org> wrote:

> > diff -urN -x CVS linux-2.6.17-rc6/drivers/rtc/interface.c
> > linux-2.6.17-rc/drivers/rtc/interface.c
> > --- linux-2.6.17-rc6/drivers/rtc/interface.c	Tue Jun  6 10:28:05 2006
> > +++ linux-2.6.17-rc/drivers/rtc/interface.c	Wed Jun  7 11:46:28 2006
> > @@ -129,6 +129,10 @@
> >  	int err;
> >  	struct rtc_device *rtc = to_rtc_device(class_dev);
> >  
> > +	err = rtc_valid_tm(&alarm->time);
> > +	if (err != 0)
> > +		return err;
> > +
> >  	err = mutex_lock_interruptible(&rtc->ops_lock);
> >  	if (err)
> >  		return -EBUSY;
> > 
> 
> More details, please.  How can this situation come about?  Buggy kernel
> code?  Userspace action?

 both of them. this call is used by the dev interface
 but might also be used by any in-kernel user (there are none
 at the moment, but we might have them in the future).

 the same kind of check is done in rtc_set_time()
 for the same reason.

 however, the dev interface (RTC_ALM_SET)
 sets some of the tm fields to -1, which is
 invalid for rtc_valid_tm. 

 I haven't thought of this when I suggested to Andrew Victor
 to add this rtc_valid_tm call.

 so we might have to remove this call or to modify
 rtc_valid_tm to detect this. 

 suggestions?

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

