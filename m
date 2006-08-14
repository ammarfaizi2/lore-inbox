Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWHNPA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWHNPA5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 11:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbWHNPA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 11:00:57 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:156 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932222AbWHNPA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 11:00:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Yf9EEViofE2p1JUrgyO0uB85IMxtLDvhI84Pr4R11My8h6WpaqsWtaFXKSN2ykpu2O6YfCpxLVbFUriqihINbu3bKRr7Ybbg93kmYiiyukqXWuDIDspS5gJAuKhcVr4fu5j6MfcPfhCo+mvZ4KSNfzaIu+xnWBfrd9YPOXJOSv4=
Message-ID: <d120d5000608140800u329b9e9t1984ba19b6464bf1@mail.gmail.com>
Date: Mon, 14 Aug 2006 11:00:55 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Dmitry Torokhov" <dtor@insightbb.com>,
       "=?ISO-8859-1?Q?Magnus_Vigerl=F6f?=" <wigge@bigfoot.com>,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: input: evdev.c EVIOCGRAB semantics question
In-Reply-To: <20060814142826.GD5251@aehallh.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608121724.16119.wigge@bigfoot.com>
	 <20060812165228.GA5255@aehallh.com>
	 <200608122000.47904.dtor@insightbb.com>
	 <20060813032821.GB5251@aehallh.com>
	 <d120d5000608140720o4e8cc039u278fea6ccc0aae07@mail.gmail.com>
	 <20060814142826.GD5251@aehallh.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/06, Zephaniah E. Hull <warp@aehallh.com> wrote:
> On Mon, Aug 14, 2006 at 10:20:09AM -0400, Dmitry Torokhov wrote:
> >
> > I've been thinking about all of this and all of it is very fragile and
> > unwieldy and I am not sure that we really need another ioctl after
> > all. The only issue we have right now is that mousedev delivers
> > undesirable events through /dev/input/mice while there is better
> > driver listening to /dev/input/eventX and they clash with each other.
> > Still, /dev/input/mice is nice for dealing with hotplugging of simple
> > USB mice. So can't we make mousedev only multiplex devices that are
> > not opened directly (where directly is one of mouseX, jsX, tsX, or
> > evdevX)? We could even control this behavior through a module
> > parameter. Then noone (normally) would need to use EVIOCGRAB.
>
> Sadly, the case of using EVIOCGRAB for mice to stop the use of
> /dev/input/mice is actually not the primary usage.
>
> xf86-input-evdev will more or less happily continue talking to a mouse
> that it can't grab, however things become somewhat more problematic when
> it comes to keyboards.
>
> X needs to keep the keyboard driver from receiving events while it has
> it open

Keyboard... can't X just ignore data from old keyboard driver while
evdev-based keyboard driver is used?

-- 
Dmitry
