Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272533AbTGaPWG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 11:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272501AbTGaPUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 11:20:24 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:34957 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S272504AbTGaPT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 11:19:28 -0400
Date: Thu, 31 Jul 2003 08:19:01 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test2-mm1 results
Message-ID: <59900000.1059664740@[10.10.2.4]>
In-Reply-To: <200308010113.02866.kernel@kolivas.org>
References: <5110000.1059489420@[10.10.2.4]> <200307310128.50189.kernel@kolivas.org> <58530000.1059663364@[10.10.2.4]> <200308010113.02866.kernel@kolivas.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Does this help interactivity a lot, or was it just an experiment?
>> Perhaps it could be less agressive or something?
> 
> Well basically this is a side effect of selecting out the correct cpu hogs in 
> the interactivity estimator. It seems to be working ;-) The more cpu hogs 
> they are the lower dynamic priority (higher number) they get, and the more 
> likely they are to be removed from the active array if they use up their full 
> timeslice. The scheduler in it's current form costs more to resurrect things 
> from the expired array and restart them, and the cpu hogs will have to wait 
> till other less cpu hogging tasks run. 
> 
> How do we get around this? I'll be brave here and say I'm not sure we need to, 
> as cpu hogs have a knack of slowing things down for everyone, and it is best 
> not just for interactivity for this to happen, but for fairness.
> 
> I suspect a lot of people will have something to say on this one...

Well, what you want to do is prioritise interactive tasks over cpu hogs.
What *seems* to be happening is you're just switching between cpu hogs
more ... that doesn't help anyone really. I don't have an easy answer
for how to fix that, but it doesn't seem desireable to me - we need some
better way of working out what's interactive, and what's not.

M.

