Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266034AbUIIQbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbUIIQbg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 12:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266218AbUIIQbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 12:31:35 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:43952 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S266034AbUIIQbC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 12:31:02 -0400
Subject: Re: [patch] update: _working_ code to add device+inode check to
	ipt_owner.c
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040909162200.GB9456@lkcl.net>
References: <20040909162200.GB9456@lkcl.net>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1094747347.22014.94.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 09 Sep 2004 12:29:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-09 at 12:22, Luke Kenneth Casson Leighton wrote:
> 	i do not believe it to be sensible to have the kernel
> 	code doing that kind of checking (resolving the full
> 	pathname of an executable) but hey, if anyone feels
> 	otherwise, and knows of some pre-existing code to point
> 	me in the direction of, i'll add it, because it might
> 	be easier in the long run.
<snip>
> 	has someone already done this before now, and if so,
> 	where?

d_path() will give you a pathname given a (dentry, vfsmount) pair.

> 	because it's the kind of code that would be extremely
> 	useful to have in selinux auditing.
> 
> 	the selinux auditing log messages only presently include
> 	the name of the file (not the fully qualified path) and
> 	things like "error access denied to a local directory
> 	named "lib" isn't exactly very helpful!)

SELinux already uses d_path when it can when generating audit messages
(but always includes device and inode information); try reading the
code.  But a vfsmount is often not available to it at the point of a
permission check.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

