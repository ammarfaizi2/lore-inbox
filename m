Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267542AbTBLPyA>; Wed, 12 Feb 2003 10:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267536AbTBLPx7>; Wed, 12 Feb 2003 10:53:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37896 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267534AbTBLPx5>;
	Wed, 12 Feb 2003 10:53:57 -0500
Message-ID: <3E4A7043.1070200@pobox.com>
Date: Wed, 12 Feb 2003 11:03:15 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Ballabio_Dario@emc.com
CC: manfred@colorfullife.com, warp@mercury.d2dc.net,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-eata@i-connect.net
Subject: Re: eata irq abuse (was: Re: Linux 2.5.60)
References: <70652A801D9E0C469C28A0F8BCF49CF9012EBA15@itmi1mx2.corp.emc.com> <3E4A6801.3050702@pobox.com>
In-Reply-To: <3E4A6801.3050702@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Ballabio_Dario@emc.com wrote:
> 
>> Yes, you are correct. I used spin_unlock in order to release the local
>> driver lock
>> during the scsi_register call, but I forgot that I had the irq 
>> disabled as
>> well.
>> SO the correct fix is to use spin_unlock_irq/spin_lock_irq around the
>> scsi_register call. Same fix applies to the u14-34f driver.
> 
> scsi_register may want to sleep, so that is not a fix at all...


Ooops, I missed the order.  You (and Manfred) are right, 
unlock-register-lock is desired.

ENOCAFFEINE, I plead...

