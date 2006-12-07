Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163395AbWLGVZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163395AbWLGVZU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 16:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163396AbWLGVZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 16:25:20 -0500
Received: from zrtps0kn.nortel.com ([47.140.192.55]:37378 "EHLO
	zrtps0kn.nortel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163395AbWLGVZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 16:25:19 -0500
Message-ID: <457886B4.2030507@nortel.com>
Date: Thu, 07 Dec 2006 15:25:08 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: additional oom-killer tuneable worth submitting?
References: <45785DDD.3000503@nortel.com> <9a8748490612071050q60b378c4ldf039140ffd721be@mail.gmail.com>
In-Reply-To: <9a8748490612071050q60b378c4ldf039140ffd721be@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Dec 2006 21:25:19.0843 (UTC) FILETIME=[325E6B30:01C71A46]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:

> How does "oomthresh" and "oomadj" affect each other?

If memory consumption is less than "oomthresh", that process is simply 
bypassed.  (Equivalent to oomkilladj==OOM_DISABLE.)  Otherwise, continue 
processing as normal.

> Default "oomthresh" value for a new process is 0 (zero) I assume -
> right?  If not, then I'd suggest that it should be.

Correct.

> What happens when a process fork()s? Does the child enherit the
> parents "oomthresh" value?

Currently it does not.  This is to allow for different memory access 
patterns by parent/child.  And exec() wipes it as well.

> Would it make sense to make "oomthresh" apply to process groups
> instead of processes?

Hmm...it might make sense given that the point of the group is to manage 
tasks together...but it would make accounting more tricky.  Currently 
it's just a very simple comparison of p->mm->total_vm against the 
threshold in badness().

> What happens in the case where the OOM killer really, really needs to
> kill one or more processes since there is not a single drop of memory
> available, but all processes are below their configured thresholds?

Then the system wasn't properly engineered.  <grin>

In this case you reboot.

Chris
