Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265435AbRF0WlR>; Wed, 27 Jun 2001 18:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265438AbRF0WlG>; Wed, 27 Jun 2001 18:41:06 -0400
Received: from gateway.sequent.com ([192.148.1.10]:1292 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S265435AbRF0Wku>; Wed, 27 Jun 2001 18:40:50 -0400
Date: Wed, 27 Jun 2001 15:40:36 -0700
From: Mike Kravetz <mkravetz@sequent.com>
To: Scott Long <scott@swiftview.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: wake_up vs. wake_up_sync
Message-ID: <20010627154036.E1135@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <3B3A4E8B.E4301909@colorfullife.com> <3B3A56D7.90544D15@swiftview.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B3A56D7.90544D15@swiftview.com>; from scott@swiftview.com on Wed, Jun 27, 2001 at 02:57:43PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2001 at 02:57:43PM -0700, Scott Long wrote:
> Does reschedule_idle() ever cause the current CPU to get scheduled? That
> is, if someone calls wake_up() and wakes up a higher-priority process
> could reschedule_idle() potentially immediately switch the current CPU
> to that higher-priority process?

No.  reschedule_idle() never directly performs a 'task to task' context
switch itself.  Instead, it simply marks a currently running task to
indicate that a reschedule is needed on that task's CPU.  No task context
switch will occur until schedule() is run on that CPU.

-- 
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
