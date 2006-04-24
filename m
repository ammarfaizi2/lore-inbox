Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWDXObo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWDXObo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 10:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWDXObo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 10:31:44 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:27842 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750804AbWDXObn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 10:31:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UNa+SJ8dhlc1KUqlyXcdAcnc+A3t9mm4rDAC9X5EGGWEL5gCwVsGznqrLQNato/Kjm366YQiZd1/5C2tqd1+vc1ZHNurjbNkxWtG1uM4Ksx4drWPhP6XLsZhxICN5wVvSqzklpzAk9O3bo78rfNAkUnONQmJUeHXjh1/Obqjai0=
Message-ID: <d120d5000604240731i5a3667f9g37e94de390485aac@mail.gmail.com>
Date: Mon, 24 Apr 2006 10:31:39 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: bjd <bjdouma@xs4all.nl>
Subject: Re: [PATCH 001/001] INPUT: new ioctl's to retrieve values of EV_REP and EV_SND event codes
Cc: linux-kernel@vger.kernel.org, "Vojtech Pavlik" <vojtech@suse.cz>
In-Reply-To: <20060422204844.GA16968@skyscraper.unix9.prv>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060422204844.GA16968@skyscraper.unix9.prv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/06, bjd <bjdouma@xs4all.nl> wrote:
>
> From: Bauke Jan Douma <bjdouma@xs4all.nl>
>

Hi Bauke,

Thank you for your patch.

> Add two new ioctl's to have the input driver return actual current values for
> EV_REP and EV_SND event codes.
>
> Currently there is no ioctl to retrieve EV_REP values, even though they have
> actually always been stored in dev->rep.  A new ioctl, EVIOCGREPCODE,
> retrieves them.
>

EVIOCGREP and EVIOCSREP ioctls are present in 2.4 but they have been
removed during 2.6 development. If you need to get/set repeat delay
and period you need to use KDKBDREP ioctl; it will change the repeat
rate for all keyboards attached to the box.

Vojtech, could you remind me why EVIOC{G|S}REP were removed? Some
people want to have ability to separate keyboards (via grabbing); they
also might want to control repeat rate independently. Shoudl we
reinstate these ioctls?

> The existing EVCGSND ioctl has never returned anything meaningful; the relevant
> fragment in input.c was missing even a change_bit() call.
> The actual EV_SND values are now written in dev->snd.  To make this work,
> dev->snd had to be made an int array, and as a consequence the EVICGSND ioctl
> became problematic.  I have removed it in this diff, but --even though it never
> has returned anything meaningful-- I'm not quite sure that's the right thing to
> do, so I would appreciate feedback on this.
> Anyway, an EVIOCGSNDCODE ioctl was added to retrieve these values.

I think we should just fix EVCGSND and just allow userspace to query
which sound evvects are active fro device - IOW just return bitmap
like we do for keys and leds and switches. I don't think actuall
"value" of the SND_TONE is interesting to anyone.

--
Dmitry
