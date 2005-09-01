Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965183AbVIATbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965183AbVIATbz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 15:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965182AbVIATbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 15:31:55 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:12236 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965183AbVIATbz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 15:31:55 -0400
Date: Thu, 1 Sep 2005 20:32:01 +0100
From: viro@ZenIV.linux.org.uk
To: Corey Minyard <minyard@acm.org>
Cc: Matt_Domsch@Dell.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][CFLART] ipmi procfs bogosity
Message-ID: <20050901193201.GD26264@ZenIV.linux.org.uk>
References: <20050901064313.GB26264@ZenIV.linux.org.uk> <1125592902.27283.5.camel@i2.minyard.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125592902.27283.5.camel@i2.minyard.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 11:41:42AM -0500, Corey Minyard wrote:
> Indeed, this function is badly written.  In rewriting, I couldn't find a
> nice function for reading integers from userspace, and the proc_dointvec
> stuff didn't seem terribly suitable.  So I wrote my own general
> function, which I can move someplace else if someone likes.  Patch is
> attached.  It should not affect correct usage of this file.

Eeeek...  Much, _much_ simpler approach would be to have

	char buf[10];
	if (count > 9)
		return -EINVAL;
	if (copy_from_user(buf, buffer, count))
		return -EFAULT;
	buf[count] = '\0';
	/* use sscanf() or anything normal */

Would that change behaviour in any cases you care about?
