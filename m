Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQL1ATh>; Wed, 27 Dec 2000 19:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129507AbQL1AT1>; Wed, 27 Dec 2000 19:19:27 -0500
Received: from paloma15.e0k.nbg-hannover.de ([62.159.219.15]:44943 "HELO
	paloma15.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S129210AbQL1ATM>; Wed, 27 Dec 2000 19:19:12 -0500
From: Dieter Nützel <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Nils Philippsen <nils@fht-esslingen.de>
Subject: Re: test13-preX: DRM (tdfx.o) unresolved symbols fixed?
Date: Thu, 28 Dec 2000 00:50:32 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="ISO-8859-15"
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Rik Faith <faith@valinux.com>,
        Dri-devel <Dri-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.30.0012270951360.21331-100000@rhlx01.fht-esslingen.de>
In-Reply-To: <Pine.LNX.4.30.0012270951360.21331-100000@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Message-Id: <00122800503201.00902@SunWave1>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 27. Dezember 2000 11:07 schrieb Nils Philippsen:
> Hi all,
>
> On Wed, 27 Dec 2000, Dieter [iso-8859-1] Nützel wrote:
> > I got this since test13-pre1 (pre4, now):
> >
> > SunWave1>depmod -e
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.4.0-test13-pre4/kernel/drivers/char/drm/tdfx.o
>
> [snipped]
>
> > Something missing in the 'new' drm/Makefile?
>
> From the test13-pre4 patch, the only difference I can see is that shared
> code is now in drmlib.a instead of the object files being linked
> individually for each drm module.

Yep, I saw this, too.

> If I do `nm tdfx.o|grep printk`, with test12 I get only this:
>
>          U printk_R1b7d4074

dito
SunWave1>cd ../../../../../2.4.0-test12-pre7/kernel/drivers/char/drm/
SunWave1>nm tdfx.o | grep printk
         U printk_R1b7d4074

> with test13-pre4 on my home machine, I get the mangled symbol name plus a
> non-mangled one, both unresolved, maybe that causes problems.

SunWave1>cd ../../../../../2.4.0-test13-pre4/kernel/drivers/char/drm/
SunWave1>nm tdfx.o | grep printk
         U printk
         U printk_R1b7d4074

But the strange thing is this:

SunWave1>depmod -e
depmod: *** Unresolved symbols in 
/lib/modules/2.4.0-test13-pre4/kernel/drivers/char/drm/tdfx.o
depmod:         remap_page_range
depmod:         _mmx_memcpy
depmod:         __wake_up
depmod:         mtrr_add
depmod:         __generic_copy_from_user
depmod:         schedule
[snip]

-Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
Cognitive Systems Group
Vogt-Kölln-Straße 30
D-22527 Hamburg, Germany

email: nuetzel@kogs.informatik.uni-hamburg.de
@home: Dieter.Nuetzel@hamburg.de
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
