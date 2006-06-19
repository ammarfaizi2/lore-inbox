Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWFSGxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWFSGxr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 02:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWFSGxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 02:53:47 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:8633 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751180AbWFSGxr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 02:53:47 -0400
Message-ID: <4496492A.1030907@aitel.hist.no>
Date: Mon, 19 Jun 2006 08:50:18 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Jeff Gold <jgold@mazunetworks.com>
CC: Mark Lord <lkml@rtr.ca>, linux-kernel@vger.kernel.org
Subject: Re: Serial Console and Slow SCSI Disk Access?
References: <448DDC7F.4030308@mazunetworks.com> <448DDF1D.5020108@rtr.ca> <448DE4F1.9000407@mazunetworks.com>
In-Reply-To: <448DE4F1.9000407@mazunetworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Gold wrote:
> Mark Lord wrote:
>> This can happen if there are kernel messages being printed on the 
>> serial console.
>> If all is quiet, I would expect things to be as fast as normal 
>> elsewhere.
>
> Thank you for the suggestion.  I don't see much in /var/log/messages 
> (syslogd is running).  There are 3326 lines taking up about 256 kB 
> there, and when I run hdparm runs no further messages are generated.
>
> I don't have anything attached to the serial port at the moment.  
> Could that cause problems?  I'm going to attach something and see what 
> happens.  Other advice is still welcome. 
With nothing attached, any write to the serial device might go through
a lengthy timeout because of flow control.  I'd consider that a bug
in this case though, and there is usually no console printout
per scsi disk access either.


I would not be surprised if your serial console causes a longer boot time,
as all boot messages have to be transferred over the slow serial link
or in the worst case timed out one message at a time.

But I can't see why it'd make scsi disks slower. The scsi host adapter 
initialization
writes some messages of course, but there should be no more console accesses
during a hdparm test run.

Helge Hafting
