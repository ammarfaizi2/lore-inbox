Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWGKNmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWGKNmL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 09:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWGKNmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 09:42:11 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:3810 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750775AbWGKNmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 09:42:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NfMpnxYUIzDfcSHvv9JsDCg0I5enkVSNXy4qWSr/k8R5/xBGod6Du4wBwggpyX/knNAG8OunmW5dKgBbPxVZG6GliRjrSUUWAlhIVWzu87DYIDqZsyN1ULTgK7P2Sk3qlv+u/J1Wut2L2wVEJXWuOzcF8uYN3J/2w10uwEe7Mfo=
Message-ID: <9e4733910607110642p598e2288x93302d79aa22377f@mail.gmail.com>
Date: Tue, 11 Jul 2006 09:42:08 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Paulo Marques" <pmarques@grupopie.com>
Subject: Re: tty's use of file_list_lock and file_move
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Theodore Tso" <tytso@mit.edu>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <44B3A484.5000002@grupopie.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e4733910607100810r6e02f69g9a3f6d3d1400b397@mail.gmail.com>
	 <9e4733910607101535i7f395686p7450dc524d9b82ae@mail.gmail.com>
	 <1152573312.27368.212.camel@localhost.localdomain>
	 <9e4733910607101604j16c54ef0r966f72f3501cfd2b@mail.gmail.com>
	 <9e4733910607101649m21579ae2p9372cced67283615@mail.gmail.com>
	 <20060711012904.GD30332@thunk.org>
	 <9e4733910607101916y4638c097ie26ae63a9949bc3e@mail.gmail.com>
	 <1152612752.18028.3.camel@localhost.localdomain>
	 <9e4733910607110528t73d5d7dai73efd59caddb9d25@mail.gmail.com>
	 <44B3A484.5000002@grupopie.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/06, Paulo Marques <pmarques@grupopie.com> wrote:
> Jon Smirl wrote:
> >[...]
> >  extern struct tty_driver *ptm_driver;        /* Unix98 pty masters; for /dev/ptmx */
> > @@ -158,21 +157,21 @@ static struct tty_struct *alloc_tty_stru
> >  {
> >       struct tty_struct *tty;
> >
> > -     tty = kmalloc(sizeof(struct tty_struct), GFP_KERNEL);
> > -     if (tty)
> > -             memset(tty, 0, sizeof(struct tty_struct));
> > +     tty = kmalloc(sizeof(*tty), GFP_KERNEL);
>                ^^^^^^^
> kzalloc?

It needs to be cleaned up. Right now it clears the struct twice before
using it, once in tty_alloc and another in tty_init.

> I don't know this code very well, so you might be actually changing the
> initialization here. On the other hand, this might be just a simple bug...


-- 
Jon Smirl
jonsmirl@gmail.com
