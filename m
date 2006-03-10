Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751566AbWCJQjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbWCJQjR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 11:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWCJQjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 11:39:17 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:46212 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1751455AbWCJQjQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 11:39:16 -0500
Message-ID: <4411AB4D.1030008@cfl.rr.com>
Date: Fri, 10 Mar 2006 11:37:33 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5: process with huge vsize but no swap used
References: <E1FHa7o-00015W-8g@approximate.corpus.cam.ac.uk>
In-Reply-To: <E1FHa7o-00015W-8g@approximate.corpus.cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Mar 2006 16:40:50.0479 (UTC) FILETIME=[63E02BF0:01C64461]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14315.000
X-TM-AS-Result: No--15.400000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like a bug in emacs.  It probably allocated a ton of memory ( 1.2 
gigs?! ) and just didn't actually touch it, thus you still have plenty 
of free physical memory and swap.

Sanjoy Mahajan wrote:
> System is a Thinkpad 600X (Pentium III) w/ 576MB of RAM, 1GB of swap.
> 
> While testing 2.6.16-rc5 for ACPI issues, I ran across a vm behavior
> that I've never seen before.  I had just booted and logged in via xdm,
> and had opened a few small files in emacs.  All of a sudden
> sudden emacs complained that:
> 
>   Memory exhausted--use M-x save-some-buffers RET
> 
> I didn't have any large files opened, but:
> 
> $ ps u3817
> USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
> sanjoy    3817  0.1  2.0 1246160 11992 ?       S    Mar09   0:11 emacs -iconic
> 
> No swap is being used despite emacs allegedly consuming 1.2GB of VM:
> 
> $ free
>              total       used       free     shared    buffers     cached
> Mem:        580924     219964     360960          0      29124     128956
> -/+ buffers/cache:      61884     519040
> Swap:      1068280          0    1068280
> 
> Is that possible (maybe it's all zero-filled memory)?  If so, it's an
> emacs bug that I've never seen before and I'll report it on the emacs
> lists.  If it's not possible, then maybe it's a kernel issue.  I saved
> /proc/3817/{maps,smaps,status,exe} just in case.
> 
> -Sanjoy
> 
> `A society of sheep must in time beget a government of wolves.'
>    - Bertrand de Jouvenal

