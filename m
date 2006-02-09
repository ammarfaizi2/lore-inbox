Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWBIVcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWBIVcS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 16:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWBIVcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 16:32:18 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5039 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750800AbWBIVcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 16:32:17 -0500
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, oleg@tv-sign.ru, mm-commits@vger.kernel.org
Subject: Re: + fork-allow-init-to-become-a-session-leader.patch added to -mm
 tree
References: <200602082314.k18NEuN0017390@shell0.pdx.osdl.net>
	<Pine.LNX.4.62.0602081518580.5184@schroedinger.engr.sgi.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 09 Feb 2006 14:31:32 -0700
In-Reply-To: <Pine.LNX.4.62.0602081518580.5184@schroedinger.engr.sgi.com> (Christoph
 Lameter's message of "Wed, 8 Feb 2006 15:19:54 -0800 (PST)")
Message-ID: <m1lkwk1aob.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> writes:

> On Wed, 8 Feb 2006 akpm@osdl.org wrote:
>
>> +			if (unlikely(p->pid == 1)) {
>> +				p->signal->tty = NULL;
>> +				p->signal->leader = 1;
>> +				p->signal->pgrp = 1;
>> +				p->signal->session = 1;
>
> Would it not be better to do these special settings for init from 
> init itself?

So if you mean from within the kernel context that is doable,
so long as we only have one process with pid == 1.

Although we may be able fix the kernel limitations in setsid().

For multiple pid == 1 case I don't know of another place in
the kernel I can possibly put this.  I can't put it later
because there is no place later, and I can't put it earlier
or else my efforts would just get stomped.

So I did it this way so I don't have to come back and change it to
this next week.  I'd love to have a better place to put this
code.

Eric
