Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030298AbWAGBUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbWAGBUO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 20:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbWAGBUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 20:20:13 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:16946 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030298AbWAGBUM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 20:20:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dwNNn2OP0b/N/wygL/3i+Tn4iDu7n+ficBEkCQczyZhHfBzmR0JizfvPBXUOxJ4EoX7ttZ587EokBoD6LNi1TUy1s7x9GvdmjLeo9Gk8Aoec4kLV9b+LXdognybrCLqpIDLOcS2DXrfLhQV+kZDOqQ2PTaDnYT7TyAvUPcQy8d0=
Message-ID: <9a8748490601061720k228eec1dr2afcfdc7ece6c862@mail.gmail.com>
Date: Sat, 7 Jan 2006 02:20:11 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       jesper.juhl@gmail.com, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, airlied@linux.ie
Subject: Re: 2.6.15-mm1 - locks solid when starting KDE (EDAC errors)
In-Reply-To: <20060107005712.GF9402@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490601051552x4c8315e7n3c61860283a95716@mail.gmail.com>
	 <20060105162714.6ad6d374.akpm@osdl.org>
	 <9a8748490601051640s5a384dddga46d8106442d10c@mail.gmail.com>
	 <20060105165946.1768f3d5.akpm@osdl.org>
	 <9a8748490601061625q14d0ac04ica527821cf246427@mail.gmail.com>
	 <20060107002833.GB9402@redhat.com>
	 <20060106164012.041e14b2.akpm@osdl.org>
	 <20060107005712.GF9402@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/06, Dave Jones <davej@redhat.com> wrote:
> On Fri, Jan 06, 2006 at 04:40:12PM -0800, Andrew Morton wrote:
>  > Dave Jones <davej@redhat.com> wrote:
>  > >
>  > > On Sat, Jan 07, 2006 at 01:25:22AM +0100, Jesper Juhl wrote:
>  > >  > On 1/6/06, Andrew Morton <akpm@osdl.org> wrote:
>  > >  > > Jesper Juhl <jesper.juhl@gmail.com> wrote:
>  > >  > >
>  > >  > > >  Reverted that one patch, then rebuild/reinstalled the kernel
>  > >  > > >  (with the same .config) and booted it - no change. It still locks up
>  > >  > > >  in the exact same spot.
>  > >  > > >  X starts & runs fine (sort of) since I can play around at the kdm
>  > >  > > >  login screen all I want, it's only once I actually login and KDE
>  > >  > > >  proper starts that it locks up.
>  > >  > >
>  > >  > > Oh bugger.  No serial console/netconsole or such?
>  > >  > >
>  > >  > > Or are you able log in and then quickly do the alt-ctrl-F1 thing, see if we
>  > >  > > get an oops?
>  > >  > >
>  > >  > I switched to tty1 right after logging in, and after a few seconds
>  > >  > (corresponding pretty well with the time it takes to hit the same spot
>  > >  > where it crashed all previous times) I got a lot of nice crash info
>  > >  > scrolling by.
>  > >  > Actually a *lot* scrolled by, a rough guestimate says some 4-6 (maybe
>  > >  > more) screens scrolled by, and since the box locks up solid I couldn't
>  > >  > scroll up to get at the initial parts :(  So all I have for you is the
>  > >  > final block - hand copied from the screen using pen and paper
>  > >  > ...
>  > >  > It never makes it to the logs, and as mentioned previously I don't
>  > >  > have another machine to capture on via netconsole or serial, so if you
>  > >  > have any good ideas as to how to capture it all, then I'm all ears.
>  > >
>  > > If only someone did a patch to pause the text output after the first oops..
>  > >
>  > > Oh wait! Someone did!
>  > >
>  >
>  > umm, it'd be more helpful if you'd actually sent the patch so Jesper could
>  > apply it so we can find this bug.
>  >
>  > I think I did one of those too.  It required a new kernel boot option
>  > `halt-after-oops' or some such.  Sounds like a good idea?
>
> I thought Jesper had made a comment in that thread, so was aware of it.
> Looking at the archive, I see was mistaken.
>
Nope, you are were not mistaken, I did make a comment in that thread
(http://lkml.org/lkml/2006/1/5/204), but that thread had completely
slipped my mind, thank you for the reminder.

> Jesper: http://lkml.org/lkml/2006/1/4/534
> (unmunged diff is at http://lkml.org/lkml/diff/2006/1/4/534/1)
>
Thanks, I'll apply that (and raise the timeout somewhat, since 2min is
far from enough time for me to write down an entire Oops by hand -
wouldn't it be better if it simply spun in a loop until some magic key
(like enter, esc, break or something) is pressed? Then you have all
the time you might need).

I'll hopefully post a "first Oops" in a little while - stay tuned ;)

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
