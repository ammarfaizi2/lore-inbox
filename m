Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbTKUWlM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 17:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbTKUWlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 17:41:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:1958 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261575AbTKUWlK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 17:41:10 -0500
Date: Fri, 21 Nov 2003 14:46:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org, zwane@arm.linux.org.uk,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] better locking in fs/proc/generic.c (bug 1552)
Message-Id: <20031121144630.018aee48.akpm@osdl.org>
In-Reply-To: <3FBE92D2.7080300@austin.ibm.com>
References: <3FBE92D2.7080300@austin.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Lynch <nathanl@austin.ibm.com> wrote:
>
> Hi-
> 
> I have been experiencing various oopses in the procfs code when rapidly 
> adding and removing /proc entries.

I doubt if this particularly surprises anyone.

>  It seems that the main problem is 
> lack of proper locking around code that traverses or modifies the 
> proc_dir_entry tree.  There is also the matter of proc_kill_inodes() 
> clearing the file pointer's f_op, which caused oopses in vfs_read() in 
> my testing.
> 
> I have followed the example of proc_lookup() and used 
> lock_kernel/unlock_kernel around critical sections.  I'm not much of a 
> filesystem person, so I would appreciate a review of the patch from 
> folks more knowledgeable.  I have been testing the code on a couple of 
> dual processor machines (i386 and ppc64) without incident.

The correct lock to use is i_sem on the directory which is subject to
lookup.

> Please see http://bugme.osdl.org/show_bug.cgi?id=1552 for oops traces 
> and a testcase.  Andrew posted a one-liner patch there which was 
> included in mm4 which is also needed.

gargh, I was waiting to hear back on that patch, and there it is.  Durned
bugzilla.  Thanks.
