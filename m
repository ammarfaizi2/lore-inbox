Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267541AbUG3ADM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267541AbUG3ADM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 20:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUG3ABu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 20:01:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54145 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267544AbUG3AAR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 20:00:17 -0400
Date: Fri, 30 Jul 2004 01:00:14 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrew Morton <akpm@osdl.org>
Cc: Jan Blunck <j.blunck@tu-harburg.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext2_readdir() filp->f_pos fix
Message-ID: <20040730000014.GL12308@parcelfarce.linux.theplanet.co.uk>
References: <41094D69.9030008@tu-harburg.de> <20040729154625.0a6f48a3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040729154625.0a6f48a3.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 03:46:25PM -0700, Andrew Morton wrote:
> If the filldir() call returns non-zero your patch will leave f_pos pointing at
> the problematic directory entry.  I'm not sure whether this is desirable.
> 
> hmm, ext2_readir() isn't propagating EFAULT back up to the caller.

filldir callback does that.  Please, read through fs/readdir.c and take
a look at the way error value is generated.

Return value of filldir has only one meaning - should we stop or should
we go on.  It's boolean, not an error value.

Errors are stored in data we are passing to filldir and picked by caller
of vfs_readdir() once it's done.
