Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262780AbTDNGcm (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 02:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262785AbTDNGcm (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 02:32:42 -0400
Received: from coffee.Psychology.mcmaster.ca ([130.113.218.59]:23684 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id S262780AbTDNGcl (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 02:32:41 -0400
Date: Mon, 14 Apr 2003 02:44:30 -0400 (EDT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: hahn@coffee.psychology.mcmaster.ca
To: linux-kernel@vger.kernel.org
Subject: Re: Benefits from computing physical IDE disk geometry?
In-Reply-To: <3E9A308D.4060705@cyberone.com.au>
Message-ID: <Pine.LNX.4.44.0304140244020.7922-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>The benefit I see is knowing the seek time itself (not geometry), which
> >>can be used to tune the IO scheduler. This is something that I'll

but seek time is some combination of headswitch time, rotational 
latency, and actual head motion.  the first three are basically
not accessible in any practical way.  the latter is easy, and the 
current approximation (seek time is a linear function of block distance)
is very reasonable.

adjusting the cost function would be interesting: I'm guessing that 
handling short seeks (which are quite fast) would be more important
than adjusting for zones.  given that the current queueing code 
handles starvation, I wonder if we could actually permit backward
seeks of, say, 0-2 cylinders.

> Well using the assumption that |head sector - target sector| gives
> an ordering correstponding to seek time, we do sort the queue optimally.
> I personally feel that being trickier than that is too much complexity.

exactly.

