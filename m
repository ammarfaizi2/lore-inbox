Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130309AbQK3IPd>; Thu, 30 Nov 2000 03:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131043AbQK3IPY>; Thu, 30 Nov 2000 03:15:24 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:15091 "EHLO
        tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
        id <S130309AbQK3IPJ>; Thu, 30 Nov 2000 03:15:09 -0500
Date: Thu, 30 Nov 2000 02:47:05 -0500 (EST)
From: Scott Murray <scott@spiteful.org>
To: John Fremlin <vii@penguinpowered.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ISA PnP for Yamaha OPL3-SAx sound driver
In-Reply-To: <m2hf4ql8zr.fsf@localhost.yi.org.>
Message-ID: <Pine.LNX.4.21.0011300219160.965-100000@godzilla.spiteful.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Nov 2000, John Fremlin wrote:
> 
> Support for this card is currently broken for people whose BIOS used
> to activate it with ISA PnP, as the kernel now decides to deactivate
> it. On 27 Oct 2000 21:48:44 +0100, I sent the maintainer
> <scott@spiteful.org> and the mailing list
> <linux-sound@vger.kernel.org> this patch, but I didn't get any
> replies.  Other people have written (no doubt better) patches to
> accomplish the same thing, but somehow none have appeared in the Linus
> tree.

As the maintainer in question, I apologize.  I've been remiss in getting
a patch into 2.4 due to being focused on a new job.  My current plan is
to take Friday off and work on getting all of the various fixes people
have sent me glued together into one patch.  I must admit, though, that
I've been running 2.4.0-test kernels for quite some time and have not
had any problems activating my OPL3-SA3 card the old-fashioned way with
isapnp.

> This patch implements ISA PnP probe and activate/deactivate for the
> OPL3-SAx. As I don't have the specs for this card, I only know that it
> works for me; nevertheless, it should not break any configurations as
> the PnP probe only kicks in if the resource parameters are not given
> as module arguments.  

I'd rather that this patch not be applied in its current form, as there are
a few issues to be cleaned up.  For one, the following:

> +	sa2_cfg->io_base = pnp_dev->resource[0].start;

is incorrect.  The first value reported back by the ISA PnP driver is
the port for the unused SoundBlaster Pro implementation, not the SA2/3
control port (which is the 5th value).  Using a port in the SB port range
as the control port probably works most of the time, but there are some
weird laptops with this chipset, and there's a chance some of them might
not work.

Another overlooked issue (common to all the PnP patches I've been sent, I
think) is handling more than one card, as the SB PnP code does.  It would
be a bit of a pain to have to resort back to isapnp and module parms to
configure a second card.

Anyways, as I mentioned above, I'll try to get a more comprehensive patch
done and posted for testing sometime on Friday.

Scott


-- 
=============================================================================
Scott Murray                                        email: scott@spiteful.org
http://www.interlog.com/~scottm                       ICQ: 10602428
-----------------------------------------------------------------------------
     "Good, bad ... I'm the guy with the gun." - Ash, "Army of Darkness"

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
