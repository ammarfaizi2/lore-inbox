Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWBCHIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWBCHIA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 02:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWBCHIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 02:08:00 -0500
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:7628 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751124AbWBCHH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 02:07:59 -0500
Date: Fri, 3 Feb 2006 02:02:41 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch -mm4] i386 cpu hotplug: don't access freed memory
To: Andrew Morton <akpm@osdl.org>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org, davej@redhat.com,
       ashok.raj@intel.com
Message-ID: <200602030207_MC3-1-B773-7C82@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060202165257.29dcfa20.akpm@osdl.org>

On Thu, 2 Feb 2006 at 16:52:57 -0800, Andrew Morton wrote:

> Chuck Ebbert <76306.1226@compuserve.com> wrote:
> >
> > @@ -160,10 +162,17 @@ static void __cpuinit get_cpu_vendor(str
> >                             c->x86_vendor = i;
> >                             if (!early)
> >                                     this_cpu = cpu_devs[i];
> > -                           break;
> > +                           return;
> >                     }
> >             }
> >     }
> > +   if (!printed) {
> > +           printed++;
> > +           printk(KERN_ERR "CPU: Vendor unknown, using generic init.\n");
> > +           printk(KERN_ERR "CPU: Your system may be unstable.\n");
> > +   }
> > +   c->x86_vendor = X86_VENDOR_UNKNOWN;
> > +   this_cpu = &default_cpu;
> 
> Well that's a worry.  Under what circumstances (if any) will this final bit
> of code get executed?

It should happen when someone hotplugs a CPU on an AMD SMP machine.  But it
was already broken in that case.

So now we have to decide whether to make the AMD code __cpuinit instead
of __init and keep it around for hotplug.  I can't test that so I didn't
try it.

-- 
Chuck

