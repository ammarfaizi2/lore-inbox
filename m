Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264377AbUFXQMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUFXQMU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 12:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265955AbUFXQMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 12:12:20 -0400
Received: from mail.jambit.com ([62.245.207.83]:29456 "EHLO mail.jambit.com")
	by vger.kernel.org with ESMTP id S264377AbUFXQLd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 12:11:33 -0400
Message-ID: <00b801c45a05$e22be3c0$c100a8c0@wakatipu>
From: "Michael Kerrisk" <mtk-lists@jambit.com>
To: "Oleg Drokin" <green@linuxhacker.ru>,
       "Michael Kerrisk" <mtk-lists@jambit.com>
Cc: <linux-kernel@vger.kernel.org>, "Hans Reiser" <reiser@namesys.com>,
       "Vladimir Saveliev" <vs@namesys.com>, "Chris Mason" <mason@suse.com>,
       "mk" <michael.kerrisk@gmx.net>
References: <041c01c45875$0368e340$c100a8c0@wakatipu> <200406231111.i5NBBFwF201534@car.linuxhacker.ru> <005e01c459f7$6a8546d0$c100a8c0@wakatipu> <20040624155840.GG2362@linuxhacker.ru>
Subject: Re: Strange NOTAIL inheritance behaviour in Reiserfs 3.6
Date: Thu, 24 Jun 2004 18:11:18 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Jun 24, 2004 at 04:27:44PM +0200, Michael Kerrisk wrote:
> > >
> > > MK>     # mount -t reiserfs /dev/hda12 /testfs
> > > Does it work as expected if you add "-o attrs" to the mount command?
> > Yes!  Thanks.  However, it is a little unfortunate that if one fails
> > to use this option, then:
> > 1. "chattr +t" (and I suppose underlying ioctl()s) can still be used to
> >    set this attribute on a directory, without any error resulting.
> >    It would be better if an error is reported.
>
> Well, initial idea was to allow people to at least reset attributes
> in case of operationg with disabled attributes processing.

This seems to a bad idea.  Why should I be able to reset
attributes if the FS is mounted without "-o attrs"?  That
seems to thwart the point of excluding "-o attrs".  In any
case, how about at least an error when one tries to *set*
attributes when "-o attrs" was specified?

> > 2. The attribute is then inherited by files created in that directory,
> >    but has no effect.
>
> Yes, attribute inheritance is working. The only part that is disabled
> by default is copying from fs-specific attribute storage to actual VFS
inode
> attributes.
>
> > 3. A later explicit "chattr + t" on the files themselves DOES result in
> >    unpacking of the tails.  Why?
>
> There is a check in attributes setting code (and attributes
setting/cleaning
> is enabled), that tests if NOTAIL attribute is set, that calls tails
> unpacking if so. Next time you write to that file it will be packed back
> (if possible).

Strange ;-).

> I agree that all of this is not very intuitive, though.

Okay -- thanks Oleg.

Cheers,

Michael

