Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWKDBN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWKDBN2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 20:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWKDBN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 20:13:28 -0500
Received: from homer.mvista.com ([63.81.120.158]:46097 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S932287AbWKDBN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 20:13:27 -0500
Subject: Re: [PATCH 1/9] Task Watchers v2: Task watchers v2
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
       Steve Grubb <sgrubb@redhat.com>, linux-audit@redhat.com,
       Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1162600994.12419.397.camel@localhost.localdomain>
References: <20061103042257.274316000@us.ibm.com>
	 <20061103042748.438619000@us.ibm.com>
	 <1162560154.2801.13.camel@localhost.localdomain>
	 <1162600994.12419.397.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 03 Nov 2006 17:13:24 -0800
Message-Id: <1162602805.12956.11.camel@dwalker1.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-03 at 16:43 -0800, Matt Helsley wrote:

> I can certainly change this. In my defense I didn't capitalize it
> because very similar macros in init.h were not capitalized. For example:
> 
> #define core_initcall(fn)               __define_initcall("1",fn)
> #define postcore_initcall(fn)           __define_initcall("2",fn)
> #define arch_initcall(fn)               __define_initcall("3",fn)
> #define subsys_initcall(fn)             __define_initcall("4",fn)
> #define fs_initcall(fn)                 __define_initcall("5",fn)
> #define device_initcall(fn)             __define_initcall("6",fn)
> #define late_initcall(fn)               __define_initcall("7",fn)
> 
> setup_param, early_param, module_init, etc. do not use all-caps. And I'm
> sure that's not all.

True .. It's not mandatory. The reason that I mentioned it is because it
looked like a function was being called outside a function block, which
looks odd to me. I think I overlook the initcall functions because I see
them so often I know what they are.

> All of these declare variables and assign them attributes and values.
> 
> > Looking at it now could you do something like,
> > 
> > static int __task_watcher_init 
> > audit_alloc(unsigned long val, struct task_struct *tsk)
> > 
> > Instead of a macro? Might be a little less invasive.
> 
> 	I like your suggestion. However, I don't see how such a macro could be
> made to replace the current macro.
> 
> 	I need to be able to call every init function during task
> initialization. The current macro creates and initializes a function
> pointer in an array in the special ELF section. This allows the
> notify_task_watchers function to traverse the array and make calls to
> the init functions.


You get an "A" for research. I didn't notice you actually declare a
variable inside the macro. I thought it was only setting a section
attribute. You right, I don't see how you could call the functions in
the section without the variable declared. ( besides that's exactly how
the initcalls work. )

Daniel

