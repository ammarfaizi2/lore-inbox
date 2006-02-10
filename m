Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWBJXvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWBJXvm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 18:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWBJXvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 18:51:42 -0500
Received: from mail.bytecamp.net ([212.204.60.9]:8457 "HELO mail.bytecamp.net")
	by vger.kernel.org with SMTP id S932237AbWBJXvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 18:51:40 -0500
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
From: Christian Neumair <chris@gnome-de.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Nix <nix@esperi.org.uk>, Jens Axboe <axboe@suse.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <43ED005F.5060804@tmr.com>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
	 <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>
	 <20060125144543.GY4212@suse.de>
	 <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
	 <20060125153057.GG4212@suse.de>
	 <43D7AF56.nailDFJ882IWI@  <43ED005F.5060804@tmr.com>
Content-Type: text/plain
Date: Sat, 11 Feb 2006 00:51:35 +0100
Message-Id: <1139615496.10395.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, den 10.02.2006, 16:06 -0500 schrieb Bill Davidsen:
> The kernel could provide a list of devices by category. It doesn't have 
> to name them, run scripts, give descriptions, or paint them blue. Just a 
> list of all block devices, tapes, by major/minor and category (ie. 
> block, optical, floppy) would give the application layer a chance to do 
> it's own interpretation.

Introducing more than interface for doing the same thing can be very
confusing and counter-productive. You'll create new, undocumented or
semi-documented interfaces which will lead to a dependency chaos.

Some random script will work with kernel 2.6.11, 2.6.12 and 2.6.13, but
not 2.6.14 and later because a new device class was introduced and two
typos were fixed. Especially considering that the new linux development
model makes it likely that major changes go into micro releases,
stability and reliability will be a huge problem.

> HAL is great, but because it's not part of the 
> kernel it's also going to suffer from "tracking error" for some changes. 
> I find it easier to teach someone to use -scanbus than to explain how to 
> make rules for udev.

Tastes are different. I think the HAL semantics are perfectly OK for
doing what you want, i.e. you can use hal-find-by-capability together
with hal-get-property to get the block device paths of the installed
mass storage and for distinguishing them.

Distributors should ship sane udev rules applicable for 99.5% of the
people out there. They do, actually.

> > [...]
> Worth repeating: I find it easier to teach someone to use -scanbus than 
> to explain how to make rules for udev.

> HAL is the right answer,

Nice that we agree on that.

> but *in* the kernel, where it will track changes.

Oh, and BSDs and other target systems of interest for higher-level
libraries and applications don't need libhal? What do we gain by pushing
more and more functionality down the stack right into the kernel,
without guaranteeing ABI/API stability? HAL was developed with
portability in mind, why should one give it up for solving hypothetical
problems, depending on release cycles and patch review by external
projects? I thought the original plan was rather to break the kernel
down and not to make it a melting pot for all kinds of specialized
functionality, which to my impression was originally done because of the
lack of vendor support.

> Since -scanbus tells you a 
> device is a CDrecorder, or something else, *any user* is likely to be 
> able to tell it from DCD, CD-ROM, etc. Nice like of text for most devices...

Well, "any user" just opens his Windows Explorer and takes a look at the
icon of his drive D:\\ to see whether it's a CD-ROM or DVD. It is
interesting to see professional programmers often argue that a
particular solution they like is appropriate for all users without
giving proof. I can't think of a single reason why a user wants to dump
all his devices without knowing the grep semantics, which in turn makes
it very likely that he will write some wrapper code around any of the
currently perfectly working solutions.

-- 
Christian Neumair <chris@gnome-de.org>

