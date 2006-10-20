Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992728AbWJTVMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992728AbWJTVMq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 17:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992725AbWJTVMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 17:12:46 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:63689 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S2992720AbWJTVMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 17:12:45 -0400
Message-ID: <45393BC4.5020903@garzik.org>
Date: Fri, 20 Oct 2006 17:12:36 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Kevin Radloff <radsaq@gmail.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: Linux 2.6.19-rc2
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org>	 <3b0ffc1f0610201130i8f15e49oec2cdc68abb8dbd@mail.gmail.com> <1161377586.26440.61.camel@localhost.localdomain>
In-Reply-To: <1161377586.26440.61.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Gwe, 2006-10-20 am 14:30 -0400, ysgrifennodd Kevin Radloff:
>> On 10/13/06, Linus Torvalds <torvalds@osdl.org> wrote:
>>> Ok, it's a week since -rc1, so -rc2 is out there.
>> A bit behind, but booting still takes ages on my laptop as
>> libata/ata_piix tries to probe a device that isn't there (I reported
>> this previously against -rc1, but got no response):
> 
> Probing is somewhat broken in 2.6.18 - something in the core code
> changed as its upset quite a few drivers at once. One case causes
> repeated errors and finally detection of an ATAPI device, the other
> causes repeated errors and then failure when no device is present but
> takes a few minutes and keeps IRQs locked off for long periods. Both
> appear to be fallouts from the new EH code.

There are definitely warts related to the new EH stuff, but specifically 
for SATA + ata_piix, it has been a long hard road of trying various 
probing mechanisms.  Tejun has some patches that revert all the PCS work 
and rewinds back to original SATA ata_piix probing, in -mm for testing.

If testing feedback proves positive, let's go ahead and fast-track that 
up the line.

With ata_piix, I would worry more about PCS register follies than core 
libata.  Users can try the module option force_pcs=[0|1|2] to experiment 
and see if any of the three possibilities improves their boot.

	Jeff


