Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262107AbUKBRTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbUKBRTV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 12:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbUKBRTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 12:19:10 -0500
Received: from smtpout.mac.com ([17.250.248.44]:211 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262137AbUKBRSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 12:18:14 -0500
In-Reply-To: <20041102135220.GA20237@elte.hu>
References: <41871BA7.6070300@kolivas.org> <20041102125218.GH15290@elte.hu> <4187854C.6000803@kolivas.org> <20041102131105.GA17535@elte.hu> <41878E47.5090805@kolivas.org> <20041102135220.GA20237@elte.hu>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <23FAF546-2CF3-11D9-857E-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] optional non-interactive mode for cpu scheduler
Date: Tue, 2 Nov 2004 12:17:57 -0500
To: Ingo Molnar <mingo@elte.hu>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 02, 2004, at 08:52, Ingo Molnar wrote:
> One exception would be CPU-bound code with multiple threads which
> interact with each other - one always runs but the others always sleep.
> A possible solution would be to exclude all inter-task synchronization
> methods from the 'interactivity boost' and only hard-device-waits would
> be considered true 'waiting', such as keyboard, mouse, disk or network
> IO.

Alternatively, you might try a system where each "hard-device-wait"
gets a specific interactivity rating, the default would be 1.0, but one
could specify that /dev/input/mice gets a rating of 10.0.  Then when
handling inter-process communication, a wait on IPC connected to
some local program would cause a change in interactivity rating
based on the current interactivity of the other process. EX:

gpm waits on /dev/input/mice, gets a high interactivity rating.
X waits on /dev/gpmdata, gets a lesser but still significant rating.

This clearly has some flaws, but it may be useful in some scenarios.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


