Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311424AbSDXNBw>; Wed, 24 Apr 2002 09:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311936AbSDXNBv>; Wed, 24 Apr 2002 09:01:51 -0400
Received: from uvo1-29.univie.ac.at ([131.130.231.29]:3968 "EHLO server.lan")
	by vger.kernel.org with ESMTP id <S311424AbSDXNBu>;
	Wed, 24 Apr 2002 09:01:50 -0400
From: Melchior FRANZ <a8603365@unet.univie.ac.at>
To: Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.5.9 -- OOPS in IDE code (symbolic dump and boot log included)
Date: Wed, 24 Apr 2002 15:01:35 +0200
User-Agent: KMail/1.4.5
In-Reply-To: <20020423205601.A21267@rushmore> <3CC669BC.8090208@evision-ventures.com>
X-PGP: http://www.unet.univie.ac.at/~a8603365/melchior.franz
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200204241501.35845@pflug3.gphy.univie.ac.at>
Content-Type: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Martin Dalecki -- Wednesday 24 April 2002 10:15:
> Could you please introduce two printk("BANG\n") printk("BOOM\n")
> aroung the ata_ar_get() in ide-cd? Just to see whatever the
> command queue is already up and initialized.

I mentioned already yesterday, that I have exactly the same oops.
So I added several printk's and found out that it isn't really the
if-branch with the ata_ar_get, that is executed immediately before
the oops. (Neither of your suggested messages is reached.)
   It's rather that ide_cdrom_do_request is entered with rq->falgs=0x420
and hence the following branch called:

        } else if (rq->flags & (REQ_PC | REQ_SENSE)) {
                return cdrom_do_packet_command(drive);

m.



BTW: I'm using the same VIA IDE PIC controller like Randy. But it
   worked with all stable releases and all unstable until 2.5.9.

