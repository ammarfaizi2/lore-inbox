Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbUAVBNO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 20:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264289AbUAVBNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 20:13:14 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:52949 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S264286AbUAVBNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 20:13:13 -0500
Date: Wed, 21 Jan 2004 20:13:11 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Pavel Machek <pavel@ucw.cz>
cc: Valdis.Kletnieks@vt.edu, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: sched-idle and disk-priorities for 2.6.X
In-Reply-To: <20040122010438.GD223@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0401212010520.15146-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jan 2004, Pavel Machek wrote:

> doing 
> 
> ulimit -m 1
> <some task>
> 
> should make that task run with extremely low priority, right?

Yeah, when the box is under memory pressure, pages from that
task should never hit the active list.  Instead, they should
always stay on the inactive list and the non-referenced pages
from that app should get reclaimed.

OTOH, if the app keeps referencing all pages, maybe I need
to tune up the aggressiveness a bit and also reclaim the
referenced pages ... if the current patch doesn't work right
I'll make a more aggressive one.

Note that RSS limit enforcement is always lazy, because
otherwise the RSS limited task will hog the IO subsystem
full-time and slow everything else down ... even when there's
more than enough memory.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

