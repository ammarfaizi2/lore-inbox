Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263875AbUHJJ51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbUHJJ51 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 05:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbUHJJzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 05:55:50 -0400
Received: from mail1.srv.poptel.org.uk ([213.55.4.13]:26266 "HELO
	mail1.srv.poptel.org.uk") by vger.kernel.org with SMTP
	id S263795AbUHJJxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 05:53:40 -0400
Message-ID: <41189AA2.3010908@phonecoop.coop>
Date: Tue, 10 Aug 2004 10:51:30 +0100
From: Alan Jenkins <sourcejedi@phonecoop.coop>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: cd burning: kernel / userspace?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've followed the latest cdrecord "discussion" on the list, and I can't 
see why you have to use a userspace program which talks SCSI in order to 
burn a cd.

The current Mount Rainer allows you to treat a MR formatted CD-RW as a 
big floppy disk - to read and write to /dev/cdrecorder just like 
/dev/floppy.  The packet writing patch takes a different approach - 
using a separate device which is bound to the cdrecorder device, but 
AFAIK this is a temporary measure, and the ultimate goal is make this 
work the same way - the way the user would expect:

1. Insert a recordable media (e.g. cdrw).
2. Perform any necessary formatting (e.g. cdmrw -d /dev/cdrecorder -f full)
3. Access cdrecorder device (e.g. mount /dev/cdrecorder -tudf -onoatime 
/mnt/cdrecorder)

Why can't a similar method be used for DAO writing?  Packet writing and 
Mount Rainer support belongs in the kernel - why not normal cd burning?  
On modern "burnproof" hardware, it should be possible to use dd to write 
your disk image to the cdrecorder device.  I'm guessing that this just 
isn't as interesting, especially with userspace programs available to do 
the job.

Unfortunately I'm no kernel hacker, so I have no idea whether this is 
practical, and if so how much work would be involved.  I have plenty of 
time to investigate the idea, and upgrade myself from a mere C 
programmer.  Any advice would be appreciated.

Alan Jenkins
