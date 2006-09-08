Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWIHLFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWIHLFP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 07:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWIHLFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 07:05:15 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:19115 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750796AbWIHLFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 07:05:12 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] proc: Make the generation of the self symlink table driven.
References: <m1odttx8uz.fsf@ebiederm.dsl.xmission.com>
	<20060907101512.3e3a9604.akpm@osdl.org>
	<Pine.LNX.4.61.0609080906380.22545@yvahk01.tjqt.qr>
Date: Fri, 08 Sep 2006 05:04:19 -0600
In-Reply-To: <Pine.LNX.4.61.0609080906380.22545@yvahk01.tjqt.qr> (Jan
	Engelhardt's message of "Fri, 8 Sep 2006 09:07:01 +0200 (MEST)")
Message-ID: <m11wqmmxfw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

>>> +static struct pid_entry proc_base_stuff[] = {
>>> +	NOD(PROC_TGID_INO, 	"self", S_IFLNK|S_IRWXUGO,
>>> +		&proc_self_inode_operations, NULL, {}),
>>> +	{}
>>> +};
>>
>>We could save a bunch of bytes here.
>>
>>> +	/* Lookup the directory entry */
>>> +	for (p = proc_base_stuff; p->name; p++) {
>>
>>By using ARRAY_SIZE here.
>>
>>> +	for (; nr < (ARRAY_SIZE(proc_base_stuff) - 1); filp->f_pos++, nr++) {
>>
>>like that does.
>
> Also works without the () around ARRAY_SIZE(..)-1

Sure.  But I don't really trust C precedence (because it is wrong)
and having to remember where it is wrong sucks.  Plus in this
case I really am making it clear that ARRAY_SIZE(..)-1 is the concept
I want.   If there would any more to the expression that would
be important.

Eric
