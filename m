Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269081AbUJESC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269081AbUJESC5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 14:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269092AbUJESC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 14:02:56 -0400
Received: from fmr04.intel.com ([143.183.121.6]:59074 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S269081AbUJESBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 14:01:48 -0400
Date: Tue, 5 Oct 2004 11:01:12 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
       jeffpc@optonline.net, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       trivial@rustcorp.com.au, rusty@rustcorp.com.au, greg@kroah.com
Subject: Re: [PATCH 2.6][resend] Add DEVPATH env variable to hotplug helper call
Message-ID: <20041005110112.B27795@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20041003100857.GB5804@optonline.net> <20041003162012.79296b37.akpm@osdl.org> <20041004102220.A3304@unix-os.sc.intel.com> <20041004123725.58f1e77c.akpm@osdl.org> <20041004124355.A17894@unix-os.sc.intel.com> <20041005012556.A22721@unix-os.sc.intel.com> <20041005101823.223573d9.akpm@osdl.org> <20041005102706.A27795@unix-os.sc.intel.com> <20041005104744.59177aea.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041005104744.59177aea.akpm@osdl.org>; from akpm@osdl.org on Tue, Oct 05, 2004 at 10:47:44AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2004 at 10:47:44AM -0700, Andrew Morton wrote:
> Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com> wrote:
> >
> > On Tue, Oct 05, 2004 at 10:18:23AM -0700, Andrew Morton wrote:
> >  > Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com> wrote:
> >  > >
> >  > > 	Here is what I have come up with(please take a look at this patch).
> >  > >  I was successfully able to get rid of cpu_run_sbin_hotplug() function, but
> >  > >  when I call kobject_hotplug() function, it is finding 
> >  > >  top_kobj->kset->hotplug_ops set to NULL and hence returns without calling
> >  > >  call_usermodehelper(). Not sure if this is a bug in kobject_hotplug(), 
> >  > >  I feel kobject_hotplug() function should continue even if 
> >  > >  top_kobj->kset-hotplug_ops is NULL.
> >  > 
> >  > Yes, it doesn't seem necessary.  We could give cpu_sysdev_class a
> >  > valid-but-empty hotplug_ops but it seems simpler and more general to do it
> >  > in kobject_hotplug().
> > 
> >  I tried that, but I found that parent "cpu" directory i.e
> >  /sys/devices/system/cpu itself was not getting created. Any clues?
> 
> I don't see why the change to kobject_hotplug() would cause that directory
> to not be created.
> 
> With your patch and mine applied, /sys/devices/system/cpu is present and
> populated on my test box.
Hi Andrew,
	I am attaching the second one, just to make sure you and I have the same one.
If this is different than what you are having let me know.

By the way I am testing on IA64 box, with 2.6.9-rc3 + just bk-driver-core.patch from 
your 2.6.9-rc3-mm2-broken-out.tar.
I had to go for just above as I was seeing some out of memory messages on my IA64 box
with complete rc3-mm2 patch.

thanks,
Anil

---

 linux-2.6.9-rc3-test-askeshav/drivers/base/cpu.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN drivers/base/cpu.c~test_akpm drivers/base/cpu.c
--- linux-2.6.9-rc3-test/drivers/base/cpu.c~test_akpm	2004-10-04 23:45:45.304124223 -0700
+++ linux-2.6.9-rc3-test-askeshav/drivers/base/cpu.c	2004-10-05 10:54:08.725507956 -0700
@@ -9,9 +9,11 @@
 #include <linux/topology.h>
 #include <linux/device.h>
 
+struct kset_hotplug_ops cpu_kset_hotplug_ops;
 
 struct sysdev_class cpu_sysdev_class = {
 	set_kset_name("cpu"),
+	.kset = { .hotplug_ops = &cpu_kset_hotplug_ops},
 };
 EXPORT_SYMBOL(cpu_sysdev_class);
 
_

