Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265781AbUFXP7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265781AbUFXP7U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 11:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265782AbUFXP7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 11:59:20 -0400
Received: from linuxhacker.ru ([217.76.32.60]:30441 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S265781AbUFXP7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 11:59:17 -0400
Date: Thu, 24 Jun 2004 18:58:40 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: Michael Kerrisk <mtk-lists@jambit.com>
Cc: linux-kernel@vger.kernel.org, Hans Reiser <reiser@namesys.com>,
       Vladimir Saveliev <vs@namesys.com>, Chris Mason <mason@suse.com>,
       mk <michael.kerrisk@gmx.net>
Subject: Re: Strange NOTAIL inheritance behaviour in Reiserfs 3.6
Message-ID: <20040624155840.GG2362@linuxhacker.ru>
References: <041c01c45875$0368e340$c100a8c0@wakatipu> <200406231111.i5NBBFwF201534@car.linuxhacker.ru> <005e01c459f7$6a8546d0$c100a8c0@wakatipu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005e01c459f7$6a8546d0$c100a8c0@wakatipu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Jun 24, 2004 at 04:27:44PM +0200, Michael Kerrisk wrote:
> >
> > MK>     # mount -t reiserfs /dev/hda12 /testfs
> > Does it work as expected if you add "-o attrs" to the mount command?
> Yes!  Thanks.  However, it is a little unfortunate that if one fails
> to use this option, then:
> 1. "chattr +t" (and I suppose underlying ioctl()s) can still be used to
>    set this attribute on a directory, without any error resulting.
>    It would be better if an error is reported.

Well, initial idea was to allow people to at least reset attributes
in case of operationg with disabled attributes processing.

> 2. The attribute is then inherited by files created in that directory,
>    but has no effect.

Yes, attribute inheritance is working. The only part that is disabled
by default is copying from fs-specific attribute storage to actual VFS inode
attributes.

> 3. A later explicit "chattr + t" on the files themselves DOES result in
>    unpacking of the tails.  Why?

There is a check in attributes setting code (and attributes setting/cleaning
is enabled), that tests if NOTAIL attribute is set, that calls tails
unpacking if so. Next time you write to that file it will be packed back
(if possible).

I agree that all of this is not very intuitive, though.

Bye,
    Oleg
