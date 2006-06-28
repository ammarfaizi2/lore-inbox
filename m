Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422929AbWF1CkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422929AbWF1CkY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 22:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422930AbWF1CkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 22:40:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5290 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422929AbWF1CkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 22:40:23 -0400
Date: Tue, 27 Jun 2006 19:40:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, herbert@13thfloor.at, viro@ftp.linux.org.uk,
       serue@us.ibm.com, haveblue@us.ibm.com
Subject: Re: [PATCH 19/20] elevate writer count for custom 'struct file'
Message-Id: <20060627194011.d485c0ec.akpm@osdl.org>
In-Reply-To: <20060627221456.F6AD6304@localhost.localdomain>
References: <20060627221436.77CCB048@localhost.localdomain>
	<20060627221456.F6AD6304@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2006 15:14:56 -0700
Dave Hansen <haveblue@us.ibm.com> wrote:

> Some filesystems forego the vfs and may_open() and create their
> own 'struct file's.  Any of these users which set the write flag
> on the file will cause an extra mnt_drop_write() on __fput(),
> thus dropping the reference count too low.
> 
> These users tend to have artifical in-kernel vfsmounts which
> aren't really exposed to userspace and can't be remounted, but
> this patch is included for completeness and so that the warnings
> don't trip over these cases.

Does the fake_file in fs/block_dev.c need similar treatment?
