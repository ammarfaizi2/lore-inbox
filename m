Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265581AbSKOC0g>; Thu, 14 Nov 2002 21:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265587AbSKOC0g>; Thu, 14 Nov 2002 21:26:36 -0500
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:33702
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S265581AbSKOC0f>; Thu, 14 Nov 2002 21:26:35 -0500
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200211150233.gAF2XQv15588@www.hockin.org>
Subject: Re: [BK PATCH 1/2] Remove NGROUPS hardlimit (resend w/o qsort)
To: akpm@digeo.com (Andrew Morton)
Date: Thu, 14 Nov 2002 18:33:26 -0800 (PST)
Cc: thockin@sun.com (Tim Hockin),
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <3DD44E39.4703C2DA@digeo.com> from "Andrew Morton" at Nov 14, 2002 05:30:33 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 10,000 bits isn't much.  Maybe:

That's 10000 USED bits.  Remember groups are non-contiguously allocated.  If
a task is a member of just groups 32767 and 65535, you'll get one bit per
page used, and when they call getgroups() you need to pull it apart and
return an array of gid_t.

> - add `char groups[16]' to task_struct
> 
> - add `struct page *groups_page' to task_struct
> 
> - then
> 	if (getsetsize <= 256)
> 		use current->groups[]		/* 256 groups max */
> 	else
> 		use current->groups_page;	/* 32768 groups max */
