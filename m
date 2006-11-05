Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965759AbWKEAMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965759AbWKEAMr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 19:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965760AbWKEAMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 19:12:47 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:28612 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S965759AbWKEAMq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 19:12:46 -0500
Subject: Re: [PATCH 1/9] Task Watchers v2: Task watchers v2
From: Matt Helsley <matthltc@us.ibm.com>
To: dwalker@mvista.com
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
       Steve Grubb <sgrubb@redhat.com>, linux-audit@redhat.com,
       Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1162602805.12956.11.camel@dwalker1.mvista.com>
References: <20061103042257.274316000@us.ibm.com>
	 <20061103042748.438619000@us.ibm.com>
	 <1162560154.2801.13.camel@localhost.localdomain>
	 <1162600994.12419.397.camel@localhost.localdomain>
	 <1162602805.12956.11.camel@dwalker1.mvista.com>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Sat, 04 Nov 2006 16:12:42 -0800
Message-Id: <1162685562.12419.408.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-03 at 17:13 -0800, Daniel Walker wrote:
> On Fri, 2006-11-03 at 16:43 -0800, Matt Helsley wrote:
> 
> > I can certainly change this. In my defense I didn't capitalize it
> > because very similar macros in init.h were not capitalized. For example:
> > 
> > #define core_initcall(fn)               __define_initcall("1",fn)
> > #define postcore_initcall(fn)           __define_initcall("2",fn)
> > #define arch_initcall(fn)               __define_initcall("3",fn)
> > #define subsys_initcall(fn)             __define_initcall("4",fn)
> > #define fs_initcall(fn)                 __define_initcall("5",fn)
> > #define device_initcall(fn)             __define_initcall("6",fn)
> > #define late_initcall(fn)               __define_initcall("7",fn)
> > 
> > setup_param, early_param, module_init, etc. do not use all-caps. And I'm
> > sure that's not all.
> 
> True .. It's not mandatory. The reason that I mentioned it is because it
> looked like a function was being called outside a function block, which
> looks odd to me. I think I overlook the initcall functions because I see
> them so often I know what they are.

This is a good point -- it does look odd. I'm considering:

DEFINE_TASK_INITCALL(audit_alloc);

With others like:

DEFINE_TASK_EXITCALL()
DEFINE_TASK_CLONECALL()
etc.

That resembles other macros which create variables. Though I'm not sure
this patten is appropriate because these variables should not be used by
name.

Seems that no matter what something about it is going to be unusual. :)

> > All of these declare variables and assign them attributes and values.
> > 
> > > Looking at it now could you do something like,
> > > 
> > > static int __task_watcher_init 
> > > audit_alloc(unsigned long val, struct task_struct *tsk)
> > > 
> > > Instead of a macro? Might be a little less invasive.
> > 
> > 	I like your suggestion. However, I don't see how such a macro could be
> > made to replace the current macro.
> > 
> > 	I need to be able to call every init function during task
> > initialization. The current macro creates and initializes a function
> > pointer in an array in the special ELF section. This allows the
> > notify_task_watchers function to traverse the array and make calls to
> > the init functions.
> 
> 
> You get an "A" for research. I didn't notice you actually declare a

Thanks!

<snip>

Cheers,
	-Matt Helsley

