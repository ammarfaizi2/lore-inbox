Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753333AbWKFQW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333AbWKFQW1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 11:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753363AbWKFQW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 11:22:27 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:45034 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1753333AbWKFQW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 11:22:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=COiF9tAEd8fsKiXEZd6OUjOPK0UACSEadmQXd5l+FJ3FzdcFP1d5/ay+vz/2n8ojad/nGFpFO9DJHFM4BMk0IBjPVGwplyBg57QKbwqoY0Zi3iZ/InrJ7h6I0HZ5EBt8HOklkNAPg+URyHH/tXCuBwhvK0RShVYUnzTNTBHpgio=
Message-ID: <161717d50611060822w11e031ebra8f62d0fc5b02d69@mail.gmail.com>
Date: Mon, 6 Nov 2006 11:22:25 -0500
From: "Dave Neuer" <mr.fred.smoothie@pobox.com>
To: "Dmitry Torokhov" <dtor@insightbb.com>
Subject: Re: [RFT/PATCH] i8042: remove polling timer (v6)
Cc: LKML <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "Vojtech Pavlik" <vojtech@suse.cz>
In-Reply-To: <200611030103.17913.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608232311.07599.dtor@insightbb.com>
	 <161717d50610291520i5076901blf8bf253eba6148cc@mail.gmail.com>
	 <200611030103.17913.dtor@insightbb.com>
X-Google-Sender-Auth: 47223e219a236b82
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/06, Dmitry Torokhov <dtor@insightbb.com> wrote:
> On Sunday 29 October 2006 18:20, Dave Neuer wrote:
> >  Or is it also to
> > make the i8042 driver less racy?
>
> I think we agree that i8042_aux_write() is not racy, do you see any other
> races in i8042?

No, the polling seemed like the big race.

>
> > I ask because I've applied this over
> > (a modified) 2.6.18 on my Compaq Presario X1010us laptop which has
> > been driving me crazy w/ Synaptics problems and keyboard problems
> > (intermittent, but   frequent enough lately that I finally figured I
> > needed to do something about it).
> >
>
> Have you tried limiting Synaptics rate to 40 packets per second (using
> psmouse.rate=40 option)? Some KBD can't handle full Synaptics rate of
> 80 pps; it usually manifests in keyboard troubles.

No, haven't tried that (first I've heard of it, thanks!)

As I said, I have had both keyboard and touchpad problems on this
laptop (formerly more of the former, lately more of the latter);
interestingly, after applying this patch I have had failures much less
frequently (multiple instances of several days w/out failure w/ the
laptop powered on continuously). Also interestingly, and
unfortunately, that may be coincidence; I've discovered a use case
that seems to reliably cause the touchpad to freeze up w/ or w/out the
patch applied (selecting multiple items in modified file list in
EasyTAG). Haven't looked into it yet, on the "hurts when I do this,"
"then don't do that" theory, but when I have time to look at the
EasyTAG code and try to reason about what's happening, I will.

>
> >
> > I don't really know if or how much the races in this driver are
> > contributing to my problems (keyboard getting stuck repeating last
> > key, or ignoring interrupts, or synaptics touchpad freezing, last of
> > which requires cold boot to fix).
>
> You mean even reloading psmouse module can't revive the touchpad?

Correct. Even rebooting doesn't help. Halt. Start.

>
> > Maybe more likely an ACPI thing?
>
> Coudl be.

Hmmmm.

Dave
