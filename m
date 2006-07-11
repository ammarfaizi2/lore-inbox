Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWGKAZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWGKAZp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 20:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWGKAZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 20:25:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:49392 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751341AbWGKAZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 20:25:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VA16mfwl6YwGV31D71Bb1UkUQBql0VsZ4p0oao94bhqLwyHYXwY7OK6/Mss5aem3K7j325kDA88KFVBk0mGz29l0SdzVmsL2gv/p/dFkOU6cRvU8J1p3oFEES3AIAITY55mu5k8wy2Hq9T5DJSYdDQO3E9NBfSuhRQSWhFBOgc4=
Message-ID: <9e4733910607101725s167d730fi47591f87ffe5e90f@mail.gmail.com>
Date: Mon, 10 Jul 2006 20:25:43 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Theodore Tso" <tytso@mit.edu>
Subject: Re: tty's use of file_list_lock and file_move
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060710233944.GB30332@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e4733910607100810r6e02f69g9a3f6d3d1400b397@mail.gmail.com>
	 <1152552806.27368.187.camel@localhost.localdomain>
	 <9e4733910607101027g5f3386feq5fc54f7593214139@mail.gmail.com>
	 <1152554708.27368.202.camel@localhost.localdomain>
	 <9e4733910607101535i7f395686p7450dc524d9b82ae@mail.gmail.com>
	 <20060710233944.GB30332@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/06, Theodore Tso <tytso@mit.edu> wrote:
> On Mon, Jul 10, 2006 at 06:35:50PM -0400, Jon Smirl wrote:
> > On 7/10/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > >We hold file_list_lock because we have to find everyone using that tty
> > >and hang up their instance of it, then flip the file operations not
> > >because we need to protect against tty structs going away. It's needed
> > >in order to walk the file list and protects against the file list itself
> > >changing rather than the tty structs. It may well be possible to move
> > >that to a tty layer private lock with care, but it would need care to
> > >deal with VFS operations.
> >
> > Assuming do_SAK has blocked anyone's ability to newly open the tty,
> > why does it need to search every file handle in the system instead of
> > just using tty->tty_files? tty->tty_files should contain a list of
> > everyone who has the tty open. Is this global search needed because of
> > duplicated handles?
>
> When I wrote the do_SAK code about 12-13 years ago, tty->tty_files
> didn't exist.  It should be safe to do this, but I'll echo Alan's
> comment.  We really ought to implement revoke(2) at the VFS layer, and
> then utilize to implement SAK and vhangup() functionality.

I'll buy you lunch if you do it. My understanding of the subtleties is
barely enough for me to work on the tty layer.

>
>                                                 - Ted
>


-- 
Jon Smirl
jonsmirl@gmail.com
