Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265490AbUGMTS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265490AbUGMTS6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 15:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265807AbUGMTS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 15:18:58 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:34176 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265490AbUGMTSw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 15:18:52 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Tim Bird <tim.bird@am.sony.com>, Adam Kropelin <akropel1@rochester.rr.com>
Subject: Re: [PATCH] preset loops_per_jiffy for faster booting
Date: Tue, 13 Jul 2004 21:24:47 +0200
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
       karim@opersys.com, linux-kernel@vger.kernel.org,
       celinux-dev@tree.celinuxforum.org, tpoynor@mvista.com
References: <40EEF10F.1030404@am.sony.com> <20040712153248.A3743@mail.kroptech.com> <40F313A6.909@am.sony.com>
In-Reply-To: <40F313A6.909@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407132124.47773.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Tuesday 13 of July 2004 00:41, Tim Bird wrote:
> Adam Kropelin wrote:
> > On Mon, Jul 12, 2004 at 11:52:44AM -0700, Tim Bird wrote:
> >>Adam Kropelin wrote:
> >>>Here's a patch. It places the relevant information on the same line as
> >>>bogomips and does so without encouraging anyone to fiddle with
> >>>loops_per_jiffy and screw up their kernel.
> >>
> >>The patch is missing the Kconfig piece.  Is the wording the
> >>same as from your earlier patch?
> >
> > Andrew requested that the config option be removed, so there are no
> > longer any changes to Kconfig.
>
> Oh - I missed the change where preset_lpj is no longer initialized
> from CONFIG_PRESET_LPJ.  I see it now.  I saw the comment from
> Andrew, but thought he was talking about the first version of the
> patch that had ifdefs.
>
> Here's what Andrew Morton said:
> > a) I don't see much point in making it configurable.  Just add the boot
> >    option and be done with it.  The few hundred bytes of extra code will
> > be dropped from core anyway.
> >
> >    The main reason for this is that most people won't turn on the config
> >    option, so your new code could get accidentally broken quite easily.
> >    Plus it removes some ifdefs.
>
> I have one or two arguments in favor of keeping the config option.
> First, for embedded systems it is sometimes necessary to compile-in
> the value. Unfortunately, not all architectures allow the
> kernel command line to be compiled in. (It would be nice if they did,
> but that's something to fix separately.)

Many do (i.e. arm, h8300, mips, ppc, sh) and IMHO it is better
to fix it separately where needed.

> The first restructuring of the patch that you did, I think addresses
> the issues that Andrew raised.  There are now no ifdefs, and since the
> core code doesn't drop away (and indeed can be turned on at boot time
> if needed), I think the code is not susceptible to accidental breakage
> like the first version was.  I think Andrew is right that the preset
> code path won't get much testing outside of embedded circles, so it is
> important that it be as simple as possible.
>
> The only *code* change from the configurable to the config-less version
> of the code is:
>
> +static unsigned long preset_lpj = CONFIG_PRESET_LPJ;
>    vs.
> +static unsigned long preset_lpj;

with the latter statement 'preset_lpj' ends up in BSS instead of data section
;-)

> Secondly, I was hoping to get the FASTBOOT menu in the kernel, because
> CELF has a few more patches to submit that have the same theme as this
> one.  (I realize this is not justification for making this option
> configurable, per se.  If we need to push for this on a subsequent patch,
> that's OK.)

Separate patch please if/when needed.

