Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbTFLW5y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 18:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265056AbTFLW5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 18:57:53 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:48390 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265053AbTFLW5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 18:57:52 -0400
Date: Thu, 12 Jun 2003 16:07:40 -0700
From: Andrew Morton <akpm@digeo.com>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix vmtruncate race and distributed filesystem race
Message-Id: <20030612160740.27a57aca.akpm@digeo.com>
In-Reply-To: <184910000.1055458610@baldur.austin.ibm.com>
References: <133430000.1055448961@baldur.austin.ibm.com>
	<20030612134946.450e0f77.akpm@digeo.com>
	<20030612140014.32b7244d.akpm@digeo.com>
	<150040000.1055452098@baldur.austin.ibm.com>
	<20030612144418.49f75066.akpm@digeo.com>
	<184910000.1055458610@baldur.austin.ibm.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Jun 2003 23:11:38.0276 (UTC) FILETIME=[F9F08E40:01C33137]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken <dmccr@us.ibm.com> wrote:
>
> I also think if we can solve both the vmtruncate and the distributed file
> system races without adding any vm_ops, we should.
> 
> Here's a new patch.  Does this look better?

grumble, mutter.  It's certainly simple enough.

+	mapping = vma->vm_file->f_dentry->d_inode->i_mapping;

I'm not so sure about this one now.  write() alters dentry->d_inode but
truncate alters dentry->d_inode->i_mapping->host.  Unless truncate is
changed we have the wrong mapping here.

I'll put it back to the original while I try to work out why truncate isn't
wrong...

