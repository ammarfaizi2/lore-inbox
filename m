Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWFRLez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWFRLez (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 07:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWFRLez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 07:34:55 -0400
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:8677 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751170AbWFRLey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 07:34:54 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Juho Saarikko <juhos@mbnet.fi>
Subject: Re: [ck] [ckpatch][8/29] track_mutexes-1.patch
Date: Sun, 18 Jun 2006 21:34:35 +1000
User-Agent: KMail/1.9.3
Cc: linux list <linux-kernel@vger.kernel.org>, ck list <ck@vds.kolivas.org>
References: <200606181731.14664.kernel@kolivas.org> <1150630103.9668.4.camel@a88-112-69-25.elisa-laajakaista.fi>
In-Reply-To: <1150630103.9668.4.camel@a88-112-69-25.elisa-laajakaista.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606182134.35520.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 June 2006 21:28, Juho Saarikko wrote:
> On Sun, 2006-06-18 at 10:31, Con Kolivas wrote:
> > Keep a record of how many mutexes are held by any task. This allows cpu
> > scheduler code to use this information in decision making for tasks that
> > hold contended resources.
>
> So, if I'm an userspace application trying to overcome nice or
> scheduling class limitations, I can simply create a lot of mutexes, lock
> them all, and get better scheduling ?-)
>
> A better way would be to track what task holds what mutex, and when some
> task tries to lock an already locked one, temporarily elevate the task
> holding the mutex to the priority of the highest priority task blocking
> on it (if higher than what the holding task already has, of course).
> Then return the task to normal when it unlocks the mutex.
>
> This might be more trouble and cost more overhead than it's worth, but
> in theory, it would be a supreme system.

No you misunderstand why I use it here. I am not doing priority inheritance at 
all; that comes with all sorts of risks and complexities. This is done purely 
to prevent SCHED_IDLEPRIO tasks from grabbing a mutex and then never getting 
scheduled due to IDLEPRIO semantics while another task is effectively starved 
waiting on that mutex. It is used in -ck only to convert SCHED_IDLEPRIO tasks 
to nice 19 SCHED_NORMAL tasks while they're holding mutexes to do this.

-- 
-ck
