Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262099AbVBJL2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbVBJL2n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 06:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbVBJL2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 06:28:42 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:25787 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262099AbVBJL2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 06:28:40 -0500
Date: Thu, 10 Feb 2005 16:58:54 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: prasanna@in.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       suparna@in.ibm.com
Subject: Re: 2.6.10 kprobes/jprobes panic
Message-ID: <20050210112854.GA4197@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <1107907174.20053.52.camel@dyn318077bld.beaverton.ibm.com> <20050209050719.GA12528@in.ibm.com> <1107993815.20053.93.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107993815.20053.93.camel@dyn318077bld.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2005 at 04:03:36PM -0800, Badari Pulavarty wrote:
> On Tue, 2005-02-08 at 21:07, Prasanna S Panchamukhi wrote:
[..]
> > > 
> > 
> > Error check and graceful exit can be done in the jprobe handler
> > module. In the jprobe network packet logging patch, error check
> > was taken care by using kallsyms_lookup_name() as shown below.
> > 
> > 	nt->jp.kp.addr = (kprobe_opcode_t *)
> > 		    kallsyms_lookup_name(nt->funcname);
> > 		if (nt->jp.kp.addr) {
> > 			printk("plant jprobe at %s (%p), handler addr %p\n",
> > 			       nt->funcname, nt->jp.kp.addr, nt->jp.entry);
> > 			register_jprobe(&nt->jp);
> > 		} else {
> > 			printk("couldn't find %s to plant jprobe\n",
> > 			       nt->funcname);
> > 		}. 
> > 
> 
> I tried to do this earlier in my module, but I get
> 
> # insmod myprobe.ko
> insmod: error inserting 'myprobe.ko': -1 Unknown symbol in module
> myprobe: Unknown symbol kallsyms_lookup_name
> 
> How did you use it ? it looks like kallsyms_lookup_name()
> is not exported. Thats the reason why I was hardcoding addresses.
> 

I checked the network packet logging patch, it also adds the 
EXPORT_SYMBOL(kallsyms_lookup_name).  :)

http://prdownloads.sourceforge.net/dprobes/plog.tar.gz?download

Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
