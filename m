Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272200AbRHWDVO>; Wed, 22 Aug 2001 23:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272201AbRHWDVE>; Wed, 22 Aug 2001 23:21:04 -0400
Received: from pm1-modem15.inet-direct.com ([204.71.22.15]:27522 "HELO NewStar")
	by vger.kernel.org with SMTP id <S272200AbRHWDUy>;
	Wed, 22 Aug 2001 23:20:54 -0400
Date: Wed, 22 Aug 2001 22:42:49 -0500
From: mhobgood@inet-direct.com
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH,RFC] make ide-scsi more selective
Message-ID: <20010822224249.A633@inet-direct.com>
In-Reply-To: <Pine.LNX.4.33.0108221757020.17244-100000@age.cs.columbia.edu> <01082215391200.00490@c779218-a>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <01082215391200.00490@c779218-a>; from tegeran@home.com on Wed, Aug 22, 2001 at 03:39:12PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well,
	I just double checked my system.  Sure enough I'm using ide-scsi
along with hdd="ide-scsi" with lilo.  It grabs hdd, which is my HP-7200
CD-RW and leaves hdc, which is my DVD alone.  I've no trouble at all
in reading or writing to hdd; no different kernel images, nothing.  I
use modules and have them normally loaded at boot time since I routinely
use both drives to read from.  My understanding was that I only needed
the hdd="ide-scsi" in lilo to prevent ATAPI from grabbing all the drives
it found.  BTW, everything pertaining to scsi is a module on this system.

Cordially,
Mike Hobgood


On Wed, Aug 22, 2001 at 03:39:12PM -0700, Nicholas Knight wrote:
> On Wednesday 22 August 2001 03:00 pm, Ion Badulescu wrote:
> > On Wed, 22 Aug 2001, Nicholas Knight wrote:
> > > Here's an end-user perspective for you... I just spent 2 days trying
> > > to figure out how to use my CD-RW drive to read when using ide-scsi,
> > > before I finnaly realized that I had to do it by disabling ATAPI CD
> > > support and enabling SCSI CD support..
> >
> > Just doing hdX=scsi would have been enough, however. Except it doesn't
> > work (currently) if ide-scsi is a module.
> 
> Could you elaborate on this? I almost never use modules for my primary 
> desktop system, SCSI emulation support and SCSI generic driver were both 
> compiled in, and I had "hdc=ide-scsi" and later also tried "hdc=scsi" and 
> 
> I was unable to read from it with any device, /dev/sr0 /dev/sda /dev/scd0 
> were all dead-ends, but I was able to WRITE just fine... I just don't 
> want to reboot every time I want to write to the drive, nor reboot when I 
> want to READ from it.
> 
> Disabling ATAPI CD-ROM support, and enabling SCSI CD-ROM (along with SCSI 
> emulation support and SCSI generic support) worked, and now I just access 
> both my CD-RW drive and my DVD-ROM drive through /dev/sr0 and /dev/sr1.
> 
> My primary concern here is other users who haven't figured this out, I 
> know at least one ATAPI/IDE CD-R(W) in Linux HOWTO tells the user that 
> they'll have to use two seperate kernel images, one to allow reading from 
> their drive and the other for writing, infact that was my original method.
> 
> > I agree with Alan that the problem is the grab-on-load strategy that
> > ide-scsi (and ide-cd for that matter) uses. I am willing to look into
> > changing that to grab-on-open but I'm not sure if the change is an
> > appropriate one for a stable series kernel -- it looks pretty
> > non-trivial.
> >
> > Ion
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
