Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbUCBXJh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 18:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbUCBXJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 18:09:36 -0500
Received: from [213.133.118.5] ([213.133.118.5]:49576 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S261784AbUCBXJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 18:09:20 -0500
Message-ID: <40451415.10300@shadowconnect.com>
Date: Wed, 03 Mar 2004 00:09:09 +0100
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040224)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: alan@lxorguk.ukuu.org.uk, wtogami@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2o subsystem minor bugfixes to work with 2.6.3 kernel
References: <40446CCC.5070102@shadowconnect.com> <20040302133429.40b953b8.akpm@osdl.org>
In-Reply-To: <20040302133429.40b953b8.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Andrew Morton wrote:

>>here is the patch against 2.6.3 kernel to fix the I2O subsystem for the 2.6 
>>kernel.
>>
>Could you please describe the changes you have made?  ie: what the bugs
>are, and how you fixed them?
>

Oh sorry, totally forgot.

drivers/message/i2o/i2o_block.c:
--------------------------------
- corrected the initialization sequence of the request queues.
- added initialization to queue spinlocks.
- release device in i2o_scan because else the device could not be queried.

- i2o_block event threads wait on signal KILL but signal TERM was sent.

drivers/message/i2o/i2o_core.c:
-------------------------------
- set the HRT length to 0 at initialization, to avoid calling free on unallocated memory.
- i2o_core event threads wait on signal KILL but signal TERM was sent.
- added a limit of 3 tries to get the HRT from the controller.
- removed the dpt parameter, which was used to force DPT controllers get handled by the i2o driver. Now all available i2o controllers will be handled by this driver.

drivers/message/i2o/i2o_scsi.c:
-------------------------------
- beautifying of printk calls.
- added scsi_unregister to properly clean up on module unload.

drivers/message/i2o/Kconfig:
----------------------------
- added help for i2o_block and i2o_scsi to describe the differences between the two drivers.


include/linux/i2o-dev.h:
------------------------
- cleaned typo "tate" into "state".

include/linux/i2o.h:
--------------------
- removed defines from i2o_block and insert it here.


Hope it is okey this way.

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

