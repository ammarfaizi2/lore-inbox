Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263301AbUEROHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263301AbUEROHv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 10:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbUEROHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 10:07:51 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:56228 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263301AbUEROHr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 10:07:47 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "O.Sezer" <sezero@superonline.com>
Subject: Re: [PATCH 2.4] decrypt/update ide help entries
Date: Tue, 18 May 2004 16:09:04 +0200
User-Agent: KMail/1.5.3
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
References: <40A8F0E7.4000807@superonline.com> <200405172020.36892.bzolnier@elka.pw.edu.pl> <40AA12E2.1070900@superonline.com>
In-Reply-To: <40AA12E2.1070900@superonline.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-9"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405181609.04045.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 of May 2004 15:42, O.Sezer wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > This patch was disccussed long time ago and nobody cared to correct it.
>
> Hmm.. too many errors, careless duplicate entries.. ...
> too many trust in trusted trees.. Me embarassed ;)

hehe

> > +  "Override-Enable UDMA for Promise Contr." (or "Special UDMA Feature")
> > +  to force UDMA mode for connected UDMA capable disk drives.
> >
> >  It is about forcing burst UDMA transfers not UDMA mode.
>
> Fixed

OK

> > +PROMISE PDC202{68|69|70|71|75|76|77} support
> > +CONFIG_BLK_DEV_PDC202XX_NEW
>
> [...]
>
> > This is just copied from CONFIG_BLK_DEV_PDC202XX_OLD
> > ('Ultra33') and probably is incorrect for newer Promise controllers.
>
> Removed the old copied one wrote something generic

OK

> > +  You need to say Y here if you have a PDC20276 IDE interface but either
> > +  you do not have a RAID disk array, or you wish to use the Linux
> > +  internal RAID software (/dev/mdX).
> >
> > This is needed not only for PDC20276.
>
> I think this time I took the correct chipset names upon reading
> pdc202XX_old.h and pdc202XX_new.h. Please check.

OK

> > +  You need to say N here if you wish to use your Promise controller to
> > +  control a FastTrak RAID disk array, and you you must also say Y to
> > +  CONFIG_BLK_DEV_ATARAID_PDC.
> >
> > This is incorrect.
> >
> > You must say Y to this option and to CONFIG_BLK_DEV_ATARAID_PDC.
>
> Whoops, sorry. Fixed.

+  Setting this option causes the kernel to use your Promise IDE disk
+  controller as an ordinary IDE controller, rather than as a FastTrak
+  RAID controller (RAID is a system for using multiple physical disks
+  as one virtual disk).
+
+  You need to say Y here if you have one of the above mentioned IDE
+  interfaces,  but either you do not have a RAID disk array,  or you
+  wish to use the Linux internal RAID software (/dev/mdX).
+
+  If you wish to use your Promise controller to control a FastTrak
+  RAID disk array, you need to say Y here AND you you must also say Y
+  to CONFIG_BLK_DEV_ATARAID_PDC.

This sounds awful. ;-)

Use controller even if marked as disabled by BIOS
CONFIG_PDC202XX_FORCE

Say Y unless you want to use Promise proprietary RAID driver.

Makes a lot more sense IMHO.
BTW it needs to be split-up for old and new driver (hint, hint!).

> > If you want to correct Promise IDE help entries, do it for 2.6 first.
>
> Don't know much about 2.6; if you can review this one, I can make
> similar changes for 2.6 (in case options didn't change much).

No, they are the same (see drivers/ide/Kconfig).

Thanks,
Bartlomiej

