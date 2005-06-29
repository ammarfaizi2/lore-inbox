Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262262AbVF2BnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbVF2BnF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 21:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbVF2BnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 21:43:00 -0400
Received: from free.hands.com ([83.142.228.128]:9377 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S262317AbVF2Blm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 21:41:42 -0400
Date: Wed, 29 Jun 2005 02:50:30 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: accessing loopback filesystem+partitions on a file
Message-ID: <20050629015030.GG9566@lkcl.net>
References: <20050628233335.GB9087@lkcl.net> <Pine.LNX.4.63.0506290228380.7125@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0506290228380.7125@alpha.polcom.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

okay - i should be clearer.

the thing that is missing, that only xen provides, is the presentation
of another block device as a hard drive.

e.g. /dev/volumegroup/volumename --> /dev/loopblocka
or   /dev/loop0 -> /dev/loopblocka

such that it is possible to then subsequently do this:

fdisk /dev/loopblocka and
mkfs.ext2 /dev/loopblocka1
mount /dev/loopblocka1 -t ext2 /mnt/somewhere

you get the gist.

basically, the thing that is missing (or i can't find it)
from linux is a driver with the ability to present [any] block
devices with their major+minor numbers as a [fsck-]recogniseable
block device with its own major number, with the implicit
ability to create minor numbers within it.

lvm is in its own way a sort of mad-cap over-extended version
of the above, if you think about it carefully and can understand
the sentence.

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
