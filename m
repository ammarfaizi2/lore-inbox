Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132289AbRBDUfR>; Sun, 4 Feb 2001 15:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132305AbRBDUfI>; Sun, 4 Feb 2001 15:35:08 -0500
Received: from gear.torque.net ([204.138.244.1]:55556 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S132289AbRBDUfA>;
	Sun, 4 Feb 2001 15:35:00 -0500
Message-ID: <3A7DB935.4170BEBC@torque.net>
Date: Sun, 04 Feb 2001 15:19:01 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Friedrich Lindenberg <frlind@gmx.net>
Subject: Re: AW: ATAPI CDRW which doesn't work -> devfs problems
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Friedrich Lindenberg wrote:
> I was trying to burn cds under linux-2.4.1 with 
> devFS enabled. But x-cd-roast (and also cdrecord)
> do not find any scsi drives. I guess they have been
> renamed or something like that, I cannot find them 
> in /dev, nor anywhere in /dev/scsi ...

xcdroast expects to find a whole swag of sg device
filenames (/dev/sg[0-16], /dev/sg[a-q]) and scsi
cdrom names (/dev/sr[0-15]) when it starts. The
xcdroast tarball comes with a MAKEDEVICES.sh script to
create them. If they are not all there it seems to
get upset.

This is not very devfs friendly since its policy
is only to show /dev entries for devices that you
actually have connected and that a driver is 
controlling.

So the hack solution is to edit out of MAKEDEVICES.sh
those file names that you actually have then execute
it. IMO this is not a devfs problem, xcdroast needs an 
improved device scanning algorithm.

BTW the /dev/sga,b,c style of sg device names are
deprecated in favour of the numeric style.

Doug Gilbert

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
