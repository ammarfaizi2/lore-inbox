Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbVKWMxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbVKWMxZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 07:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbVKWMxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 07:53:24 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:5329 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750754AbVKWMxY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 07:53:24 -0500
Date: Wed, 23 Nov 2005 18:20:45 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Greg KH <greg@kroah.com>, Steven Rostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: What protection does sysfs_readdir have with SMP/Preemption?
Message-ID: <20051123125045.GC22714@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <1132695202.13395.15.camel@localhost.localdomain> <20051122213947.GB8575@kroah.com> <20051123045049.GA22714@in.ibm.com> <20051123081845.GA32021@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123081845.GA32021@elte.hu>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 09:18:45AM +0100, Ingo Molnar wrote:
> 
> * Maneesh Soni <maneesh@in.ibm.com> wrote:
> 
> > But the bad pointer reference seen in sysfs_readdir() has to be 
> > debugged. Assumption here is that if there is a dentry attached to 
> > s_dirent, there has to be a inode associated becuase negative dentries 
> > are not created in sysfs. Is it possible to get some more information 
> > about the recreation scenario. Could you enable DEBUG printks for 
> > lib/kobject.c and drivers/base/class.c to see the events happening.
> 
> on a related note - i've been carrying the patch below in -rt for 2 
> months (i.e. Steven's kernel has it too), as a workaround against the 
> crash described below.

[ replied in the separate thread ]

> so it appears that the -rt kernel is triggering some genuine sysfs race.  
> [note that it only happens on an SMP kernel, booting an UP kernel or 
> with maxcpus=1 makes the bug go away.] I have done full kobject 
> debugging but no conclusive results. Also, that particular crash happens 
> earliest with PAGEALLOC enabled. [i have packed up the email discussion 
> related to that crash, and i'm sending it to Maneesh separately.  
> Maneesh, any ideas or suggestions?]
 
Still waiting for that mail to show up. Looks like this discussion is not
on lkml.

The kdobject or driver core debugging messages can possibly narrow the problem
down to some particular sysfs user like some driver or module and throw some
light on how the sysfs calls are being made.

> note that Steven has a dual-core Athlon64 X2 system. Steven, do you get 
> the crash even with maxcpus=1?
> 
> 	Ingo
> 

-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
