Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWGLMHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWGLMHI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 08:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWGLMHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 08:07:08 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:53657 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751162AbWGLMHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 08:07:06 -0400
Subject: Re: [SYSFS] Kernel Null pointer dereference in sysfs_readdir()
From: Steven Rostedt <rostedt@goodmis.org>
To: "Duetsch, Thomas  LDE1" <thomas.duetsch@siemens.com>
Cc: linux-kernel@vger.kernel.org, maneesh@in.ibm.com, mingo@elte.hu
In-Reply-To: <5B0042046ADE774687F32BF3652F5BB9021C9190@kher9eaa.ww007.siemens.net>
References: <5B0042046ADE774687F32BF3652F5BB9021C9190@kher9eaa.ww007.siemens.net>
Content-Type: text/plain
Date: Wed, 12 Jul 2006 08:06:45 -0400
Message-Id: <1152706005.8309.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-12 at 13:35 +0200, Duetsch, Thomas LDE1 wrote:
> Hi,
> 
> I'm currently working on a custom kernel based on Ingo's -rt patch
> (2.6.16-rt29).
> 
> While rebooting my machine, I came across a kernel null pointer
> dereference in this code segment in fs/sysfs/dir.c, function
> sysfs_readdir():
> 
> 		for (p=q->next; p!= &parent_sd->s_children; p=p->next) {
> 			struct sysfs_dirent *next;
> 			const char * name;
> 			int len;
> 
> 			next = list_entry(p, struct sysfs_dirent,
> 					   s_sibling);
> 			if (!next->s_element)
> 				continue;
> 
> 			name = sysfs_get_name(next);
> 			len = strlen(name);
> 			if (next->s_dentry)
> PROBLEM ->			ino = next->s_dentry->d_inode->i_ino;
> 			else
> 				ino = iunique(sysfs_sb, 2);
> 

Hi Thomas,

Do you have a backtrace to look at? It might be helpful to see what
functions brought us to this point. Also it might help to determine if
the problem is vanilla, -rt, or the custom kernel.

Thanks,

-- Steve


