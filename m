Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264991AbTFQWqL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 18:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264992AbTFQWqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 18:46:11 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:21680 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264991AbTFQWqJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 18:46:09 -0400
Subject: Re: borked sysfs system devices in 2.5.72
From: Dave Hansen <haveblue@us.ibm.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Dobson <colpatch@us.ibm.com>
In-Reply-To: <Pine.LNX.4.44.0306171551261.908-100000@cherise>
References: <Pine.LNX.4.44.0306171551261.908-100000@cherise>
Content-Type: text/plain
Organization: 
Message-Id: <1055890701.24452.15.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Jun 2003 15:58:21 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-17 at 15:54, Patrick Mochel wrote:
> > Look in subsys_attr_show().  It is being passed a kobject, which is a
> > member of a "struct sys_device".  We can tell this because I printed out
> > the address of the sys device in sys_device_register().  A to_subsys()
> > is being performed on that object, which is wrong, because the kobject
> > is not a member of a "struct subsystem".
> 
> My question was how the hell it was getting there in the first place, and 
> I see that the type of the object isn't getting set properly, so it 
> defaults to treat it as a struct subsystem. 

Stack dump from si_meminfo_node():
Call Trace:
 [<c0133f39>] si_meminfo_node+0x4d/0x54
 [<c02029ac>] node_read_meminfo+0x1c/0x80
 [<c013385a>] __alloc_pages+0x82/0x2b4
 [<c011c8fb>] release_console_sem+0x9b/0xa4
 [<c0175ead>] subsys_attr_show+0x1d/0x28
 [<c0175f7a>] fill_read_buffer+0x96/0xb4
 [<c01ebf5e>] opost_block+0x18e/0x19c
 [<c01eed92>] pty_write+0x156/0x168
 [<c0154d8c>] do_lookup+0x18/0x8c
 [<c0151a2f>] cp_new_stat64+0xe7/0x100
 [<c017604b>] sysfs_read_file+0x1b/0x3c
 [<c014960c>] vfs_read+0x9c/0xcc
 [<c01497ed>] sys_read+0x31/0x4c
 [<c0108bd7>] syscall_call+0x7/0xb


> Could you please try the following patch, and let me know if it works? 

That fixed it, thanks.  

-- 
Dave Hansen
haveblue@us.ibm.com

