Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130216AbRBZOeN>; Mon, 26 Feb 2001 09:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130223AbRBZOch>; Mon, 26 Feb 2001 09:32:37 -0500
Received: from zeus.kernel.org ([209.10.41.242]:53191 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130262AbRBZO3o> convert rfc822-to-8bit;
	Mon, 26 Feb 2001 09:29:44 -0500
From: Holger.Smolinski@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: Guest section DW <dwguest@win.tue.nl>, aeb@cwi.nl, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Message-ID: <C12569FF.003D0F79.00@d12mta07.de.ibm.com>
Date: Mon, 26 Feb 2001 11:15:56 +0100
Subject: [PATCH] partitions/ibm.c
Mime-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andries, others,
Thanks for hacking through the code of fs/partitions/ibm.c.
Your patch does not work at all because you are relying on the
data in the part component of the hd structure, which does not
hold the geometry data of the disk but the data of the partitions
on that disk. Besides that, exactly these data are to be set up
by the code in fs/partitions/ibm.c.
The geometry data is stored in the device driver. As in oposition
to the partition schemes the device drivercan be a loadable
module, fs/partitions.c should not at all directly call or use symbols
from the device driver.
My preferred solution would be having partition schemes as
loadable modules, too. Maybe I'll find some time to post the
approriate patch on this list soon...

Regards,
     Holger Smolinski

IBM Germany
Linux/390 Kernel Development
Schönaicher Str.220, D-71032 Böblingen

>Reading patch-2.4.2 I met a strange amount of crap in
>partitions/ibm.c. It is as if the author does not know
>where the kernel keeps the starting offset of a partition,
>and simulates a HDIO_GETGEO ioctl from user space.
>I think the following patch does the same and removes a lot
>of cruft. (Warning: (i) untested, uncompiled; (ii) pasted
>from another window - tabs will have become spaces.)

>Andries


