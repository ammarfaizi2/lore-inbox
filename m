Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267802AbTAHNqv>; Wed, 8 Jan 2003 08:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267804AbTAHNqv>; Wed, 8 Jan 2003 08:46:51 -0500
Received: from users.linvision.com ([62.58.92.114]:28317 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S267802AbTAHNqs>; Wed, 8 Jan 2003 08:46:48 -0500
Date: Wed, 8 Jan 2003 14:55:03 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: krushka@iprimus.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: File system corruption
Message-ID: <20030108145503.F25712@bitwizard.nl>
References: <0301062138130A.01466@paul.home.com.au> <1041865580.17472.17.camel@irongate.swansea.linux.org.uk> <20030107130832.A4953@bitwizard.nl> <03010821353200.01198@paul.home.com.au> <1042035305.24099.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042035305.24099.13.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 02:15:06PM +0000, Alan Cox wrote:
> On Wed, 2003-01-08 at 11:35, Paul wrote:
> > What I have found is that just after the start of a sector, usually 43 to 45 
> > bytes, 6 bytes are skipped and the sequence starts again.  This continues 
> > until the next sector starts, where the sequence corrects.  This appears to 
> > happen every 65536 bytes or some multiple of 65536.  It may skip three blocks 
> > of 65536 and then corrupt on the next block of 65536 bytes.
> 
> Ok that I'm afraid bears no resemblance to anything the software side
> does (we write in chunks but we do single PIO block transfers of each
> sector). 

After examining the resulting image, Paul has a "clock" line to his
flash device that is a bit noisy. This occasionally causes one
16-bit entity to be clocked into the device twice. 

To detect this going wrong, we could (but only as a configurable 
option), write 255 16-bit words to the device (remember this is PIO!), 
check that DRQ is still active and only then write the last word. 
(at which point DRQ should go inactive). 

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currently in such an      * 
* excursion: The stable situation does not include humans. ***************
