Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbVJQUuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbVJQUuj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 16:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbVJQUuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 16:50:39 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:14290 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S932313AbVJQUui
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 16:50:38 -0400
Message-ID: <43540E9D.4090906@rtr.ca>
Date: Mon, 17 Oct 2005 16:50:37 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Debian/1.7.12-0ubuntu05.04
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>
Subject: Re: hdparm almost burned my SATA disk
References: <20051016010153.768d29d5@werewolf.able.es>	 <20051016010459.0c9a2beb@werewolf.able.es> <6bffcb0e0510151705l67725fd3t@mail.gmail.com>
In-Reply-To: <6bffcb0e0510151705l67725fd3t@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Piotrowski wrote:
>
> debian:/home/michal# hdparm -tT /dev/sda
> 
> /dev/sda:
>  Timing cached reads:   3652 MB in  2.00 seconds = 1823.54 MB/sec
> HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate
> ioctl for device
>  Timing buffered disk reads:  174 MB in  3.01 seconds =  57.72 MB/sec
> HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate
> ioctl for device
> debian:/home/michal# hdparm -V
> hdparm v6.1
> debian:/home/michal# hdparm -I /dev/sda
> 
> /dev/sda:
>  HDIO_DRIVE_CMD(identify) failed: Inappropriate ioctl for device
 >

Harmless.  100% harmless.

The "Inappropriate ioctl for device" messages are due to the incomplete
implementation of HDIO_DRIVE_CMD in libata.  No big deal.  Once the
passthru patches finally get released for real, I'll update hdparm to
not use the missing ioctl.

Cheers
