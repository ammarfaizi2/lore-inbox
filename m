Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262347AbVBXNlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbVBXNlc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 08:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262348AbVBXNlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 08:41:32 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:9632 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262347AbVBXNlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 08:41:25 -0500
Date: Thu, 24 Feb 2005 19:11:43 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, fastboot@lists.osdl.org,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: [PATCH] Fix for broken kexec on panic
Message-ID: <20050224134143.GC5781@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <1109236432.5148.192.camel@terminator.in.ibm.com> <20050224011312.29668947.akpm@osdl.org> <20050224121649.GB5781@in.ibm.com> <m1wtsyrtue.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1wtsyrtue.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 06:05:45AM -0700, Eric W. Biederman wrote:
> Maneesh Soni <maneesh@in.ibm.com> writes:
> 
> > On Thu, Feb 24, 2005 at 01:13:12AM -0800, Andrew Morton wrote:
> > > Vivek Goyal <vgoyal@in.ibm.com> wrote:
> > > >
> > > > Kexec on panic is broken on i386 in 2.6.11-rc3-mm2 because of
> > > >  re-organization of boot memory allocator initialization code.
> > > 
> > > OK...
> > > 
> > > Where are we up to with these patches, btw?  Do you consider them
> > > close-to-complete?  Do you have a feel for what proportion of machines will
> > > work correctly?
> > 
> > After the rework of kexec patches, there is very minimal kernel code needed
> > for kdump and most of the code is in user space kexec-tools. The changes
> > needed in kexec-tools to load the crashdump kernel and generate ELF headers,
> > for x86 architecture are done and will be posted for comments today by Vivek. 
> 
> Cool.
>  
> > Currently the work remaining is to capture the old-kernel memory during second 
> > kernel boot up. There is some lack of consensus whether this functionality 
> > should go in kernel-space (/proc/vmcore) or user-space (a separate utility
> > which can be run from initrd). Before the last kexec rework, kdump has the 
> > facility to do /proc/vmcore and now it has to be re-done accordingly. There is 
> > some code already done by Eric to do it in user-space. We are evaluating both
> > the approaches and should arrive at the conclusion asap.
> 
> Do you have a pointer to your user space kdump stuff?  I have never
> seen it.

Actually I meant user space utility done by you. IMO, /proc/vmcore option 
as saves one from the hassel of a _new_ user space tool to configure / capture 
crash dumps. Though a user-space tool in addition to /proc/vmcore can be useful 
also in a badly crashed system.

> How to configure this and the usability issues are interesting.  There is
> no fundamental reason the code needs to live in a ramdisk.  We are back
> in a fully functional kernel after all.  In this case a
> ramdisk/initramfs is useful for the same reason a ramdisk with a 
> rescue disk is useful.  It is possible the normal root filesystem is
> corrupt.   A ramdisk allows you to have a known good copy of your
> tools.
> 
> Eric

-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
