Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264961AbUD2U1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264961AbUD2U1y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 16:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264963AbUD2U1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 16:27:54 -0400
Received: from [213.133.118.2] ([213.133.118.2]:18577 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S264961AbUD2U1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 16:27:48 -0400
Message-ID: <40916612.4070206@shadowconnect.com>
Date: Thu, 29 Apr 2004 22:31:14 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] I2O subsystem fixing and cleanup for 2.6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

here are 5 patches, which cleanup the I2O subsystem in 2.6.

The patches are as follows:
- i2o-config-clean.patch
   * Changes the formating of the header in i2o_config.c

- i2o-passthru.patch
   * Add a pass-thru ioctl to i2o_config, which is needed to work with
     the Adaptec management software.

- i2o_block-cleanup.patch
   * more than 3 "visible" disks (hda, hdb, hdc, hdd) lead to kernel
     panics.
   * removes some unused code with partitions.
   * I2O_LOCK was often called with the addresses of the controller, and
     not with the address of the device. Fixed.
   * the cleanup function for gendisk (del_gendisk) doesn't work if the
     queue is shared between different devices. To workaround the queue
     is removed before.
   * redundant code removed in module initialization and remove, use
     i2ob_new_device and i2ob_del_device instead.
   * removed atomic_t queue_depth
   * removed unnecessary and bogus code for queue handling

- i2o-64-bit-fix.patch
   * provides i2o_context_list_*() functions, which maps 64-bit pointers
     to 32-bit context id's in a dynamic list. On 32-bit systems the
     functions are replaced with a static inline.
   * i2o_scsi now uses the i2o_context_list_*() functions for transaction
     context, and therefore now work on 64-bit systems too.

- i2o-makefile-cleanup.patch
   * The Kconfig and Makefile in drivers/message/i2o still got a
     CONFIG_I2O_PCI entry, which is not used anymore. This one is
     replaced by a CONFIG_I2O_CONFIG entry, which now builds the
     i2o_config module.

Already posted the first 4 patches to linux-scsi with request for 
review, but expect of the i2o-passthru.patch there where no complains. 
And the request for using the SG_IO in i2o-passthru.patch isn't possible 
at the moment, because it is a char device node.

If you have any questions / problems, please let me know.


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

