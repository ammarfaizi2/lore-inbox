Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbULTBQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbULTBQA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 20:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbULTBQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 20:16:00 -0500
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:15228 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261366AbULTBPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 20:15:53 -0500
Subject: Re: [PATCH] Remove RCU abuse in cpu_idle()
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Nish Aravamudan <nish.aravamudan@gmail.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>, Li Shaohua <shaohua.li@intel.com>,
       Len Brown <len.brown@intel.com>
In-Reply-To: <Pine.LNX.4.61.0412191757450.18310@montezuma.fsmlabs.com>
References: <20041205004557.GA2028@us.ibm.com>
	 <20041205232007.7edc4a78.akpm@osdl.org>
	 <Pine.LNX.4.61.0412060157460.1036@montezuma.fsmlabs.com>
	 <20041206160405.GB1271@us.ibm.com>
	 <Pine.LNX.4.61.0412060941560.5219@montezuma.fsmlabs.com>
	 <20041206192243.GC1435@us.ibm.com>
	 <Pine.LNX.4.61.0412110804500.5214@montezuma.fsmlabs.com>
	 <Pine.LNX.4.61.0412112123490.7847@montezuma.fsmlabs.com>
	 <Pine.LNX.4.61.0412112205290.7847@montezuma.fsmlabs.com>
	 <Pine.LNX.4.61.0412112244000.7847@montezuma.fsmlabs.com>
	 <29495f1d04121818403f949fdd@mail.gmail.com>
	 <Pine.LNX.4.61.0412191757450.18310@montezuma.fsmlabs.com>
Content-Type: text/plain
Date: Mon, 20 Dec 2004 12:15:44 +1100
Message-Id: <1103505344.5093.4.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-12-19 at 17:59 -0700, Zwane Mwaikambo wrote:
> On Sat, 18 Dec 2004, Nish Aravamudan wrote:
> 
> > All of these schedule_timeout() calls are broken. They do not set the
> > state before hand and therefore will return early. Since you're not
> > checking for signals and there are no waitqueue events around the
> > code, I'm assuming you can just use ssleep(1) instead of the current
> > schedule_timeout() calls.
> 
> Returning early is fine (and will happen if the other processors are 
> busy), we're spinning on a condition, but yes ssleep() could be used 
> instead.
> 

Hi Zwane,

This thread can possibly be stalled forever if there is a CPU hog
running, right?

In which case, you will want to use ssleep rather than a busy loop.

Another alternative may be to use more complex logic to detect that a
CPU is not in the idle loop at all. In that case, a simple cpu_relax
type spin loop should be OK, because the synchronisation would be
achieved very quickly.

Nick


