Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWAPTia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWAPTia (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 14:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWAPTia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 14:38:30 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:23734 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751144AbWAPTi3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 14:38:29 -0500
Subject: Re: [Ext2-devel] Re: Fall back io scheduler for 2.6.15?
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: seelam@cs.utep.edu, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, Jens Axboe <axboe@suse.de>
In-Reply-To: <20060113174914.7907bf2c.akpm@osdl.org>
References: <1112673094.14322.10.camel@mindpipe>
	 <1112971236.1975.104.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112983801.10605.32.camel@dyn318043bld.beaverton.ibm.com>
	 <1113220089.2164.52.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113244710.4413.38.camel@localhost.localdomain>
	 <1113249435.2164.198.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113288087.4319.49.camel@localhost.localdomain>
	 <1113304715.2404.39.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113348434.4125.54.camel@dyn318043bld.beaverton.ibm.com>
	 <1113388142.3019.12.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1114207837.7339.50.camel@localhost.localdomain>
	 <1114659912.16933.5.camel@mindpipe>
	 <1114715665.18996.29.camel@localhost.localdomain>
	 <1136935562.4901.41.camel@dyn9047017067.beaverton.ibm.com>
	 <20060110212551.411a766d.akpm@osdl.org>
	 <1137007032.4395.24.camel@localhost.localdomain>
	 <20060111114303.45540193.akpm@osdl.org>
	 <1137201135.4353.81.camel@localhost.localdomain>
	 <20060113174914.7907bf2c.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM LTC
Date: Mon, 16 Jan 2006 11:38:18 -0800
Message-Id: <1137440298.3724.12.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 17:49 -0800, Andrew Morton wrote:
> Mingming Cao <cmm@us.ibm.com> wrote:
> >
> > On 2.6.14, the
> > fall back io scheduler (if the chosen io scheduler is not found) is set
> > to the default io scheduler (anticipatory, in this case), but since
> > 2.6.15-rc1, this semanistic is changed to fall back to noop.
> 
> OK.  And I assume that AS wasn't compiled, so that's why it fell back?
> 

AS was compiled, and AS is set as the default scheduler. But since
2.6.15 doesn't recognize "elevator=as" (we need to say
"elevator=anticipatory"), so in 2.6.15, elevator_setup_default() will
explicitly fall back to "noop" scheduler.

2.6.14 doesn't recognize "elevator=as" either, but it fall back to the
default scheduler instead. Which makes more sense, as Jen pointed out.

> I actually thought that elevator= got removed, now we have
> /sys/block/sda/queue/scheduler.  But I guess that's not very useful with
> CONFIG_SYSFS=n.
> 
> > Is there any reason to fall back to noop instead of as?  It seems
> > anticipatory is much better than noop for ext3 with large sequential
> > write tests (i.e, 1G dd test) ...
> 
> I suspect that was an accident.  Jens?
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
> _______________________________________________
> Ext2-devel mailing list
> Ext2-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ext2-devel
> 

