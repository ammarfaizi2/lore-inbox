Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWJNALO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWJNALO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 20:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWJNALO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 20:11:14 -0400
Received: from gw.goop.org ([64.81.55.164]:59868 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932088AbWJNALM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 20:11:12 -0400
Message-ID: <45302BE0.7040400@goop.org>
Date: Fri, 13 Oct 2006 17:14:24 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
CC: John Richard Moser <nigelenki@comcast.net>,
       Chris Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
Subject: Re: Can context switches be faster?
References: <452E62F8.5010402@comcast.net> <452E9E47.8070306@nortel.com> <452EA441.6070703@comcast.net> <452EA700.9060009@goop.org> <20061013233238.GA6038@rhlx01.fht-esslingen.de>
In-Reply-To: <20061013233238.GA6038@rhlx01.fht-esslingen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Mohr wrote:
> OK, so since we've now amply worked out in this thread that TLB/cache flushing
> is a real problem for context switching management, would it be possible to
> smartly reorder processes on the runqueue (probably works best with many active
> processes with the same/similar priority on the runqueue!) to minimize
> TLB flushing needs due to less mm context differences of adjacently scheduled
> processes?
> (i.e. don't immediately switch from user process 1 to user process 2 and
> back to 1 again, but always try to sort some kernel threads in between
> to avoid excessive TLB flushing)
>   

It does.  The kernel will (slightly) prefer to switch between two 
threads sharing an address space over switching to a different address 
space.  (Hm, at least it used to, but I can't see where that happens now.)

    J
