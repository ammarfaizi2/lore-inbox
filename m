Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVEZDwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVEZDwd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 23:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVEZDwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 23:52:33 -0400
Received: from fire.osdl.org ([65.172.181.4]:9694 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261174AbVEZDwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 23:52:30 -0400
Date: Wed, 25 May 2005 20:48:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shaohua Li <shaohua.li@intel.com>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org,
       David Mosberger <davidm@napali.hpl.hp.com>
Subject: Re: Hotplug CPU printk issue
Message-Id: <20050525204828.70acc1b5.akpm@osdl.org>
In-Reply-To: <1117076334.4086.11.camel@linux-hp.sh.intel.com>
References: <1113467253.2568.10.camel@sli10-desk.sh.intel.com>
	<1117076334.4086.11.camel@linux-hp.sh.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaohua Li <shaohua.li@intel.com> wrote:
>
>  > --- a/kernel/printk.c   2005-04-12 10:12:19.000000000 +0800 
>  > +++ b/kernel/printk.c   2005-04-13 17:22:40.912897328 +0800 
>  > @@ -624,8 +624,7 @@ asmlinkage int vprintk(const char *fmt,  
>  >                         log_level_unknown = 1; 
>  >         } 
>  >   
>  > -       if (!cpu_online(smp_processor_id()) && 
>  > -           system_state != SYSTEM_RUNNING) { 
>  > +       if (!cpu_online(smp_processor_id())) { 
>  >                 /* 
>  >                  * Some console drivers may assume that per-cpu resources have 
>  >                  * been allocated.  So don't allow them to be called by this
>  Andrew,
>  Could above patch be put into mm tree?

Well not in that form.  I'd appreciate being sent patches which are
applyable rather than mangled messes, please.

> It fixes the oops of CPU hotplug
>  with radeon fb enabled.
>  The reason is the per-cpu data (radeon fb calls kmalloc) isn't
>  initialized when CPU hotplug is processing. system_state is
>  SYSTEM_RUNNING for cpu hotplug.

That system_state test was explicitly added by davidm a year ago:

"- Allow printk on down cpus once system is running."

Please confirm that we in fact do not want to allow downed CPUs to
print things, then send a patch.
