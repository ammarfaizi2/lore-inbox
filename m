Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267629AbUHRXl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267629AbUHRXl4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 19:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267632AbUHRXlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 19:41:55 -0400
Received: from s0003.shadowconnect.net ([213.239.201.226]:20185 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S267629AbUHRXlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 19:41:35 -0400
Message-ID: <4123E73F.7040409@shadowconnect.com>
Date: Thu, 19 Aug 2004 01:33:19 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
Organization: Shadow Connect
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: alan@lxorguk.ukuu.org.uk, wtogami@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Merge I2O patches from -mm
References: <4123E171.3070104@shadowconnect.com> <20040819002448.A3905@infradead.org>
In-Reply-To: <20040819002448.A3905@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

Christoph Hellwig wrote:
> On Thu, Aug 19, 2004 at 01:08:33AM +0200, Markus Lidel wrote:
>>Okay, patch i2o_scsi-cleanup.patch adds a notification facility to the 
>>i2o_driver, which notify if a controller is added or removed. The 
>>i2o_controller structure has now the ability to store per-driver data 
>>and the SCSI-OSM now takes advantage of this. So all ugly parts should 
>>be removed now :-)
>>If you have further things which should be changed, please let me know...
> Looks much better now, thanks.  But instead of the notify call please

Thanks!

> add a controller_add and add controller_remove method, taking a typesafe
> i2o_controller * instead of the multiplexer.

I had this before, but i want the notification also for I2O devices, 
because the driver model won't call probe functions for devices, which 
are already occupied by a other driver. This is not the best solution, 
if you have more then one drivers which could handle a device. This is 
the case in e.g. i2o_proc, which only want to display information, and 
is not a "real driver". So finally there will be controller_add, 
controller_remove, device_add, device_remove... and i thought it would 
be more generic, and i also don't have to add a function each time a new 
notification is needed :-)

Also i tried to implement the notification like the one already in the 
kernel, so i could exchange my notification facility with the already 
existing one (include/linux/notifier.h)...



Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
