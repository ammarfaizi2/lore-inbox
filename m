Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbTJ0MDF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 07:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbTJ0MDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 07:03:05 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:52746 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261615AbTJ0MDC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 07:03:02 -0500
Message-ID: <3F9D0BBB.9080600@aitel.hist.no>
Date: Mon, 27 Oct 2003 13:12:43 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20031010 Debian/1.4-6
X-Accept-Language: no, en
MIME-Version: 1.0
To: Stef van der Made <svdmade@planet.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Heavy disk activity without apperant reason (added more info)
References: <3F9BC429.6060608@planet.nl>
In-Reply-To: <3F9BC429.6060608@planet.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stef van der Made wrote:
> 
> On my AMD athlon system with 512MB memory I sometimes get a lot of disk 
> activity the activity normaly lasts for about 10 seconds and after that 
> the disk stays relativily quiet as expected with the load on the system. 
> When I look into top I don't see any programs that could explain the 
> disk activity. The system is in most cases not using any swap.
> 
Try finding out what is causing this.
Have a "vmstat 1" running.  Break it after this
disk activity starts.  You should be able to
see wether it is normal io or swap.

Also have a "top -d 1" running.  A normal
process issuing lots of io will probably
show up here too.  "ps aux" during
the activity might also be a good idea.

Note that such behaviour isn't necessarily unusual.
Perhaps cron started something that needed lots
of reads to start?  Perhaps you got a bunch of emails?
Email software often use synchronous writes, so they won't
loose any of your mail even in case of a crash.
This synchronous io makes for _lots_ of disk seeking.
Email filters (for spam and other purposes) may make this even worse, 
with email messages being written synchronously several times.
If you use "fetchmail" started by cron - see if these disk bursts
correspond with mail fetching.

Helge Hafting

