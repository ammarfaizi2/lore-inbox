Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317258AbSHTTtp>; Tue, 20 Aug 2002 15:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317264AbSHTTto>; Tue, 20 Aug 2002 15:49:44 -0400
Received: from ext-ch1gw-3.online-age.net ([216.34.191.37]:1446 "EHLO
	ext-ch1gw-3.online-age.net") by vger.kernel.org with ESMTP
	id <S317258AbSHTTtn> convert rfc822-to-8bit; Tue, 20 Aug 2002 15:49:43 -0400
Message-ID: <A9713061F01AD411B0F700D0B746CA6802FC1464@vacho6misge.cho.ge.com>
From: "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>
To: "'Padraig Brady'" <padraig.brady@corvil.com>
Cc: "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'andre@linux-ide.org'" <andre@linux-ide.org>,
       "Warner, Bill (IndSys, GEFanuc, VMIC)" <Bill.Warner@gefanuc.com>
Subject: RE: IDE-flash device and hard disk on same controller
Date: Tue, 20 Aug 2002 15:52:05 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Heater, Daniel (IndSys, GEFanuc, VMIC) wrote:
> > The IDE driver, file ide-probe.c currently contains this 
> test do prevent
> > hard drives and IDE-flash devices (ex CompactFlash) from 
> co-existing on the
> > same IDE controller. 
> > 
> >         /*
> >          * Prevent long system lockup probing later for non-existant
> >          * slave drive if the hwif is actually a flash 
> memory card of some
> > variety:
> >          */
> >         if (drive_is_flashcard(drive)) {
> >                 ide_drive_t *mate =
> > &HWIF(drive)->drives[1^drive->select.b.unit];
> >                 if (!mate->ata_flash) {
> >                         mate->present = 0;
> >                         mate->noprobe = 1;
> >                 }
> >         }
> > 
> > This test's assumption that a spinning hard drive cannot 
> coexist on the same
> > controller as an IDE-flash device is incorrect.  I have a 
> working setup with
> > such a configuration.  I don't think that the IDE subsystem 
> should punish
> > everyone because _some_ hardware cannot tolerate this configuration.
> > 
> > One solution may be to remove this test from the IDE 
> subsystem and force
> > users with buggy hardware to explicitly  disable probing 
> for a second
> > device.  I think the parameters hdx=none or hdx=noprobe 
> should work for
> > them.
> > 
> > Comments??
> 
> Mentioned several times (and there is a workaround), see:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=100446144028502&w=2
> 
> I really think some of the default CF logic is bogus.
> 
> Pádraig.
> 


OK. hdc=flash works where hdc=hard drive and hdd=CompactFlash.

Thanks Padraig.

I guess it's 6 of one, half-dozen the other, but telling the kernel that my
hard drive is a flash drive just makes me feel squidgy!  I'm still inclined
to suggest that the test that _prevents_ hard drive + CF configuration is no
longer appropriate now that _some_ (most??) hardware vendors have figured
out how to get ide-flash devices to work without "hanging" when no second
device is present. Users with incompatible hardware can still prevent the
long system hang by using hdx=none.

I also used this workaround (hdb=flash) to configure a system with hda=flash
and hdb=cdrom.  This seems to work also.  Are there any side effects to
telling the kernel that the hard drive or cdrom is a flash device (such as
marking it removable or not marking it removable)?
