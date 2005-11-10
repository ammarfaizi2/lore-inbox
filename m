Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbVKJT75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbVKJT75 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 14:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbVKJT75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 14:59:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:223 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751217AbVKJT74 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 14:59:56 -0500
Date: Thu, 10 Nov 2005 11:59:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arun Sharma <arun.sharma@google.com>
Cc: rohit.seth@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Expose SHM_HUGETLB in shmctl(id, IPC_STAT, ...)
Message-Id: <20051110115941.1cbe1ae7.akpm@osdl.org>
In-Reply-To: <43739302.1080404@google.com>
References: <20051109184623.GA21636@sharma-home.net>
	<20051109222223.538309e4.akpm@osdl.org>
	<43739302.1080404@google.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arun Sharma <arun.sharma@google.com> wrote:
>
> Andrew Morton wrote:
> 
> >> +	shp->shm_flags = (shmflg & (S_IRWXUGO | SHM_HUGETLB));
> > [...]
> > I dunno.  The manpage says:
> > 
> >        The highlighted fields in the member shm_perm can be set:
> > 
> >            struct ipc_perm {
> >        ...
> >                ushort mode;  /* lower 9 bits of access modes */
> >        ...
> >            };
> > 
> > So if an application used to do:
> > 
> > 	if (perm.mode == 0666)
> > 
> > it will now break, because we've gone and set bit 9 on hugetlb segments.
> 
> The man page on my system says:
> 
>                unsigned short mode;  /* Permissions + SHM_DEST and
>                                          SHM_LOCKED flags */
> 
> I looked for a precendent before sending the patch and thought that 
> SHM_LOCKED was a good one.
> 

hm, OK.   But an app could still do

	if (mode == 0666|SHM_LOCKED)


How important is this feature?
