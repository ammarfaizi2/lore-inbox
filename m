Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVGGIuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVGGIuA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 04:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVGGIs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 04:48:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:41925 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261257AbVGGIrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 04:47:10 -0400
Date: Thu, 7 Jul 2005 10:48:26 +0200
From: Jens Axboe <axboe@suse.de>
To: Lenz Grimmer <lenz@grimmer.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Jesper Juhl <jesper.juhl@gmail.com>, Dave Hansen <dave@sr71.net>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: Head parking (was: IBM HDAPS things are looking up)
Message-ID: <20050707084825.GG1823@suse.de>
References: <42C8C978.4030409@linuxwireless.org> <20050704063741.GC1444@suse.de> <1120461401.3174.10.camel@laptopd505.fenrus.org> <20050704072231.GG1444@suse.de> <1120462037.3174.25.camel@laptopd505.fenrus.org> <20050704073031.GI1444@suse.de> <42C91073.80900@grimmer.com> <20050704110604.GL1444@suse.de> <20050707080323.GF1823@suse.de> <42CCEAA7.1010807@grimmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42CCEAA7.1010807@grimmer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07 2005, Lenz Grimmer wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi,
> 
> Jens Axboe wrote:
> 
> > ATA7 defines a park maneuvre, I don't know how well supported it is 
> > yet though. You can test with this little app, if it says 'head 
> > parked' it works. If not, it has just idled the drive.
> 
> Great! Thanks for digging this up - it works on my T42, using a Fujitsu
> MHT2080AH drive:
> 
>   lenz@metis:~/work/ibm_hdaps> sudo ./headpark /dev/hda
>   head parked
>
> Judging from the sound the drive makes, this is the same operation that
> the windows tool performs.

Very cool, I wasn't sure if this was a 'new' feature waiting to be
implemented in drives or if ata7 just documented existing use in some
drives.

How long did the park take? Spec states it can take up to 500ms.

> However, the head does not remain parked for a very long time,
> especially if there is a lot of disk activity going on (I tested it by
> running a "find /" in parallel). The head parks, but leaves the park
> position immediately afterwards again. I guess now we need to find a way
> to "nail" the head into the parking position for some time - otherwise
> it may already be on its way back to the platter before the laptop hits
> the ground...

The head just remains parked until the next command is issued. This
needs to be combined with some ide help, to freeze the queue. Perhaps
some sysfs file so you could do

# echo park > /sys/block/hda/device/head_state

Or whatever, at least just exposing this possibility so that the drive
internally can block future io until a 'resume' command is issued.

-- 
Jens Axboe

