Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269076AbUJERuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269076AbUJERuo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 13:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269127AbUJERun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 13:50:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:44944 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269076AbUJERts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 13:49:48 -0400
Date: Tue, 5 Oct 2004 10:47:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: jeffpc@optonline.net, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       trivial@rustcorp.com.au, rusty@rustcorp.com.au, greg@kroah.com
Subject: Re: [PATCH 2.6][resend] Add DEVPATH env variable to hotplug helper
 call
Message-Id: <20041005104744.59177aea.akpm@osdl.org>
In-Reply-To: <20041005102706.A27795@unix-os.sc.intel.com>
References: <20041003100857.GB5804@optonline.net>
	<20041003162012.79296b37.akpm@osdl.org>
	<20041004102220.A3304@unix-os.sc.intel.com>
	<20041004123725.58f1e77c.akpm@osdl.org>
	<20041004124355.A17894@unix-os.sc.intel.com>
	<20041005012556.A22721@unix-os.sc.intel.com>
	<20041005101823.223573d9.akpm@osdl.org>
	<20041005102706.A27795@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com> wrote:
>
> On Tue, Oct 05, 2004 at 10:18:23AM -0700, Andrew Morton wrote:
>  > Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com> wrote:
>  > >
>  > > 	Here is what I have come up with(please take a look at this patch).
>  > >  I was successfully able to get rid of cpu_run_sbin_hotplug() function, but
>  > >  when I call kobject_hotplug() function, it is finding 
>  > >  top_kobj->kset->hotplug_ops set to NULL and hence returns without calling
>  > >  call_usermodehelper(). Not sure if this is a bug in kobject_hotplug(), 
>  > >  I feel kobject_hotplug() function should continue even if 
>  > >  top_kobj->kset-hotplug_ops is NULL.
>  > 
>  > Yes, it doesn't seem necessary.  We could give cpu_sysdev_class a
>  > valid-but-empty hotplug_ops but it seems simpler and more general to do it
>  > in kobject_hotplug().
> 
>  I tried that, but I found that parent "cpu" directory i.e
>  /sys/devices/system/cpu itself was not getting created. Any clues?

I don't see why the change to kobject_hotplug() would cause that directory
to not be created.

With your patch and mine applied, /sys/devices/system/cpu is present and
populated on my test box.

