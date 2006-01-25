Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWAYWBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWAYWBF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 17:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWAYWBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 17:01:05 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:11367 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751123AbWAYWBD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 17:01:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SbbXFzg8QwUNSobaLREqA6VrXhqKHsKZg1aNhcOkkeB5oGLoOsQmPADEv464bC+ngr6POyRvqTK8HTuAZRkNDhWl4ARYN0TyqCj9z4ERzhYX/yxnRrWhg1t4vsOcb7qRzc9fgbtwsUfZyUZPLHynevAtECllKY+dznmO7GJ7Y9I=
Message-ID: <5a2cf1f60601251401h2cced00ele307636e748b9a7b@mail.gmail.com>
Date: Wed, 25 Jan 2006 23:01:02 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Albert Cahalan <acahalan@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, schilling@fokus.fraunhofer.de,
       matthias.andree@gmx.de
In-Reply-To: <20060125153057.GG4212@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
	 <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>
	 <20060125144543.GY4212@suse.de>
	 <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
	 <20060125153057.GG4212@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/06, Jens Axboe <axboe@suse.de> wrote:
> On Wed, Jan 25 2006, Jan Engelhardt wrote:
> >
> > >
> > >- you don't need -scanbus. If
> > >users think they do, it's either because Joerg brain washed them or
> > >because they have been used to that bad interface since years ago when
> > >it was unfortunately needed.
> >
> > Now you're unfair.
> > -scanbus does a nice output of what cdwriters (and other capable devices)
> > are present. For me, that lists the cd writer and a CF slot from the
> > multitype usb flash reader.
> >
> > There's one kind of not-so-advanced linux newbies that just go to walmart,
> > buy a computer and whack a linux system on it for fun, and they still don't
> > know if their cdrom is at /dev/hdb or /dev/hdc. Looking for dmesg is
> > usually a nightmare for them, and apart that -scanbus lists scsi
> > host,id,lun instead of /dev/hd* (don't comment on this kthx), it is
> > convenient for this sort of users to find out what's available.
> >
> > So, and what about that compactflash reader? It is subject to dynamic
> > usb->scsi device association (depending on when you connect it, it may
> > either become sda, or sdb, or sdc, etc.), and -scanbus yet again provides
> > some way (albeit not useful, because it lists scsi,id,lun rather than
> > /dev/sd* - don't comment either) to see where it actually is.
>
> You just want the device naming to reflect that. The user should not
> need to use /dev/hda, but /dev/cdrecorder or whatever. A real user would
> likely be using k3b or something graphical though, and just click on his
> Hitachi/Plextor/whatever burner. Perhaps some fancy udev rules could
> help do this dynamically even.
>
> If you are using cdrecord on the command line, you are by definition an
> advanced user and know how to find out where that writer is.
>
> --
> Jens Axboe

As an non expert who just wants his boxes to work out of the box, I
feel that the above message best represents the issue at end.



Joerg seems to be concerned by 2 things:
- the portability of his application accross various platforms
- provide an end-to-end application for writing CDs from both the
command line and to various 3rd party front ends.

Providing a cross platform way to reference the devices seems to help
him achieve that goal.


Linux developers seem to see the world in a different way. Their main
requirements:
- compliance with the linux way of doing things
- ultimately a front end should hide all the dirty details. That
doesn't mean a command line version has to hide them as well, nor that
cdrecord should be the interface to ask things the operating system
can provide

So it looks like:
- from a cdrecord point ov view, Linux is broken.
- from a Linux developers point of view, cdrecord is doing too much
and forces things up.



<very naively>

As a developper with absolutely no competence in this area, I wonder
something: I don't see why the way to refer to a device affects the
ability to perform the functionality (write to it).

Isn't it possible to reorganize the code in such a way that the
burning part can be independent of the way the devices are referred
to?

I downloaded the code and quickly looked at it. If I am looking at the
right version, it seems that the cdrecord code that relates to both cd
burning + the Linux specific part is not that big (and very readable,
thanks Joerg). So I really don't understand why this issue doesn't get
fixed.

</very naively>



As with the communication problems between Joerg and the Linux
developers, if someone was stepping up to be the bridge betweem the 2
parties, couldn't that minimize the risk of flame wars?

cdrecord, how important is Linux to you?
Linux, how important is cdrecord to you?

If you 2 can't get along, just divorce! It's 2006 after all. And the
code is open.
Otherwise, talk together or use a counsellor and make this relationship work.

Jerome
