Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWGLNHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWGLNHU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 09:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWGLNHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 09:07:19 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:59300 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1750799AbWGLNHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 09:07:18 -0400
Subject: Re: Help: strange messages from kernel on IA64 platform
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: Sakurai Hiroomi <sakurai_hiro@soft.fujitsu.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060712081614.765261C013@mail2-sv.soft.fujitsu.com>
References: <20060712081614.765261C013@mail2-sv.soft.fujitsu.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 12 Jul 2006 15:07:11 +0200
Message-Id: <1152709632.3217.39.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-12 at 17:19 +0900, Sakurai Hiroomi wrote:
> Hi,
> 
> I saw same message.
> 
> When GAM(Global Array Manager) is started, The following message output.
> kernel: kernel unaligned access to 0xe0000001fe1080d4, ip=0xa000000200053371

first of all you should file a bug against this kernel; the kernel
should not printk about unaligned accesses by default!

> 
> The uioc structure used by ioctl is defined by packed,
> the allignment of each member are disturbed.
> In a 64 bit structure, the allignment of member doesn't fit 64 bit
> boundary. this causes this messages.
> In a 32 bit structure, we don't see the message because the allinment
> of member fit 32 bit boundary even if packed is specified. 
> 
> patch
> I Add 32 bit dummy member to fit 64 bit boundary. I tested.
> We confirmed this patch fix the problem by IA64 server.


this changes the calling convention of this structure!
If there is no strict calling convention, then the packed can be
removed, but if there is your patch changes the ABI!!
(and you could then fix it by using get_unaligned() in the places that
use this field)
