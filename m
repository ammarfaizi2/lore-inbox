Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272167AbRHWALr>; Wed, 22 Aug 2001 20:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272166AbRHWALi>; Wed, 22 Aug 2001 20:11:38 -0400
Received: from femail22.sdc1.sfba.home.com ([24.0.95.147]:5087 "EHLO
	femail22.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S272167AbRHWAL1>; Wed, 22 Aug 2001 20:11:27 -0400
Message-ID: <3B844A56.17E764B0@home.com>
Date: Wed, 22 Aug 2001 20:12:06 -0400
From: Willem Riede <wriede@home.com>
X-Mailer: Mozilla 4.7 [en] (X11; U; Linux 2.2.15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ion Badulescu <ionut@cs.columbia.edu>
CC: Nicholas Knight <tegeran@home.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH,RFC] make ide-scsi more selective
In-Reply-To: <Pine.LNX.4.33.0108221757020.17244-100000@age.cs.columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > I've been rather annoyed by a dual problem in the ide-scsi setup:
> > during initialisation, ide-scsi will claim ALL currently unassigned
> > IDE devices. This is a problem in modular setups, since there's
> > no guarantee that currently unassigned devices actually are intended
> > for ide-scsi.
> 
> The real problem is that the drivers are claiming resources on load not
> on open. Why shouldnt I be able to load ide-cd and ide-scsi and open either
> /dev/hda or /dev/sr0 but not both together ?
> 
Ion Badulescu wrote:
> 
> On Wed, 22 Aug 2001, Nicholas Knight wrote:
> 
> > Here's an end-user perspective for you... I just spent 2 days trying to
> > figure out how to use my CD-RW drive to read when using ide-scsi, before
> > I finnaly realized that I had to do it by disabling ATAPI CD support and
> > enabling SCSI CD support..
> 
> Just doing hdX=scsi would have been enough, however. Except it doesn't
> work (currently) if ide-scsi is a module.
> 
Well, at least on my system (RH 7.1) in rc.sysinit there's a fragment
that checks if ide-scsi is asked for and if so loads ide-cd first, so
it can grab CD drives that are not targeted for scsi emulation.

Personally, I've added a modprobe of ide-tape there so that ide-scsi 
can't grab any tape drives it is not supposed to either.

> I agree with Alan that the problem is the grab-on-load strategy that
> ide-scsi (and ide-cd for that matter) uses. I am willing to look into
> changing that to grab-on-open but I'm not sure if the change is an
> appropriate one for a stable series kernel -- it looks pretty non-trivial.
> 
Right. And it is not limited to ide-scsi but impacts drivers that
connect to ide-scsi such as the osst tape driver I maintain which
would have to allow a device to be ht0 and osst0 at the user's choice...

Regards, Willem Riede.
