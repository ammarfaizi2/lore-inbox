Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWBSBFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWBSBFX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 20:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWBSBFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 20:05:23 -0500
Received: from smtp.enter.net ([216.193.128.24]:63752 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S964791AbWBSBFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 20:05:21 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Chris Adams <cmadams@hiwaay.net>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Sat, 18 Feb 2006 20:05:37 -0500
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <fa.0hPNxE1lrymMdITLfVqoa6fG+nM@ifi.uio.no> <20060218183639.GA1023444@hiwaay.net>
In-Reply-To: <20060218183639.GA1023444@hiwaay.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602182005.38433.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 February 2006 13:36, Chris Adams wrote:
> Once upon a time, Christoph Hellwig  <hch@infradead.org> said:
> >On Fri, Feb 17, 2006 at 04:35:30PM -0500, Bill Davidsen wrote:
> >> It would be nice to have one place to go to find burners, and to have
> >> the model information in that place.
> >
> >/proc/sys/dev/cdrom/info
>
> Which is bad, as it is incomplete and requires the kernel be updated to
> know about every format just to document them.
>
> Problems with that file:
>
> - What is "drive speed" (no units); also most drives do different speeds
>   for different modes/media.
>
> - CD-RW really covers a range of different formats ("high speed" CD-RW
>   is different and IIRC there's also "ultra high speed" CD-RW).
>
> - Several formats are missing: DVD-RW DVD+R DVD+RW DVD-DL DVD+DL (at
>   least).
>
> - What is the "RAM" format (not "DVD-RAM")?  I haven't heard of that.
>
> The kernel really only needs to know:
>
> - how the drive can control the tray (open/close/lock/change disc)
>
> - if the drive can handle rewritable formats (for UDF support)
>
> Alternately, every known format needs to be added to that file (both
> read and write support).  It also needs to note read and write speeds
> for each available format.
>
> Also, that is an annoying to parse format.  What if there's a really
> long text column field like "Can write Blu-Ray HD dual layer v2"?
> Something under /sys would be better with one value per file, so if you
> want to burn a DVD-R, you look for /sys/block/*/cdinfo/write/dvd-r;
> maybe that file contains a space separated list of available speeds (so
> "1 2 4 8").  Also, right now as far as I can see, /sys doesn't present
> manufacturer, model, and/or serial number info.


Agreed. Which is why I'll use that file as a basis for the minor bit of work 
I'll do in adding the capabilities and other information to sysfs. Though I 
was under the impression that a lot of the device specific information was 
being moved into sysfs anyway...

The reason it just says RAM is because, contrary to my statement in an earlier 
mail it doesn't mean DVD-RAM, since my CD-RW also has that listed. (and 
DVD-RAM has it's own slot in the file) I wasn't able to locate information on 
what that is in the MMC docs, but in this case it might refer to the UDF 
format. AFAICT the names used there are what are presented by the drive in 
the capabilities mode page.

DRH


