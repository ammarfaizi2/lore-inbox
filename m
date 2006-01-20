Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWATQOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWATQOf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 11:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbWATQOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 11:14:35 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:29676 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750977AbWATQOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 11:14:34 -0500
Date: Fri, 20 Jan 2006 10:14:21 -0600 (CST)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, jes@sgi.com,
       tony.luck@intel.com
Subject: Re: [PATCH] SN2 user-MMIO CPU migration
In-Reply-To: <20060120083651.GA3970@elte.hu>
Message-ID: <20060120101221.R91550@chenjesu.americas.sgi.com>
References: <20060118163305.Y42462@chenjesu.americas.sgi.com>
 <20060120083651.GA3970@elte.hu>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2006, Ingo Molnar wrote:

> hm, why isnt the synchronization done in switch_to()? Your arch-level 
> switch_to() could have something like thread->last_cpu_sync, and if 
> thread->last_cpu_sync != this_cpu, do the flush. This would not only 
> keep this stuff out of the generic scheduler, but it would also optimize 
> things a bit more: the moment we do a set_task_cpu() it does not mean 
> that CPU _will_ run the task. Another CPU could grab that task later on.  

Very good points all around.  I'll rework the changes in just the
manner you mentioned.

Brent

-- 
Brent Casavant                          All music is folk music.  I ain't
bcasavan@sgi.com                        never heard a horse sing a song.
Silicon Graphics, Inc.                    -- Louis Armstrong
