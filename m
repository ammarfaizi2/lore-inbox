Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262336AbVBXNIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbVBXNIY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 08:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262338AbVBXNIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 08:08:23 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52417 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262336AbVBXNIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 08:08:18 -0500
To: maneesh@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, fastboot@lists.osdl.org,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: [PATCH] Fix for broken kexec on panic
References: <1109236432.5148.192.camel@terminator.in.ibm.com>
	<20050224011312.29668947.akpm@osdl.org>
	<20050224121649.GB5781@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 24 Feb 2005 06:05:45 -0700
In-Reply-To: <20050224121649.GB5781@in.ibm.com>
Message-ID: <m1wtsyrtue.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maneesh Soni <maneesh@in.ibm.com> writes:

> On Thu, Feb 24, 2005 at 01:13:12AM -0800, Andrew Morton wrote:
> > Vivek Goyal <vgoyal@in.ibm.com> wrote:
> > >
> > > Kexec on panic is broken on i386 in 2.6.11-rc3-mm2 because of
> > >  re-organization of boot memory allocator initialization code.
> > 
> > OK...
> > 
> > Where are we up to with these patches, btw?  Do you consider them
> > close-to-complete?  Do you have a feel for what proportion of machines will
> > work correctly?
> 
> After the rework of kexec patches, there is very minimal kernel code needed
> for kdump and most of the code is in user space kexec-tools. The changes
> needed in kexec-tools to load the crashdump kernel and generate ELF headers,
> for x86 architecture are done and will be posted for comments today by Vivek. 

Cool.
 
> Currently the work remaining is to capture the old-kernel memory during second 
> kernel boot up. There is some lack of consensus whether this functionality 
> should go in kernel-space (/proc/vmcore) or user-space (a separate utility
> which can be run from initrd). Before the last kexec rework, kdump has the 
> facility to do /proc/vmcore and now it has to be re-done accordingly. There is 
> some code already done by Eric to do it in user-space. We are evaluating both
> the approaches and should arrive at the conclusion asap.

Do you have a pointer to your user space kdump stuff?  I have never
seen it.

How to configure this and the usability issues are interesting.  There is
no fundamental reason the code needs to live in a ramdisk.  We are back
in a fully functional kernel after all.  In this case a
ramdisk/initramfs is useful for the same reason a ramdisk with a 
rescue disk is useful.  It is possible the normal root filesystem is
corrupt.   A ramdisk allows you to have a known good copy of your
tools.

Eric
