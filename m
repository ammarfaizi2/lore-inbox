Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVELFom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVELFom (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 01:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVELFom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 01:44:42 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:64480 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261174AbVELFoc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 01:44:32 -0400
Date: Thu, 12 May 2005 11:14:24 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: vgoyal@in.ibm.com, fastboot@lists.osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>
Subject: Re: [Fastboot] kexec+kdump testing with 2.6.12-rc3-mm3
Message-ID: <20050512054424.GC3838@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <1115769558.26913.1046.camel@dyn318077bld.beaverton.ibm.com> <20050511025325.GA3638@in.ibm.com> <1115824847.26913.1061.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115824847.26913.1061.camel@dyn318077bld.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 08:20:50AM -0700, Badari Pulavarty wrote:
> On Tue, 2005-05-10 at 19:53, Vivek Goyal wrote:
> > On Tue, May 10, 2005 at 04:59:18PM -0700, Badari Pulavarty wrote:
> > > Hi,
> > > 
> > > I am using kexec+kdump on 2.6.12-rc3-mm3 and it seems to be working
> > > fine on my 4-way P-III 8GB RAM machine. I did touch testing with
> > > kexec+kdump and it worked fine. Then ran heavy IO load and forced
> > > a panic and I was able to collect the dump. But I am not able to
> > > analyze the dump to find out if I really got a valid dump or not :(
> > > 
> > 
> > Copying to LKML.
> > 
> > Gdb can not open a file larger than 2GB. You have got 8GB RAM hence
> > /proc/vmcore size must be similar. For testing purposes you can boot first
> > kernel with mem=2G and then take dump and analyze with gdb.
> 
> Its better with mem=2G, but gdb is not really useful :(
> I wanted to look at all the processes and their stacks..
> It shows me only one stack (not quite right). So I can't
> really use the dump for anything :(
> 


You can run "info thread" to see how many cpus are are there. Use "thread" to 
switch to a different thread and then run "bt" to see the stack of that
that thread. We have observed some issues with this. You will see proper
stack only if other cpus were not running swapper thread (pid 0).  

For seeing the stack of all the processes, I guess macros need to be written
which traverse the task list, retrieve stack pointer and then trace back. I
have not tried it though. 


> > 
> > But we need to work on some crash analysis tools like "crash" to be able
> > to debug larger files. 
> 
> Is some one working on this too ?
> 

Yes, we are looking into this.

Thanks
Vivek
