Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbUKBJlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbUKBJlK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 04:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265491AbUKBJdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 04:33:19 -0500
Received: from ozlabs.org ([203.10.76.45]:63897 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264272AbUKBJck (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 04:32:40 -0500
Subject: Re: [PATCH] [CPU-HOTPLUG] convert cpucontrol to be a rwsem
From: Rusty Russell <rusty@rustcorp.com.au>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1099332277.3647.43.camel@krustophenia.net>
References: <20041101084337.GA7824@dominikbrodowski.de>
	 <Pine.LNX.4.61.0411010656380.19123@musoma.fsmlabs.com>
	 <1099332277.3647.43.camel@krustophenia.net>
Content-Type: text/plain
Date: Tue, 02 Nov 2004 10:48:23 +1100
Message-Id: <1099352903.20402.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-01 at 13:04 -0500, Lee Revell wrote:
> On Mon, 2004-11-01 at 07:00 -0700, Zwane Mwaikambo wrote:
> > Agreed it makes a lot more sense, i think there could be some places where 
> > we use preempt_disable to protect against cpu offline which could 
> > converted, but that can come later.
> > 
> 
> You know I picked up Robert Love's book the other day and was surprised
> to read we are not supposed to be using preempt_disable, there is a
> per_cpu interface for exactly this kind of thing.  Which is currently
> recommended?

get_cpu() both ensures that this CPU won't go down, and ensures we won't
get scheduled off it.  It returns the current processor ID, as well.
put_cpu() puts the CPU back.

In my experience it's usually clearer than preempt_disable().

Cheers,
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

