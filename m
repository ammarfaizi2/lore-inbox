Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbTEEFZl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 01:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbTEEFZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 01:25:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7063 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261936AbTEEFZk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 01:25:40 -0400
Message-ID: <3EB5F8B0.20501@pobox.com>
Date: Mon, 05 May 2003 01:37:52 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Matt_Domsch@Dell.com, alan@redhat.com, linux-kernel@vger.kernel.org,
       jgarzik@redhat.com
Subject: Re: [RFC][PATCH] Dynamic PCI Device IDs
References: <1051749599.20870.234.camel@iguana.localdomain> <20030502231558.GA16209@kroah.com>
In-Reply-To: <20030502231558.GA16209@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, Apr 30, 2003 at 07:39:57PM -0500, Matt_Domsch@Dell.com wrote:
> 
>>>First off, nice idea, but I think the implementation needs a bit of
>>>work.
>>
>>Thanks.  I didn't expect it to be perfect first-pass.
>>Let me answer some questions out-of-order, maybe that will help.
>>
>>
>>>>echo 1 > probe_it
>>>>Why wouldn't the writing to the new_id file cause the probe to
>>>
>>>happen immediatly?  Why wait?  So I think we can get rid of that file.
>>
>>That was my first idea, but Jeff said:
>>http://marc.theaimsgroup.com/?l=linux-kernel&m=104681922317051&w=2
>>        I think there is value in decoupling the two operations:
>>        
>>        	echo "0x0000 0x0000 0x0000 0x0000 0x0000 0x0000" >
>>.../3c59x/table
>>        	echo 1 > .../3c59x/probe_it
>>        
>>        Because you want the id table additions to be persistant in the face of
>>        cardbus unplug/replug, and for the case where cardbus card may not be
>>        present yet, but {will,may} be soon.
> 
> 
> But by adding the device ids, they will be persistant, for that driver,
> right?  Then when the device is plugged in, the core will iterate over
> the static and dynamic ids, right?  If so, I don't see how a "probe_it"
> file is needed.

Consider the case:
Device already exists, and is plugged in.  Like a standard PCI card.
Driver doesn't support PCI id, and the sysadmin uses /bin/echo to add one.

For unplugged case, you know you don't need to re-run the probe.

If you really don't want probe_it, I suppose you could re-run the 
driver's PCI probe for the cases where it is redundant.  However, my own 
preference is to let the sysadmin decide whether or not the driver's PCI 
probe should be re-run.

	Jeff




