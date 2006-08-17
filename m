Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932530AbWHQOl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbWHQOl3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 10:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbWHQOl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 10:41:29 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:30956 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932530AbWHQOl1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 10:41:27 -0400
Message-ID: <44E47F54.3000300@aitel.hist.no>
Date: Thu, 17 Aug 2006 16:38:12 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       7eggert@gmx.de, Arjan van de Ven <arjan@infradead.org>,
       Dirk <noisyb@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: PATCH/FIX for drivers/cdrom/cdrom.c
References: <6Kxns-7AV-13@gated-at.bofh.it> <6Kytd-1g2-31@gated-at.bofh.it> <6KyCQ-1w7-25@gated-at.bofh.it> <E1GDgyZ-0000jV-MV@be1.lrz> <1155821951.15195.85.camel@localhost.localdomain> <20060817132309.GX13639@csclub.uwaterloo.ca> <44E471F2.5000003@garzik.org> <20060817135431.GE13641@csclub.uwaterloo.ca>
In-Reply-To: <20060817135431.GE13641@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:
> On Thu, Aug 17, 2006 at 09:41:06AM -0400, Jeff Garzik wrote:
>   
>> Lennart Sorensen wrote:
>>     
>>> Why can't O_EXCL mean that the kernel prevents anyone else from issuing
>>> ioctl's to the device?  One would think that is the meaning of exlusive.
>>> That way when the burning program opens the device with O_EXCL, no one
>>> else can screw it up while it is open.  If it happens to be polled by
>>> hal when the burning program tries to open it, it can just wait and
>>> retry again until it gets it open.
>>>       
>> Such use of O_EXCL is a weird and non-standard behavior.
>>     
>
> So what method exists for opening a file/device an guaranteeing that
> nothing else can do anything to it?
>   
None on the file level I hope, for it will surely get abused.
Windows have exclusive open for example, and there acrobat reader
locks the pdf file it views, so you can't make a new version without
killing acrobat first.  (And then you have to restart it to
view the new file.)  Stupid in the extreme.  Fortunately, acrobat can't
do that on linux where there is no (easy) opportunity to do so.

There are many other examples - backup sw can't read files that
happens to be opened exclusive by some process.

I guess this particular case could be solved by fixing the cdrom
driver like this:

Whenever the device is opened for writing (i.e. someone is
burning a CD/DVD), then reject the probing ioctls HAL uses.
Or just make the device exclusive while burning.  Restore
normal operation as soon as the burn ends.   There is no
use for reading the device during a burn anyway - a special case
for CD/DVD writers.


Helge Hafting






