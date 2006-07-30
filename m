Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbWG3XYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWG3XYp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 19:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWG3XYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 19:24:45 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:12265 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750844AbWG3XYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 19:24:45 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44CD3F1E.1010101@s5r6.in-berlin.de>
Date: Mon, 31 Jul 2006 01:22:06 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Johannes Weiner <hnazfoo@googlemail.com>
CC: linux-kernel@vger.kernel.org, Patrick Mau <mau@oscar.ping.de>
Subject: Re: Question about "Not Ready" SCSI error
References: <20060730181014.GA13456@oscar.prima.de> <20060730215257.GA8339@leiferikson.dystopia.lan>
In-Reply-To: <20060730215257.GA8339@leiferikson.dystopia.lan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Weiner wrote:
> On Sun, Jul 30, 2006 at 08:10:19PM +0200, Patrick Mau wrote:
>> Google revealed[1] that the drive is waiting for a START UNIT command,
>> but it seems that the kernel is not attempting to spin up the drive
>> again.
> 
> I don't know exactly if it's enough to requeue the scsi command, please
> comment on this, guys.

AFAIU, the scsi_eh (error handler) already has proper code for exactly 
this purpose, but the code is inactive. Any driver (SCSI low-level 
driver or SCSI command set driver) can activate it by setting 
scsi_device->allow_restart = 1.

Brian King posted a patch which lets you enable that flag at runtime:
"scsi: Add allow_restart sysfs class attribute", 2006-06-27
http://marc.theaimsgroup.com/?l=linux-scsi&m=115142503103468

The patch is in Linus' tree now.
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=history;f=drivers/scsi/sd.c
-- 
Stefan Richter
-=====-=-==- -=== =====
http://arcgraph.de/sr/
