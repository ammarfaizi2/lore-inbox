Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965120AbWGKEBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965120AbWGKEBF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 00:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbWGKEBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 00:01:05 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:19642 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965120AbWGKEBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 00:01:04 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Allow /proc/sys without sys_sysctl
References: <m1u05pkruk.fsf@ebiederm.dsl.xmission.com>
	<20060710154849.cdfa74cd.rdunlap@xenotime.net>
Date: Mon, 10 Jul 2006 22:00:23 -0600
In-Reply-To: <20060710154849.cdfa74cd.rdunlap@xenotime.net> (Randy Dunlap's
	message of "Mon, 10 Jul 2006 15:48:49 -0700")
Message-ID: <m1zmfgkcyw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> writes:

> On Mon, 10 Jul 2006 16:38:59 -0600 Eric W. Biederman wrote:
>
>> 
>> Since sys_sysctl is deprecated start allow it to be compiled out.
>> This should catch any remaining user space code that cares,
>> and paves the way for further sysctl cleanups.
>
> Where is it documented and users notified that sys_sysctl is
> deprecated?  Sounds like it should be added to
> Documentation/feature-removal-schedule.txt.

The deprecation I believe actually predates feature-remove-schedule.txt

>From include/linux/sysctl.h
 
>  ****************************************************************
>  ****************************************************************
>  **
>  **  The values in this file are exported to user space via 
>  **  the sysctl() binary interface.  However this interface
>  **  is unstable and deprecated and will be removed in the future. 
>  **  For a stable interface use /proc/sys.
>  **
>  ****************************************************************
>  ****************************************************************

And I can't actually find any user space applications that continue
to use sys_sysctl.

So the combination of the two patches and makes the deprecation official,
and makes it a compile time option so we can disable sys_sysctl now,
but still have recourse if some parts of user space need the code.

Currently the we dup the internal helpers which makes maintenance
of the code a nightmare.

Eric



