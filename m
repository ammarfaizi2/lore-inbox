Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbVBIPPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbVBIPPE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 10:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbVBIPPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 10:15:04 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:55725 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261831AbVBIPO7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 10:14:59 -0500
Message-ID: <420A28DA.40700@us.ibm.com>
Date: Wed, 09 Feb 2005 09:14:34 -0600
From: Brian King <brking@us.ibm.com>
Reply-To: brking@us.ibm.com
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Belay <ambx1@neo.rr.com>
CC: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Dynids - passing driver data
References: <200502072200.j17M0S0N008552@d01av02.pok.ibm.com> <20050207221820.GA27543@kroah.com> <20050208182127.GA28367@neo.rr.com>
In-Reply-To: <20050208182127.GA28367@neo.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Belay wrote:
> On Mon, Feb 07, 2005 at 02:18:20PM -0800, Greg KH wrote:
> 
>>On Mon, Feb 07, 2005 at 04:00:27PM -0600, brking@us.ibm.com wrote:
>>
>>>Currently, code exists in the pci layer to allow userspace to specify
>>>driver data when adding a pci dynamic id from sysfs. However, this data
>>>is never used and there exists no way in the existing code to use it.
>>
>>Which is a good thing, right?  "driver_data" is usually a pointer to
>>somewhere.  Having userspace specify it would not be a good thing.
> 
> 
> Yeah, I don't think it's safe to use "driver_data".  Although it can be a
> set of flags, it's also often used as an index in an array, or as a
> pointer.  An invalid value could result in an oops.
> 
> Most drivers don't use "driver_data".  For those that do, it might be
> helpful to have the capability of setting a few static configuration values
> before probing the device. Currently "driver_data" fills this role.
> Perhaps we need a new mechanism that would be more useable with sysfs?
> The current code is limiting because the configuration options in
> "driver_data" are not well defined.  Any ideas?

Unfortunately, from what I have gathered so far, driver_data is pretty 
unique for different drivers, especially when comparing the usage in the 
pci serial driver to a scsi hba driver like ipr.

Certainly, a driver that uses driver_data as a pointer cannot allow it 
to be passed in from userspace. But a device driver that uses it as an 
index into an array can easily allow it to be passed in and do some 
simple range checking on it to verify it is a valid value before 
indexing into the array.


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
