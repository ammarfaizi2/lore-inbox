Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272216AbRHWE3t>; Thu, 23 Aug 2001 00:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272217AbRHWE3j>; Thu, 23 Aug 2001 00:29:39 -0400
Received: from femail30.sdc1.sfba.home.com ([24.254.60.20]:59585 "EHLO
	femail30.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S272216AbRHWE3d>; Thu, 23 Aug 2001 00:29:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: Ion Badulescu <ionut@cs.columbia.edu>
Subject: Re: [PATCH,RFC] make ide-scsi more selective
Date: Wed, 22 Aug 2001 21:29:08 -0700
X-Mailer: KMail [version 1.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108222350170.18397-100000@age.cs.columbia.edu>
In-Reply-To: <Pine.LNX.4.33.0108222350170.18397-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Message-Id: <01082221284000.00178@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 August 2001 08:54 pm, Ion Badulescu wrote:
> On Wed, 22 Aug 2001, Nicholas Knight wrote:
> > Could you elaborate on this? I almost never use modules for my
> > primary desktop system, SCSI emulation support and SCSI generic
> > driver were both compiled in, and I had "hdc=ide-scsi" and later also
> > tried "hdc=scsi" and
>
> Well, hdc=ide-scsi is for 2.2 and hdc=scsi is for 2.4. Yup, yet another
> of those gratuitious incompatibilities.

tried both, neither worked, even with SCSI CD-ROM support enabled

>
> > I was unable to read from it with any device, /dev/sr0 /dev/sda
> > /dev/scd0 were all dead-ends, but I was able to WRITE just fine... I
> > just don't want to reboot every time I want to write to the drive,
> > nor reboot when I want to READ from it.
>
> I'm not sure why this is happening for you, my CDR drive works for both
> reading and writing using the ide-scsi driver. But it's a known fact
> that ide-scsi is not perfect, so that could explain it.

I've gotten the impression that ide-scsi isn't perfect :)

>
> > Disabling ATAPI CD-ROM support, and enabling SCSI CD-ROM (along with
> > SCSI emulation support and SCSI generic support) worked, and now I
> > just access both my CD-RW drive and my DVD-ROM drive through /dev/sr0
> > and /dev/sr1.
>
> So now you're saying it *does* work with ide-scsi? I'm utterly
> confused...

I'll be more specific:

I've used this in 2.4.8 and 2.4.8-ac9 to read from my IDE/ATAPI CD-RW 
drive while also using it to write to
I now have IDE/ATAPI CD-ROM support DISABLED in the ATA/* menu
SCSI emulation is ENABLED in the ATA/* menu
SCSI CD-ROM support is ENABLED in the SCSI menu
SCSI Generic is ENABLED in the SCSI menu
I do not have any parameters (such as hdX=scsi or ide-scsi) being passed 
to the kernel except those for my SB16 card, which doesn't have any 
devices hooked to its IDE port.

this appears at kernel boot:
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: PLEXTOR   Model: CD-R   PX-W1610A  Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PIONEER   Model: DVD-ROM DVD-113   Rev: 1.08
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 1, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 0x/0x cd/rw xa/form2 cdda tray

using 0,0,0 works for cdrecord, and using /dev/sr0 to mount discs in my 
CD-RW drive and /dev/sr1
using /dev/hdc and /dev/hdd does NOT work now

Without this setup, I've been unable to read from my CD-RW drive while 
it's also setup to write to with SCSI generic.

>
> > My primary concern here is other users who haven't figured this out,
> > I know at least one ATAPI/IDE CD-R(W) in Linux HOWTO tells the user
> > that they'll have to use two seperate kernel images, one to allow
> > reading from their drive and the other for writing, infact that was
> > my original method.
>
> Nope. Ide-scsi should be fine for both reading and writing.

didn't for me
