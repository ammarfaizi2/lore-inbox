Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267356AbUHMTxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267356AbUHMTxF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267351AbUHMTtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:49:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33757 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267353AbUHMTo1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 15:44:27 -0400
Message-ID: <411D1A0A.7040807@pobox.com>
Date: Fri, 13 Aug 2004 15:44:10 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Jens Axboe <axboe@suse.de>, Arjan van de Ven <arjanv@redhat.com>,
       Alan Cox <alan@www.pagan.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SG_IO and security
References: <1092313030.21978.34.camel@localhost.localdomain> <Pine.LNX.4.58.0408120929360.1839@ppc970.osdl.org> <Pine.LNX.4.58.0408120943210.1839@ppc970.osdl.org> <1092341803.22458.37.camel@localhost.localdomain> <Pine.LNX.4.58.0408121705050.1839@ppc970.osdl.org> <20040813065902.GB2321@suse.de> <1092383006.2813.0.camel@laptop.fenrus.com> <20040813074654.GA2663@suse.de> <411D140C.4040100@pobox.com> <Pine.LNX.4.58.0408131236340.1839@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408131236340.1839@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 13 Aug 2004, Jeff Garzik wrote:
> 
>>2B
>>Jens Axboe wrote:
>>
>>>I have no idea how many apps use this ioctl, does anyone have a rough
>>>list?
>>
>>Add a rate-limited "this feature is deprecated" feature and find out...
> 
> 
> Googling for it does show it as being documented and apparently used by a 
> few programs, at least...


Personally I know it's in use, but for some programs it's a fallback if 
SG_IO or a more modern method doesn't work...

Since we have (AFAICS) five interfaces (scsi-send-command, sg v1, sg v2, 
sg v3, and SG_IO) I would rather just go ahead and

static int printed_warning;
if (!printed_warning++)
	printk(KERN_WARNING "SCSI_SEND_COMMAND deprecated\n");

Also, inevitably some of the programs using this will be ancient disk 
tools (some written by disk vendors long gone)...

	Jeff


