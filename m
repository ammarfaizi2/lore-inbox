Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262323AbVF2Bdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbVF2Bdi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 21:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVF2B3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 21:29:54 -0400
Received: from free.hands.com ([83.142.228.128]:1185 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S261191AbVF2B2h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 21:28:37 -0400
Date: Wed, 29 Jun 2005 02:37:31 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: accessing loopback filesystem+partitions on a file
Message-ID: <20050629013731.GF9566@lkcl.net>
References: <20050628233335.GB9087@lkcl.net> <Pine.LNX.4.63.0506290228380.7125@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0506290228380.7125@alpha.polcom.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

oh, bugger :)

xen guest OSes manage it fine - the xen layer provides a means to
present any block device as a "disk".

that loopback filesystems cannot be presented as block devices
by the linux kernel (with no involvement of xen) seems to be
a curious omission.

... loopbackblock.ko, anyone?

btw the [as yet formally-unannounced] project is at
http://hands.com/d-i.  try the xen0 install and then follow
the instructions for creating a guest domain [by booting debian
installer in a guest domain, as opposed to running debootstrap,
the "normal" xen recommended method].

fortunately, phil has fixed the xen-guest-install, such that it
completes successfully.

that _still_ leaves a hard-disk-with-its-partitions in an actual LVM
partition which is totally inaccessible.

okay - i _say_ inaccessible: there is always the possibility of finding
a spare hard drive, and then doing "dd if=/dev/vg/xen0hda of=/dev/hdd".

this being 2005 last time i checked, it does seem to me to
be a rather large waste of a) an entire hard drive b) time
spent copying.

*sigh*.

sadly, answers on back of envelope ideally need to involve a
tool or procedure of some sort that can be run by dummies such
as myself on a regular basis without fear of major-cock-up,
rather than something [ending oh say in .pl] that stands a good
chance of being exorcised [or exercised] as voodoo witchcraft.

unmitigated steaming "perl" advocates need not respond.  please.

l.

On Wed, Jun 29, 2005 at 02:35:25AM +0200, Grzegorz Kulewski wrote:

> On Wed, 29 Jun 2005, Luke Kenneth Casson Leighton wrote:
> 
> >[if you are happy to reply at all, please reply cc'd thank you.]
> >
> >hi,
> >
> >i'm really sorry to be bothering people on this list but i genuinely
> >don't what phrases to google for what i am looking for without getting
> >swamped by useless pages, which you will understand why when you see
> >the question, below.
> >
> >the question is, therefore:
> >
> >	* how the hell do you loopback mount (or lvm mount
> >	  or _anything_! something!)  partitions that have
> >	  been created in a loopback'd file!!!!
> >
> >	  [aside from booting up a second pre-installed xen
> >	  guest domain and making the filesystem-in-a-file
> >	  available as /dev/hdb of course.]
> >
> >answers of the form "work out where the partitions are, then use
> >hexedit to remove the first few blocks" will win no prizes here.
> 
> The bad news: it was impossible (or at least very hard to do).
> 
> The good news: it is possible now. The anwser is:
> - figure where the partitions are (possibly using some simple script),
> - use device-mapper to create block devices covering partitions,
> - mount them.
> 
> I do not know if this anwser will win your price but it is IMHO far better 
> than hexedit... :-) And probably this is the only anwser.
> 
> (IIRC if you have one partition you can skip partition table with offset 
> option to losetup. But this will only work in this special case...)
> 
> 
> Grzegorz Kulewski
> 

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--
