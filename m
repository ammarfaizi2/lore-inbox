Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751507AbWB0UXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbWB0UXT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 15:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbWB0UXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 15:23:19 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:23159 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751507AbWB0UXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 15:23:18 -0500
Message-ID: <44035FF4.8070600@tmr.com>
Date: Mon, 27 Feb 2006 15:24:20 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <fa.0hPNxE1lrymMdITLfVqoa6fG+nM@ifi.uio.no> <20060218183639.GA1023444@hiwaay.net>
In-Reply-To: <20060218183639.GA1023444@hiwaay.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Adams wrote:
> Once upon a time, Christoph Hellwig  <hch@infradead.org> said:
>> On Fri, Feb 17, 2006 at 04:35:30PM -0500, Bill Davidsen wrote:
>>> It would be nice to have one place to go to find burners, and to have 
>>> the model information in that place.
>> /proc/sys/dev/cdrom/info
> 
> Which is bad, as it is incomplete and requires the kernel be updated to
> know about every format just to document them.

Document them where? In the kernel Documentation directory? I believe
those strings come back from the drive, as long as the human or
application can parse them the kernel operationally needs only what you
mentioned below.
> 
> Problems with that file:

The main problem with that file is that it wasn't mentioned several
years ago... and I hope you aren't even thinking of suggesting any
changes to something which has been around for years and which
applications are undoubtedly quietly using.

A changed version of the same information in /sys would be a better
solution if changes other than some additions are needed.
> 
> - What is "drive speed" (no units); also most drives do different speeds
>   for different modes/media.

Presumably the max speed mechanically possible, in the units of "x"
which are used to identify both media and burners and have been since
"2x" was the fast burner.
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

CD-RW seems to cover that.
> 
> Alternately, every known format needs to be added to that file (both
> read and write support).  It also needs to note read and write speeds
> for each available format.

Why? The mmc/scsi commands work or don't, the device returns the info in
the capabilities page if the application can use it, so it doesn't seem
that the kernel cares, other than the cases you mentioned.
> 
> Also, that is an annoying to parse format.  What if there's a really
> long text column field like "Can write Blu-Ray HD dual layer v2"?
> Something under /sys would be better with one value per file, so if you
> want to burn a DVD-R, you look for /sys/block/*/cdinfo/write/dvd-r;

Isn't there a problem with having the same device in multiple places?
Someone posted that there was, but I didn't really get into the details.
In any case, why is opening dozens of files better than opening one file
with all of the info. Long names can be abbreviated, complexity in the
kernel to avoid complexity in the application is bad, particularly when
humans parse the existing format nicely.

> maybe that file contains a space separated list of available speeds (so
> "1 2 4 8").  Also, right now as far as I can see, /sys doesn't present
> manufacturer, model, and/or serial number info.

The only applications which care about speeds other than max are already
reading the capabilities page. Use cdrecord with the "-prcap" options,
there is a boatload of stuff there. I agree the the three text items are
  useful, and major/minor to map the device to the name actually used in
/dev, but that data doesn't fit the format well, and might be better
presented in /sys. Preferably in a human readable format, like
/proc/scsi/scsi rather than multiple file per device.


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

