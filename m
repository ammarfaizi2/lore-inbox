Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbULVF1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbULVF1g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 00:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbULVF1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 00:27:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47276 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261367AbULVF1d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 00:27:33 -0500
Message-ID: <41C905C0.9000705@pobox.com>
Date: Wed, 22 Dec 2004 00:27:28 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] USB: fix Scheduling while atomic warning when resuming.
References: <200412220103.iBM13wS0002158@hera.kernel.org> <200412212022.52316.david-b@pacbell.net> <41C8FC25.2060304@pobox.com> <200412212059.15426.david-b@pacbell.net>
In-Reply-To: <200412212059.15426.david-b@pacbell.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:
> On Tuesday 21 December 2004 8:46 pm, Jeff Garzik wrote:
> 
>>>If that lock were dropped, what would prevent other tasks from
>>>touching the hardware while it's sending RESUME signaling down
>>>the bus, and thereby mucking up the resume sequence?
>>
>>Precisely what other tasks are active for this hardware, during resume?
> 
> 
> There's no guarantee that suspend() and resume() methods
> are only called during system-wide suspend and resume.

That is precisely the reason why I am concerned.  If it was only during 
system-wide resume, the impact of the very-long mdelay() would be more 
difficult to notice.

You also ignored my question :)

If the PCI layer is calling the resume method for a PCI device while 
simultaneously calling the suspend method, that's a PCI layer problem. 
Similarly, If the USB layer is calling into your driver while you are 
resuming, something is broken and it ain't your locking.

	Jeff


