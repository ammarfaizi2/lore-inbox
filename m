Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbVLPCJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbVLPCJF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 21:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbVLPCJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 21:09:05 -0500
Received: from straum.hexapodia.org ([64.81.70.185]:48455 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S1751285AbVLPCJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 21:09:04 -0500
Date: Thu, 15 Dec 2005 18:09:03 -0800
From: Andy Isaacson <adi@hexapodia.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@suse.cz>, Stefan Seyfried <seife@suse.de>,
       LKML <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [RFC/RFT] swsusp: image size tunable (was: Re: [PATCH][mm] swsusp: limit image size)
Message-ID: <20051216020903.GB26568@hexapodia.org>
References: <200512072246.06222.rjw@sisk.pl> <20051210160641.GB5047@elf.ucw.cz> <200512102106.41952.rjw@sisk.pl> <200512102356.27271.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512102356.27271.rjw@sisk.pl>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 10, 2005 at 11:56:26PM +0100, Rafael J. Wysocki wrote:
> Update:
> 
> A cleaner version with comments etc. follows.
> 
>  Documentation/power/interface.txt |   11 +++++++++++
>  Documentation/power/swsusp.txt    |    7 ++++++-
>  kernel/power/disk.c               |   20 ++++++++++++++++++++
>  kernel/power/power.h              |    7 ++-----
>  kernel/power/swsusp.c             |   10 +++++++++-
>  5 files changed, 48 insertions(+), 7 deletions(-)

I've been testing this as present in 2.6.15-rc5-mm2 and it works like a
champ.  I am currently running with image_size=150, which seems to be a
nice balance between quick suspend and still having a reasonable working
set after resume.

I did have one concerning failure during an earlier test, though - I
have only 512MB of swap with 1.25GB RAM.  Now obviously if there are
>500MB user pages, swsusp must fail; but I think I had a failure even
though there was only about 400MB user pages - some of it was swapped
out, and I had image_size=500, which resulted in an image that would not
fit into the available swap space.

It sucks to fail the suspend just because the chosen image size didn't
fit into the current state of the machine.  Now obviously I need to
resize my swap partition to prevent this from happening, but it would
be nice if swsusp would automatically "try harder!" if appropriate.

I can reproduce this and collect more data if needed.

-andy
