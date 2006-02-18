Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWBRSgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWBRSgm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 13:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWBRSgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 13:36:42 -0500
Received: from bee.hiwaay.net ([216.180.54.11]:58572 "EHLO bee.hiwaay.net")
	by vger.kernel.org with ESMTP id S932108AbWBRSgl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 13:36:41 -0500
Date: Sat, 18 Feb 2006 12:36:40 -0600
From: Chris Adams <cmadams@hiwaay.net>
To: linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060218183639.GA1023444@hiwaay.net>
References: <fa.0hPNxE1lrymMdITLfVqoa6fG+nM@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218120617.GA911@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once upon a time, Christoph Hellwig  <hch@infradead.org> said:
>On Fri, Feb 17, 2006 at 04:35:30PM -0500, Bill Davidsen wrote:
>> It would be nice to have one place to go to find burners, and to have 
>> the model information in that place.
>
>/proc/sys/dev/cdrom/info

Which is bad, as it is incomplete and requires the kernel be updated to
know about every format just to document them.

Problems with that file:

- What is "drive speed" (no units); also most drives do different speeds
  for different modes/media.

- CD-RW really covers a range of different formats ("high speed" CD-RW
  is different and IIRC there's also "ultra high speed" CD-RW).

- Several formats are missing: DVD-RW DVD+R DVD+RW DVD-DL DVD+DL (at
  least).

- What is the "RAM" format (not "DVD-RAM")?  I haven't heard of that.

The kernel really only needs to know:

- how the drive can control the tray (open/close/lock/change disc)

- if the drive can handle rewritable formats (for UDF support)

Alternately, every known format needs to be added to that file (both
read and write support).  It also needs to note read and write speeds
for each available format.

Also, that is an annoying to parse format.  What if there's a really
long text column field like "Can write Blu-Ray HD dual layer v2"?
Something under /sys would be better with one value per file, so if you
want to burn a DVD-R, you look for /sys/block/*/cdinfo/write/dvd-r;
maybe that file contains a space separated list of available speeds (so
"1 2 4 8").  Also, right now as far as I can see, /sys doesn't present
manufacturer, model, and/or serial number info.
-- 
Chris Adams <cmadams@hiwaay.net>
Systems and Network Administrator - HiWAAY Internet Services
I don't speak for anybody but myself - that's enough trouble.
