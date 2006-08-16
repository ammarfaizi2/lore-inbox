Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWHPRs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWHPRs7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 13:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWHPRs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 13:48:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49633 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751230AbWHPRs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 13:48:58 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, containers@lists.osdl.org,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [PATCH 5/7] pid: Implement pid_nr
References: <m1k65997xk.fsf@ebiederm.dsl.xmission.com>
	<1155666193751-git-send-email-ebiederm@xmission.com>
	<1155667063.12700.56.camel@localhost.localdomain>
	<Pine.LNX.4.61.0608161826580.23266@yvahk01.tjqt.qr>
Date: Wed, 16 Aug 2006 11:48:25 -0600
In-Reply-To: <Pine.LNX.4.61.0608161826580.23266@yvahk01.tjqt.qr> (Jan
	Engelhardt's message of "Wed, 16 Aug 2006 18:27:18 +0200 (MEST)")
Message-ID: <m1veos1sie.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

>>> +static inline pid_t pid_nr(struct pid *pid)
>>> +{
>>> +       pid_t nr = 0;
>>> +       if (pid)
>>> +               nr = pid->nr;
>>> +       return nr;
>>> +} 
>>
>>When is it valid to be passing around a NULL 'struct pid *'?
>
> Is 0 even the right thing to return in the rare case that pid == NULL?
> -1 maybe?

I believe 0 is what we have used elsewhere.

A negative value for a pid is likely to be taken as the group of all
processes, or -EPERM, and it does really confusing things when fed through
the current f_getown implementation, with PIDTYPE_PGRP.

The only other possible interpretations of 0 are the idle process and
yourself.  There is still some potential there, but largely 0 is much
less likely to be confused than -1.  Especially as it doesn't change
when you negate it.

Eric
