Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWBMPY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWBMPY6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 10:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWBMPY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 10:24:58 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:38211 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750806AbWBMPY5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 10:24:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tyTRZmDEbrecTlEa3GtHbZIfmkYEnAkg60AXKFR2884gEt1/GZ/MC9loGkNHOPv3ccPRq0lWW+LgyFLOy8AHjGky3Fop05Oqj+Tt3fYAPkmbry21jSU8XPrWMW0Cb/CX/+EYl8Qg8YCVwOcHuZ0y6+mQrXaReyLIZcA0/0FxOVQ=
Message-ID: <5a2cf1f60602130724n7b060e29r57411260b04d5972@mail.gmail.com>
Date: Mon, 13 Feb 2006 16:24:55 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Cc: peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de, dhazelton@enter.net
In-Reply-To: <43F0A010.nailKUSR1CGG5@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060208162828.GA17534@voodoo>
	 <20060210114721.GB20093@merlin.emma.line.org>
	 <43EC887B.nailISDGC9CP5@burner>
	 <200602090757.13767.dhazelton@enter.net>
	 <43EC8F22.nailISDL17DJF@burner>
	 <5a2cf1f60602100738r465dd996m2ddc8ef18bf1b716@mail.gmail.com>
	 <43F06220.nailKUS5D8SL2@burner>
	 <5a2cf1f60602130407j79805b8al55fe999426d90b97@mail.gmail.com>
	 <43F0A010.nailKUSR1CGG5@burner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> jerome lacoste <jerome.lacoste@gmail.com> wrote:
>
> > > The output of cdrecord -scanbus is already parsable,
> >
> > But it doesn't show the OS specific mapping.
> >
> > > so what is your point?
> >
> > I am aiming for a compromise.
> >
> > My point is that people want to use dev=/dev/hdc in their interface,
> > because that's what they are used to. That's a point that I think you
> > cannot deny.
> >
> > If you want to still keep your dev=b,t,l command line interface, just
> > let the users know how your mapping is done. That will allow a
> > cdrecord wrapper to first query the mapping, then using this mapping
> > information and OS specific information (e.g. links) identify the
> > b,t,l expected by your interface.
> >
> > That way you have mostly no code change to do. And you keep your b,t,l
> > naming. Everybody is happy.
> >
> > I've added something like:
> >
> >                 fprintf(stdout, "%d,%d,%d <= /dev/%s\n",
> >                               first_free_schilly_bus, t, l, token[ID_TOKEN_SUBSYSTEM] );
> >
> > in scsi-linux-ata.c and it does what I want.
>
> The scanbus code was taken from "sformat".
>
> Sformat already includes such a mapping if you are on Solaris.
> Unfortunately this does cleanly work on Linux and for this
> reason is did not make it into cdrecord.

Jorg,

thanks for your answer.

I fail to understand how it is connected to my proposal. Maybe we
misunderstood each other.

I assume that you refer to the sformat/fmt.c implementation (sformat
3.5) being reproduced in cdrecord/scsi_scan.c (latest cdrtools).

Could you please elaborate on:
- what does the sformat scanbus code has to do with my proposal, whose
changes would mostly be located in the libscg modules, not in the
cdrecord module

- why 'it' doesn't clearly work on Linux. cdrecord clearly creates
this os specific to b,t,l mapping (e.g. in scsi-linux-ata.c,
scsi-wnt.c etc..). Why this mapping cannot be publicised in a
parseable format?

Jerome, still looking for a compromise.
