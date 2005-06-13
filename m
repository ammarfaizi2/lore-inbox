Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVFMDkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVFMDkA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 23:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVFMDkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 23:40:00 -0400
Received: from mail.dvmed.net ([216.237.124.58]:60129 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261346AbVFMDja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 23:39:30 -0400
Message-ID: <42ACFFED.9050701@pobox.com>
Date: Sun, 12 Jun 2005 23:39:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kallol@nucleodyne.com
CC: Mark Lord <liml@rtr.ca>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: Fwd: Re: Performance figure for sx8 driver
References: <20050611021814.riaatwh8ztskw4g4@www.nucleodyne.com>	 <42AC6310.7030809@rtr.ca> <1118598197.25250.20.camel@driver>
In-Reply-To: <1118598197.25250.20.camel@driver>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kallol Biswas wrote:
> I have been investigating what the cause of performance loss could be.
> 
> I have noticed several things:
> 
> 0) Setting to CARM_MAX_Q to 30 hangs. So we have been testing only with
> CARM_MAX_Q == 1. The firmware has not been updated yet.

Note that CARM_MAX_Q controls the --host-- queue.

This means that, with CARM_MAX_Q==1, only one command can be sent to 
--any-- disk, at a time.  disks 1-7 must wait for disk 0 to complete an 
I/O, and so on.  Each command is host-synchronous.

As such, this limits multi-disk performance quite severely, but does not 
hamper single disk performance.

CARM_MAX_Q==1 is set as such (as mentioned earlier in the thread) 
because early firmwares would lock up if that value was increased.

It has been reported that newer firmwares work fine with CARM_MAX_Q==30, 
which completely eliminates the host-synchronous condition.

	Jeff


