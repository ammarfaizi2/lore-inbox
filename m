Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272121AbRHVWkB>; Wed, 22 Aug 2001 18:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272152AbRHVWjv>; Wed, 22 Aug 2001 18:39:51 -0400
Received: from femail27.sdc1.sfba.home.com ([24.254.60.17]:18573 "EHLO
	femail27.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S272121AbRHVWjg>; Wed, 22 Aug 2001 18:39:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: Ion Badulescu <ionut@cs.columbia.edu>
Subject: Re: [PATCH,RFC] make ide-scsi more selective
Date: Wed, 22 Aug 2001 15:39:12 -0700
X-Mailer: KMail [version 1.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mikael Pettersson <mikpe@csd.uu.se>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108221757020.17244-100000@age.cs.columbia.edu>
In-Reply-To: <Pine.LNX.4.33.0108221757020.17244-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Message-Id: <01082215391200.00490@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 August 2001 03:00 pm, Ion Badulescu wrote:
> On Wed, 22 Aug 2001, Nicholas Knight wrote:
> > Here's an end-user perspective for you... I just spent 2 days trying
> > to figure out how to use my CD-RW drive to read when using ide-scsi,
> > before I finnaly realized that I had to do it by disabling ATAPI CD
> > support and enabling SCSI CD support..
>
> Just doing hdX=scsi would have been enough, however. Except it doesn't
> work (currently) if ide-scsi is a module.

Could you elaborate on this? I almost never use modules for my primary 
desktop system, SCSI emulation support and SCSI generic driver were both 
compiled in, and I had "hdc=ide-scsi" and later also tried "hdc=scsi" and 

I was unable to read from it with any device, /dev/sr0 /dev/sda /dev/scd0 
were all dead-ends, but I was able to WRITE just fine... I just don't 
want to reboot every time I want to write to the drive, nor reboot when I 
want to READ from it.

Disabling ATAPI CD-ROM support, and enabling SCSI CD-ROM (along with SCSI 
emulation support and SCSI generic support) worked, and now I just access 
both my CD-RW drive and my DVD-ROM drive through /dev/sr0 and /dev/sr1.

My primary concern here is other users who haven't figured this out, I 
know at least one ATAPI/IDE CD-R(W) in Linux HOWTO tells the user that 
they'll have to use two seperate kernel images, one to allow reading from 
their drive and the other for writing, infact that was my original method.

> I agree with Alan that the problem is the grab-on-load strategy that
> ide-scsi (and ide-cd for that matter) uses. I am willing to look into
> changing that to grab-on-open but I'm not sure if the change is an
> appropriate one for a stable series kernel -- it looks pretty
> non-trivial.
>
> Ion
