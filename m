Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267882AbUGaAyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267882AbUGaAyy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 20:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267889AbUGaAyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 20:54:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5353 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267882AbUGaAyv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 20:54:51 -0400
Message-ID: <410AEDC8.6030901@pobox.com>
Date: Fri, 30 Jul 2004 20:54:32 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Todd Poynor <tpoynor@mvista.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tim.bird@am.sony.com, dsingleton@mvista.com
Subject: Re: [PATCH] Configure IDE probe delays
References: <20040730191100.GA22201@slurryseal.ddns.mvista.com> <1091226922.5083.13.camel@localhost.localdomain>
In-Reply-To: <1091226922.5083.13.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Gwe, 2004-07-30 at 20:11, Todd Poynor wrote:
> 
>>IDE initialization and probing makes numerous calls to sleep for 50
>>milliseconds while waiting for the interface to return probe status and
>>such. 
> 
> 
> Please make it taint the kernel if you do that so we can ignore all the
> bug reports. That or justify it with a cite from the ATA standards ?


The 50 milliseconds is a pragmatic number you won't find in any 
standard.  Linux IDE driver does the "bang at the door" method of 
probing, which you won't find in any standard either :)

The ATA standard defines times for things like software reset (SRST), 
but Linux IDE driver takes a unique approach -- just issue down the 
first command (IDENTIFY DEVICE), and see what you get.  The command (or 
error) responses give you information that allows you to probe further.

The 50ms delay hides things like the device coming out of reset, the 
interface powering up on the first command issued to the device, etc.

IMO the number is a "change it at your own risk" number that shouldn't 
be touched unless the touch-er is also willing to rewrite the IDE 
driver's probe code ;-)

SATA is much faster at probing, and PATA will become progressively less 
common, so the motivation for changing the probe code is low, too.

	Jeff


