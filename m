Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965121AbWHOSzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121AbWHOSzk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965174AbWHOSzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:55:40 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:43749 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965121AbWHOSzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:55:39 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Containers <containers@lists.osdl.org>, dave@sr71.net
Subject: Re: [PATCH 2/7] proc: Modify proc_pident_lookup to be completely table driven.
References: <m1u04d98wa.fsf@ebiederm.dsl.xmission.com>
	<11556651312499-git-send-email-ebiederm@xmission.com>
	<1155666711.12700.54.camel@localhost.localdomain>
Date: Tue, 15 Aug 2006 12:55:17 -0600
In-Reply-To: <1155666711.12700.54.camel@localhost.localdomain> (Dave Hansen's
	message of "Tue, 15 Aug 2006 11:31:51 -0700")
Message-ID: <m1y7tp7rsa.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> On Tue, 2006-08-15 at 12:05 -0600, Eric W. Biederman wrote:
>> Currently proc_pident_lookup gets the names and types from a table
>> and then has a huge switch statement to get the inode and file
>> operations it needs.  That is silly and is becoming increasingly hard
>> to maintain so I just put all of the information in the table.
>
> Looks pretty reasonable.
>
>> +#define INF(TYPE, NAME, MODE, OTYPE)                   \
>> +       NOD(TYPE, NAME, (S_IFREG|(MODE)),               \
>> +               NULL, &proc_info_file_operations,       \
>> +               { .proc_read = &proc_##OTYPE } )
> ...
>> +       INF(PROC_TID_OOM_SCORE,  "oom_score", S_IRUGO, oom_score),
>> +       REG(PROC_TID_OOM_ADJUST, "oom_adj",   S_IRUGO|S_IWUSR, oom_adjust),
>
> Could we give these some slightly more intuitive names?  INF is a bit
> terse ;)

> Since these #defines and function are also all in base.c, and not
> referenced elsewhere, might it be reasonable to take some of the PROC_
> headers off of them?  I know I've been frustrated more than once by
> popping things like "oom_score" in to cscope and finding no definitions.

So as for taking the proc_ prefix off I don't see a real problem with
that but that should really be a different increment patch.  Although removing
a little magic from my macros might be reasonable.

The only macro whose name really seems to terse is INF short for info,
so adding the O would be ok.  What I would really like to see however
is all of these proc info things just go away.  I seem to recall
they all have some pretty weird corner cases and a seq file implementation
is probably better there.

The other half of this is that I would very much like to see some of
these things moved out of base.c

Eric
