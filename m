Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751488AbWHNQWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbWHNQWF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 12:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWHNQWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 12:22:05 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:37108 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751488AbWHNQWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 12:22:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=ZtlFdhD2m/lik37KKT50tksiMrTWbde7HVZdYPP6tyJuAbFCk0ViI8CMZg0mKrAf4pPNhzCcYuBmBlqlg3UcN1VnM2TzIQL8h7J7w2GBeze30WG+lN1RTM+a9TzakhVuLhjXukIlsU7cVJnnwrwwR5bxIOO6Si+D76RJYkxFaNs=
Message-ID: <d120d5000608140922y17e0cf07y41076c02f826850c@mail.gmail.com>
Date: Mon, 14 Aug 2006 12:22:01 -0400
From: "Dmitry Torokhov" <dtor@insightbb.com>
To: "Dmitry Torokhov" <dtor@insightbb.com>,
       "=?ISO-8859-1?Q?Magnus_Vigerl=F6f?=" <wigge@bigfoot.com>,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: input: evdev.c EVIOCGRAB semantics question
In-Reply-To: <20060814160927.GB5255@aehallh.com>
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
	 <d120d5000608140800u329b9e9t1984ba19b6464bf1@mail.gmail.com>
	 <20060814160927.GB5255@aehallh.com>
X-Google-Sender-Auth: 33d9223d445600b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/06, Zephaniah E. Hull <warp@aehallh.com> wrote:
> On Mon, Aug 14, 2006 at 11:00:55AM -0400, Dmitry Torokhov wrote:
> > On 8/14/06, Zephaniah E. Hull <warp@aehallh.com> wrote:
> > >On Mon, Aug 14, 2006 at 10:20:09AM -0400, Dmitry Torokhov wrote:
> > >>
> > >> I've been thinking about all of this and all of it is very fragile and
> > >> unwieldy and I am not sure that we really need another ioctl after
> > >> all. The only issue we have right now is that mousedev delivers
> > >> undesirable events through /dev/input/mice while there is better
> > >> driver listening to /dev/input/eventX and they clash with each other.
> > >> Still, /dev/input/mice is nice for dealing with hotplugging of simple
> > >> USB mice. So can't we make mousedev only multiplex devices that are
> > >> not opened directly (where directly is one of mouseX, jsX, tsX, or
> > >> evdevX)? We could even control this behavior through a module
> > >> parameter. Then noone (normally) would need to use EVIOCGRAB.
> > >
> > >Sadly, the case of using EVIOCGRAB for mice to stop the use of
> > >/dev/input/mice is actually not the primary usage.
> > >
> > >xf86-input-evdev will more or less happily continue talking to a mouse
> > >that it can't grab, however things become somewhat more problematic when
> > >it comes to keyboards.
> > >
> > >X needs to keep the keyboard driver from receiving events while it has
> > >it open
> >
> > Keyboard... can't X just ignore data from old keyboard driver while
> > evdev-based keyboard driver is used?
>
> The problem is that without xf86-input-keyboard X ignores the keyboard
> entirely, which means that the console driver gets it, so ctrl-C sends
> signals, alt-F<n> switches consoles on you, etc.
>
> Additional code to open the console, put the keyboard in raw mode, and
> throw everything away would be problematic for a few reasons, one of
> which being that people have managed, with grab, to keep X from being
> attached to an actual console. (Used for multiple X sessions running at
> once for instance.)
>
> It also would mean that xf86-input-evdev would have to touch stuff that
> otherwise it wouldn't have to come anywhere near.
>

I can see that. Unfortunately any form of "grabbing" just makes it all
worse in the long run. The problem is that some programs rely on X to
deliver events while others use device nodes (eventX, mouseX, or
super-new blahX) for their data. When X server grabs the devices it
interferes with other programs running on the same box making them
dependent on X configuration. I have the feeling that best course
would be for X to work out its own input handling and any
filtering/asking that is necessary.

-- 
Dmitry
