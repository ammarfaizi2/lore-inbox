Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261975AbVBJABn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbVBJABn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 19:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVBJABn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 19:01:43 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:14721 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261975AbVBJABj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 19:01:39 -0500
Subject: Re: 2.6.10 kprobes/jprobes panic
From: Badari Pulavarty <pbadari@us.ibm.com>
To: prasanna@in.ibm.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       suparna@in.ibm.com
In-Reply-To: <20050209050719.GA12528@in.ibm.com>
References: <1107907174.20053.52.camel@dyn318077bld.beaverton.ibm.com>
	 <20050209050719.GA12528@in.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1107993815.20053.93.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Feb 2005 16:03:36 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-08 at 21:07, Prasanna S Panchamukhi wrote:
> Hi Badri,
> 
> > Hi,
> > 
> > I ran into this while playing with jprobes in 2.6.10.
> > 
> > I tried to install jprobe handler on a invalid address,
> 
> User should prevent inserting jprobes on an invalid address.

Well, I was hoping register handler would do some basic
error checking to prevent user from panicking. For example,
I ran into it untentionally (I moved my code from ia32 to
x86-64, forgot to update the addresses).

> 
> > I get OOPS. I was hoping for a error check and a graceful
> > exit rather than kernel Oops.
> > 
> 
> Error check and graceful exit can be done in the jprobe handler
> module. In the jprobe network packet logging patch, error check
> was taken care by using kallsyms_lookup_name() as shown below.
> 
> 	nt->jp.kp.addr = (kprobe_opcode_t *)
> 		    kallsyms_lookup_name(nt->funcname);
> 		if (nt->jp.kp.addr) {
> 			printk("plant jprobe at %s (%p), handler addr %p\n",
> 			       nt->funcname, nt->jp.kp.addr, nt->jp.entry);
> 			register_jprobe(&nt->jp);
> 		} else {
> 			printk("couldn't find %s to plant jprobe\n",
> 			       nt->funcname);
> 		}. 
> 

I tried to do this earlier in my module, but I get

# insmod myprobe.ko
insmod: error inserting 'myprobe.ko': -1 Unknown symbol in module
myprobe: Unknown symbol kallsyms_lookup_name

How did you use it ? it looks like kallsyms_lookup_name()
is not exported. Thats the reason why I was hardcoding addresses.

# grep KALL .config
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_EXTRA_PASS=y


Thanks,
Badari



