Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbTE0HQz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 03:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbTE0HQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 03:16:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22733 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262363AbTE0HQx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 03:16:53 -0400
Message-ID: <3ED313F3.805@pobox.com>
Date: Tue, 27 May 2003 03:29:55 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCHES] add ata scsi driver
References: <Pine.LNX.4.44.0305262339510.19197-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0305262339510.19197-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> One prime example of this is cdrecord, and the incredible braindamage that
> the name "SCSI" foisted upon it. Why? Because everybody (ie schily)  
> _knows_ that SCSI is addressed by bus/id/lun, and thinks that anything
> else is wrong. So you have total idiocies like the "cdrecord -scanbus"  
> crap for finding your device, and totally useless naming that makes no 
> sense in any sane environment.
> 
> Calling something SCSI when it isn't brings on these kinds of bad things: 
> people make assuptions that aren't sensible or desireable.
> 
> Names have power. There's baggage and assumptions in a name. In the case
> of SCSI, there is a _lot_ of baggage.


Now that argument I can buy.

There's still helper functions to be created before a native block 
driver can directly use struct requests for fully native queueing. 
Brand new device, host registration code.  PM, hotplug, yadda yadda.  It 
winds up being a lot of code still, and it not as simple as you and Jens 
seem to be making the task out to be.  That's why I brought up 
/dev/{disk,floppy,cdrom}...

If all that work is to be done for a brand new, native block driver, we 
should at least intend on using the code as a bus-agnostic command 
transport layer, with packages of helpers like my current "libata" doing 
the command set work (and sometimes, some amount of low-level driver 
work, where commonality exists).

	Jeff



