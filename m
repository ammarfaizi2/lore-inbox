Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVGGPZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVGGPZy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 11:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVGGPX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 11:23:58 -0400
Received: from smtp103.rog.mail.re2.yahoo.com ([206.190.36.81]:56720 "HELO
	smtp103.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261429AbVGGPGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 11:06:16 -0400
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: hdaps-devel@lists.sourceforge.net
Subject: Re: [Hdaps-devel] Re: Head parking (was: IBM HDAPS things are looking up)
Date: Thu, 7 Jul 2005 11:06:10 -0400
User-Agent: KMail/1.8.1
Cc: Jens Axboe <axboe@suse.de>, Lenz Grimmer <lenz@grimmer.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Jesper Juhl <jesper.juhl@gmail.com>, Dave Hansen <dave@sr71.net>,
       LKML List <linux-kernel@vger.kernel.org>
References: <42C8C978.4030409@linuxwireless.org> <42CCEAA7.1010807@grimmer.com> <20050707084825.GG1823@suse.de>
In-Reply-To: <20050707084825.GG1823@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507071106.10946.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Model: HTS548080M9AT00 (Hitachi)
Laptop: T42.

segfault:/home/spstarr# ./a /dev/hda
head parked

Seems to park, heard it click :)

Shawn.

On July 7, 2005 04:48, Jens Axboe wrote:
> On Thu, Jul 07 2005, Lenz Grimmer wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Hi,
> >
> > Jens Axboe wrote:
> > > ATA7 defines a park maneuvre, I don't know how well supported it is
> > > yet though. You can test with this little app, if it says 'head
> > > parked' it works. If not, it has just idled the drive.
> >
> > Great! Thanks for digging this up - it works on my T42, using a Fujitsu
> > MHT2080AH drive:
> >
> >   lenz@metis:~/work/ibm_hdaps> sudo ./headpark /dev/hda
> >   head parked
> >
> > Judging from the sound the drive makes, this is the same operation that
> > the windows tool performs.
>
> Very cool, I wasn't sure if this was a 'new' feature waiting to be
> implemented in drives or if ata7 just documented existing use in some
> drives.
>
> How long did the park take? Spec states it can take up to 500ms.
>
> > However, the head does not remain parked for a very long time,
> > especially if there is a lot of disk activity going on (I tested it by
> > running a "find /" in parallel). The head parks, but leaves the park
> > position immediately afterwards again. I guess now we need to find a way
> > to "nail" the head into the parking position for some time - otherwise
> > it may already be on its way back to the platter before the laptop hits
> > the ground...
>
> The head just remains parked until the next command is issued. This
> needs to be combined with some ide help, to freeze the queue. Perhaps
> some sysfs file so you could do
>
> # echo park > /sys/block/hda/device/head_state
>
> Or whatever, at least just exposing this possibility so that the drive
> internally can block future io until a 'resume' command is issued.
