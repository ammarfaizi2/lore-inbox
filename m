Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVBRTJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVBRTJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 14:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVBRTJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 14:09:59 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:20397 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261455AbVBRTJx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 14:09:53 -0500
Subject: Re: [PATCH] 2.6.10 patch to export kallsyms_lookup_name()
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050218184203.GA23792@infradead.org>
References: <1108751348.20053.1756.camel@dyn318077bld.beaverton.ibm.com>
	 <20050218184203.GA23792@infradead.org>
Content-Type: text/plain
Organization: 
Message-Id: <1108753801.20053.1764.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 18 Feb 2005 11:10:02 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-18 at 10:42, Christoph Hellwig wrote:
> On Fri, Feb 18, 2005 at 10:29:08AM -0800, Badari Pulavarty wrote:
> > Hi,
> > 
> > Trivial patch to export kallsyms_lookup_name() for
> > kprobe/jprobe module use.
> > 
> > Please apply. 
> > 
> > (BTW, I personally don't care if it should be
> > EXPORT_SYMBOL_GPL or EXPORT_SYMBOL).
> 
> Certainly should be _GPL.  And where's the example user?
> 

GPL it is then :)

There are bunch of kprobes/jprobe modules 

Packet tracer module:

http://lkml.org/lkml/2004/8/16/179

I have few modules for adding dump_stack()
and collect few stats in various places (mostly
for debugging things). If you really want to see them
I can post.

The routine is used for resolving symbol to address, 
so that we can insert probe point, like ..

+	for (i = 0, nt = nettrace_objs; i < MAX_NETTRACE_ROUTINE; i++, nt++) {
+		nt = &nettrace_objs[i];
+		nt->jp.kp.addr = (kprobe_opcode_t *)
+		    kallsyms_lookup_name(nt->funcname);
+		if (nt->jp.kp.addr) {
+			printk("plant jprobe at %s (%p), handler addr %p\n",
+			       nt->funcname, nt->jp.kp.addr, nt->jp.entry);
+			register_jprobe(&nt->jp);
+		} else {
+			printk("couldn't find %s to plant jprobe\n",
+			       nt->funcname);
+		}
+	}


Thanks,
Badari

