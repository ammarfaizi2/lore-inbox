Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319172AbSHGSn0>; Wed, 7 Aug 2002 14:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319173AbSHGSn0>; Wed, 7 Aug 2002 14:43:26 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:44943 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S319172AbSHGSnZ>; Wed, 7 Aug 2002 14:43:25 -0400
Subject: Re: i810 sound broken...
From: Juergen Sawinski <juergen.sawinski@mpimf-heidelberg.mpg.de>
To: Doug Ledford <dledford@redhat.com>
Cc: "linux-kernel@vger" <linux-kernel@vger.kernel.org>
In-Reply-To: <20020807110554.D10872@redhat.com>
References: <Pine.LNX.4.43.0208051546120.8463-100000@cibs9.sns.it>
	<1028561325.18478.55.camel@irongate.swansea.linux.org.uk>
	<1028572739.4406.2.camel@frasier>  <20020807110554.D10872@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 07 Aug 2002 20:49:08 +0200
Message-Id: <1028746148.2275.22.camel@voyager>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-07 at 17:05, Doug Ledford wrote:
> On Mon, Aug 05, 2002 at 08:38:52PM +0200, Thomas Munck Steenholdt wrote:
> > On Mon, 2002-08-05 at 17:28, Alan Cox wrote:
> > > On Mon, 2002-08-05 at 14:47, venom@sns.it wrote:
> > > > Still OSS modules for i810 does not work with 2.5 kernels, actually 2.4
> > > > is fine. No time to switch to alsa (and not interested for now too).
> > > 
> > > OSS for 2.5 is someone elses problem. I have no plan to do any work on
> > > the old OSS drivers for the 2.5 tree or even to submit 2.4 updates into
> > > 2.5 for it. 
> > > 
> > 
> > So anyway - How should I go about determining the exact problem on my
> > box... I've had it all along, and I know for a fact that the hardware is
> > OK... Modules are loaded correctly, but it just does not work!
> 
> I'll tell you what you can do.  Grab some ICH docs so you have a list of 
> the valid regs on the i810 sound chip.  Then, go into i810_audio.c and 
> write me up a little hack that, at the end of the chip init sequence, 
> whill dump the state of all the regs on the chip.  Make it smart enough to 
> know about different regs on different chips (aka, Intel ICH0 and ICH1 
> will probably have a slightly different reg setup than the ICH2 and 
> later).  Then, load that driver on your machine and get me that register 
> dump.  Then, I'll take the patch and apply it here on the i810 machines I 
> have that do work and get their register dump.  We'll see then where the 
> differences are.  On the i845 based machine I have at work, where the 
> sound doesn't work just like you describe, I've isolated the problem down 
> to the fact that when we start the DMA engine it *immediately* signals 
> that it has already finished the DMA process and has already stopped again 
> but it never actually does the DMA.  So, I suspect there is some config 
> bit somewhere set wrong and the DMA is not taking place as a result (hell, 
> for all I know, the AC97 link for sound output may be off or something 
> like that).  Getting a register dump from several busted machines as well 
> as from some working machines should enable me to solve the problem 
> relatively easily.  I just haven't had the time to write the patch myself 
> and do any more work on the thing :-(

My i845 box seems to only have a tertiary codec (waiting for
verification from Intel) which is only accesible via DMA. I already
started to make this work... hope, I can show some code end of the week.

But there's sth. about i810_ac97_get. The ICH4 manual says, reads _must
not_ cross DWord boundaries. Could there be a problem? 

> -- 
>   Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
>          Red Hat, Inc. 
>          1801 Varsity Dr.
>          Raleigh, NC 27606
>   
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Juergen Sawinski
Max-Planck-Institute for Medical Research
Dept. of Biomedical Optics
Jahnstr. 29
D-69120 Heidelberg
Germany

Phone:  +49-6221-486-309
Fax:    +49-6221-486-325

priv.
Phone:  +49-6221-418 848
Mobile: +49-171-532 5302

