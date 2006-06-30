Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWF3FpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWF3FpZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 01:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWF3FpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 01:45:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46468 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751120AbWF3FpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 01:45:24 -0400
Date: Fri, 30 Jun 2006 01:45:18 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       linux-kernel@vger.kernel.org, alexey.y.starikovskiy@intel.com
Subject: Re: [RFC] Adding queue_delayed_work_on interface for workqueues
Message-ID: <20060630054518.GF32729@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	linux-kernel@vger.kernel.org, alexey.y.starikovskiy@intel.com
References: <20060628141028.A13221@unix-os.sc.intel.com> <20060628143242.486f9b15.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628143242.486f9b15.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 02:32:42PM -0700, Andrew Morton wrote:

 > > +extern int FASTCALL(queue_delayed_work_on(int cpu, struct workqueue_struct *wq, struct work_struct *work, unsigned long delay));
 > 
 > Please wrap at 80-cols.

fixed up

 > I wouldn't bother making this FASTCALL.  It's an ugly thing, and why this
 > particular function?  And this isn't fastpath stuff.

fixed up

 > > -extern int schedule_delayed_work_on(int cpu, struct work_struct *work, unsigned long delay);
 > > +extern int FASTCALL(schedule_delayed_work_on(int cpu, struct work_struct *work, unsigned long delay));
 > 
 > Ditto.

ditto :)

 > >  }
 > >  
 > > +int fastcall queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
 > > +			struct work_struct *work, unsigned long delay)
 > > +{
 > > +}
 > 
 > Feel free to add some kernel-doc for this function ;)

Venki, I'm lazy and it's past my bedtime, send a follow-up diff please ?

 > > @@ -608,6 +615,7 @@ void init_workqueues(void)
 > >  EXPORT_SYMBOL_GPL(__create_workqueue);
 > >  EXPORT_SYMBOL_GPL(queue_work);
 > >  EXPORT_SYMBOL_GPL(queue_delayed_work);
 > > +EXPORT_SYMBOL_GPL(queue_delayed_work_on);
 > >  EXPORT_SYMBOL_GPL(flush_workqueue);
 > >  EXPORT_SYMBOL_GPL(destroy_workqueue);
 > 
 > Opinions vary a bit, but I think we mostly prefer to put the
 > EXPORT_SYMBOL()s at the site of the thing which is being exported:
 >.. 
 > Then again, it's legit to follow existing local style too.  Someone will
 > come along later and fix it all in a single hit.  Whatever.

That someone was me. I did it as a follow-on for Venki's series.

All pushed out to cpufreq.git

		Dave

-- 
http://www.codemonkey.org.uk
