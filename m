Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130916AbQLMULs>; Wed, 13 Dec 2000 15:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130984AbQLMULi>; Wed, 13 Dec 2000 15:11:38 -0500
Received: from adsl-209-182-168-213.value.net ([209.182.168.213]:2319 "EHLO
	draco.foogod.com") by vger.kernel.org with ESMTP id <S130916AbQLMUL0>;
	Wed, 13 Dec 2000 15:11:26 -0500
Date: Wed, 13 Dec 2000 11:40:46 -0800
From: alex@foogod.com
To: Andre Hedrick <andre@linux-ide.org>
Cc: alex@foogod.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] I-Opener fix (again)
Message-ID: <20001213114046.B19902@draco.foogod.com>
In-Reply-To: <20001211152331.M10618@draco.foogod.com> <Pine.LNX.4.10.10012122217440.4894-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.LNX.4.10.10012122217440.4894-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2000 at 10:47:35PM -0800, Andre Hedrick wrote:
> 
> Basically if the setting of 
> 
>  * "hdx=flash"          : allows for more than one ata_flash disk to be
>  *                              registered. In most cases, only one device
>  *                              will be present.
> 
> fails then I will look into this but, the breaking of laptops that have
> CFA devices that do not come on channels in a pair canb not happen.
> If you have a vender unique setting that will follow always the way
> I-Opener's are setup then that is better.

Ok, there are two things here:

1) "hdx=flash" _does_ fail, because the flash-related code clobbers hda 
   _after_ hda's detection phase, when it's looking at hdb (which is flash).

2) I can see no situation where hdb detection should ever override the 
   _already_performed_ detection of hda in this way.

Basically, as is, the kernel finds hda (traditional IDE device), configures it 
normally, then finds hdb (flash), and clobbers all the correct info it already 
detected for hda.  This seems just plain wrong.

-alex
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
