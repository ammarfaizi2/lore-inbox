Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbTELTWa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 15:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTELTW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 15:22:29 -0400
Received: from havoc.daloft.com ([64.213.145.173]:22718 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262591AbTELTWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 15:22:25 -0400
Date: Mon, 12 May 2003 15:35:09 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: "Mudama, Eric" <eric_mudama@maxtor.com>
Cc: "'Jens Axboe'" <axboe@suse.de>, Oleg Drokin <green@namesys.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Oliver Neukum <oliver@neukum.org>,
       lkhelp@rekl.yi.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69, IDE TCQ can't be enabled
Message-ID: <20030512193509.GB10089@gtf.org>
References: <785F348679A4D5119A0C009027DE33C102E0D31D@mcoexc04.mlm.maxtor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <785F348679A4D5119A0C009027DE33C102E0D31D@mcoexc04.mlm.maxtor.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 01:19:36PM -0600, Mudama, Eric wrote:
> >You are ignoring the host side of things. PATA TCQ is basically
> >unsupportable without some hardware support (auto-poll). It's my
> >understanding that all SATA controllers do that.
> 
> The drive is always supposed to generate an interrupt when it sets the
> service bit indicating it is ready to receive a service command.
> 
> The release interrupt tells the host the drive is doing a bus release
> following a queued data command.
> 
> The service interrupt tells you you're going DRQ after receiving the service
> command.

Most Linux people with TCQ drives seem to have Hitachi (nee IBM)
ones AFAICS.  These do not have a service interrupt (or at least,
do not report such)

They do have the release interrupt.


> Maybe there are drives out there that don't support the configuration of
> these interrupts... if that is the case, TCQ will never work "well" with
> them since you'll need to poll on timer ticks or something, resulting in a
> huge performance loss.

yep :)


> >Then there's the debate of whether TCQ is worth it at all, in general. I
> >feel that a few tags just to minimize the time spent when ending a
> >request to starting a new one is nice.
> 
> TCQ shouldn't benefit writes significantly from a performance perspective if
> the drive is reasonably smart.  TCQ *will* have a huge performance
> improvement for random reads since the drive can order responses based on
> minimal rotational latency.

You hit the nail on the head.

With the host interface limitation of a single scatterlist
particularly, writes do not benefit very much at all.  However,
since reads can be queued and buffered internally in the drive,
TCQ will definitely show benefits.

Coming from an OS perspective, I think we really want to be able to
queue up a bunch of scatterlists, like the new AHCI spec does.


> >> Personally I'd like to see the option stay in there as experimental, it
> >> helps us drive folks test stuff when we can just flip an option off/on to
> >> get that functionality.
> >
> >I agree, besides it just needs a bit of fixing, can't be much.
> 
> I'll do what I can to help in my spare time.

Great!  Your knowledge and experience is much appreciated.

Regards,

	Jeff



