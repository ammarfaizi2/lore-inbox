Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262120AbVADXpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbVADXpU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 18:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbVADXmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 18:42:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22667 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262120AbVADXlx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 18:41:53 -0500
Message-ID: <41DB299C.3030405@pobox.com>
Date: Tue, 04 Jan 2005 18:41:16 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Mudama <edmudama@gmail.com>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Albert Lee <albertcc@tw.ibm.com>, IDE Linux <linux-ide@vger.kernel.org>,
       Doug Maxey <dwm@maxeymade.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: libata PATA support - work items?
References: <006301c4ee5c$49e6a230$95714109@tw.ibm.com> <311601c9050101111929aef5ba@mail.gmail.com>
In-Reply-To: <311601c9050101111929aef5ba@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Mudama wrote:
> On Thu, 30 Dec 2004 18:42:33 +0800, Albert Lee <albertcc@tw.ibm.com> wrote:
> 
>>    2. C/H/S addressing; libata currently hardcoded to use LBA
> 
> 
> 
> Are there really people who want to run a newer 2.4 or a 2.6 kernel,
> who have disks that do not support LBA mode?  CHS will never address
> more than 32GB of the drive (unless you use vendor unique
> implementations) and heck, most companies don't even build drives that
> small anymore...  CHS is very messy, LBA is so much simpler.   Can we
> just stick with that?


Well.......  :)

Originally when I started libata, I targetted it at modern PCI IDE BMDMA 
(i.e. Intel ICH4-like) controllers, with an eye towards FIS-based 
controllers such as Intel AHCI or SiI 3124.

As a result, I intentionally hardcoded several things such as LBA 
support, when writing libata.

Over time, I have consistently seen these "hardcode it" decisions 
reversed, and the hardcoding removed, mainly to add support for 
controllers that are an existing PATA chip (with no SATA modifications) 
glued next to a PATA->SATA transparent bridge.  These controllers 
essentially require PATA support.  Also, in the community, Bart, Alan 
Cox, and others (hi Albert) have been interested in supporting some PATA 
controllers with libata.

So while my original intention with libata was "Bart does the IDE driver 
for PATA, and I do the IDE driver for SATA", and make a clean break, it 
seems that libata is moving more and more towards eventually having full 
PATA support for many controllers, with all that entails.

So, that said, I think it is important for libata to fully support PATA, 
if it is to support it at all.  That means handling the errata that Alan 
always bugs me about, and that means handling C/H/S support as well.

	Jeff


