Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268042AbRHBAfq>; Wed, 1 Aug 2001 20:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268063AbRHBAfg>; Wed, 1 Aug 2001 20:35:36 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:3598 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S268042AbRHBAfX>; Wed, 1 Aug 2001 20:35:23 -0400
Date: Wed, 1 Aug 2001 18:38:21 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Adam Radford <aradford@3WARE.com>
Cc: Scott Ransom <ransom@cfa.harvard.edu>, linux-kernel@vger.kernel.org,
        "'eric@andante.org'" <eric@andante.org>
Subject: Re: 3ware Escalade problems
Message-ID: <20010801183821.A22521@vger.timpanogas.org>
In-Reply-To: <53B208BD9A7FD311881A009027B6BBFB9EADCC@siamese>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <53B208BD9A7FD311881A009027B6BBFB9EADCC@siamese>; from aradford@3WARE.com on Wed, Aug 01, 2001 at 02:13:02PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2001 at 02:13:02PM -0700, Adam Radford wrote:

Adam,

Nice to meet you.  The gendisk head is improperly reporting devices
attached to the 3ware controller.  What I am seeing is drives being 
reported with zero lengths in the block size fields, etc.  This causes
kernel level software to crash and some user space utilities to malfunction.

Please provide your telephone number so I can call you and go over 
these problems.  The driver is also **VERY** unstable on some systems,
and gets all sorts of lost interrupt problems and noisy messages on 
the Serverworks HE chipsets we are using with SCI.

Jeff 


> Jeff,
> 
> The problems this user is seeing with drive timeouts and ECC errors have 
> absolutely nothing to do with 'gendisk support'.
> 
> BTW... would you mind explaining to me what I need to do to have 'gendisk
> support' in the 3ware driver?  greping for 'struct gendisk' in the drivers/
> scsi directory on 2.4.7 shows only sd.c instantiating a struct gendisk.  
> 
> What do the low level drivers need to do?  If there's some missing gendisk
> calls in the 3ware driver, then why don't any other scsi drivers have any 
> instances of struct gendisk ?
> 
> Maybe Eric Youngdale can clarify what you are talking about ?
> 
> BTW, I am the author and maintainer of the 3ware driver.
> 
> --
> Adam Radford
> Software Engineer
> 3ware, Inc.
> 
> -----Original Message-----
> From: Jeff V. Merkey [mailto:jmerkey@vger.timpanogas.org]
> Sent: Wednesday, August 01, 2001 2:40 PM
> To: Scott Ransom
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: 3ware Escalade problems
> 
> 
> On Wed, Aug 01, 2001 at 02:14:44PM -0400, Scott Ransom wrote:
> 
> 
> I am also using 8 way escalade adapters, and am seeing a host of problems.
> The first and foremore is that the gendisk head in 2.4.X is not being 
> initialized properly in the driver.  I have reported these problems to
> 3-ware, and they are attmepting to get the engineer who owns the drivers
> on the line with us.  The problems you are seeing are probably related 
> to the same bugs.  This driver requires some rework to get it compliant
> with 2.4.X.  At present, several programs fail with it since is is not 
> setting up the gendisk head properly.  I do not know if your
> problem is related, but this one will get added to the list when I speak 
> with this person.
> 
> Jeff
> 
> 
> > Hello,
> > 
> > After months of running a fileserver with an 8 port 3ware escalade card
> > (kernels 2.4.[3457] using reiserfs and software RAID5) I started getting
> > problems this weekend.
> > 
> > Over the last three days, when I try to access the drives, after a
> > couple minutes I get a drive failure (I even heard a "yelp" from the
> > drive during one of them...).  But the "failure" has happened to 3 of
> > the 8 drives over 3 days -- so unless there is a hardware problem that
> > is killing my drives I find it hard to believe that 3 drives really and
> > truly failed....
> > 
> > Here is a sample from my syslog of a failure:
> > 
> > 3w-xxxx: tw_interrupt(): Bad response, status = 0xc7, flags = 0x51, unit
> > = 0x1.
> > 3w-xxxx: tw_scsi_eh_reset(): Reset succeeded for card 1.
> > 3w-xxxx: tw_interrupt(): Bad response, status = 0xc7, flags = 0x51, unit
> > = 0x1.
> > scsi: device set offline - not ready or command retry failed after host
> > reset: host 1 channel 0 id 1 lun 0
> > SCSI disk error : host 1 channel 0 id 1 lun 0 return code = 80000
> > I/O error: dev 08:11, sector 158441712
> > 
> > I've noticed several "issues" with the 3ware cards in the archives.  Has
> > anyone seen something like this?
> > 
> > Scott
> > 
> > PS:  I'm currently running 2.4.7 with the lm-sensors/i2c patches.
> > 
> > -- 
> > Scott M. Ransom                   Address:  Harvard-Smithsonian CfA
> > Phone:  (617) 496-7908                      60 Garden St.  MS 10 
> > email:  ransom@cfa.harvard.edu              Cambridge, MA  02138
> > GPG Fingerprint: 06A9 9553 78BE 16DB 407B  FFCA 9BFA B6FF FFD3 2989
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
