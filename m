Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030449AbWHOScO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030449AbWHOScO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030450AbWHOScO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:32:14 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:50405 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030449AbWHOScN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:32:13 -0400
Subject: Re: [PATCH 2/7] proc: Modify proc_pident_lookup to be completely
	table driven.
From: Dave Hansen <haveblue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Containers <containers@lists.osdl.org>, dave@sr71.net
In-Reply-To: <11556651312499-git-send-email-ebiederm@xmission.com>
References: <m1u04d98wa.fsf@ebiederm.dsl.xmission.com>
	 <11556651312499-git-send-email-ebiederm@xmission.com>
Content-Type: text/plain
Date: Tue, 15 Aug 2006 11:31:51 -0700
Message-Id: <1155666711.12700.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-15 at 12:05 -0600, Eric W. Biederman wrote:
> Currently proc_pident_lookup gets the names and types from a table
> and then has a huge switch statement to get the inode and file
> operations it needs.  That is silly and is becoming increasingly hard
> to maintain so I just put all of the information in the table.

Looks pretty reasonable.

> +#define INF(TYPE, NAME, MODE, OTYPE)                   \
> +       NOD(TYPE, NAME, (S_IFREG|(MODE)),               \
> +               NULL, &proc_info_file_operations,       \
> +               { .proc_read = &proc_##OTYPE } )
...
> +       INF(PROC_TID_OOM_SCORE,  "oom_score", S_IRUGO, oom_score),
> +       REG(PROC_TID_OOM_ADJUST, "oom_adj",   S_IRUGO|S_IWUSR, oom_adjust),

Could we give these some slightly more intuitive names?  INF is a bit
terse ;)

Since these #defines and function are also all in base.c, and not
referenced elsewhere, might it be reasonable to take some of the PROC_
headers off of them?  I know I've been frustrated more than once by
popping things like "oom_score" in to cscope and finding no definitions.

-- Dave

