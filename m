Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285692AbSCRQJO>; Mon, 18 Mar 2002 11:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285850AbSCRQJF>; Mon, 18 Mar 2002 11:09:05 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:62174 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S285692AbSCRQI4>; Mon, 18 Mar 2002 11:08:56 -0500
Date: Mon, 18 Mar 2002 09:08:53 -0700
Message-Id: <200203181608.g2IG8ri19443@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: vda@port.imtp.ilyichevsk.odessa.ua,
        Felix Braun <Felix.Braun@mail.McGill.ca>, linux-kernel@vger.kernel.org
Subject: Re: devfs mounted twice in linux 2.4.19-pre3
In-Reply-To: <Pine.GSO.4.21.0203181057050.14280-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> On Mon, 18 Mar 2002, Richard Gooch wrote:
> 
> > No, I don't think that's the problem. I now also have two devfs
> > entries in /proc/mounts with 2.4.19-pre3. My boot scripts don't mount
> > devfs. I'm looking into the problem. It seems to have something to do
> > with Al's changes to the boot sequence code.
> 
> It has and it will go away when the next series is merged.

Are you talking about this patch:
+++ linux.19pre3-ac1/init/do_mounts.c   Thu Mar 14 23:01:31 2002
@@ -375,7 +375,7 @@
 done:
        putname(fs_names);
        if (do_devfs)
-               sys_umount(".", 0);
+               sys_umount(".", MNT_DETACH);
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD

I tried that and it didn't fix the problem.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
