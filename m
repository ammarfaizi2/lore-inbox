Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbVCZDs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbVCZDs4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 22:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbVCZDs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 22:48:56 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:25188 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261933AbVCZDsh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 22:48:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=rOe9I7sWrVv7swRFan7HX5I4gOpTQrpOrZ9Qi2AIh0LTdt5hDxGrJ1SRRerpj2b0xDpinRmqv7hc95fY5fVxYXHiP9SpA4R5lMtUW8DKYigJlD2FhRMA/4X5l+PPGIkfBLrR3rVKrdAllD00yIMxY5XmaEoW8ap6SjhRrwHfgHA=
Message-ID: <cce9e37e0503251948527d322b@mail.gmail.com>
Date: Sat, 26 Mar 2005 03:48:35 +0000
From: Phil Lougher <phil.lougher@gmail.com>
Reply-To: Phil Lougher <phil.lougher@gmail.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Squashfs without ./..
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
       phillip@lougher.demon.co.uk
In-Reply-To: <3e74c9409b6e383b7b398fe919418d54@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.61.0503221645560.25571@yvahk01.tjqt.qr>
	 <20050323174925.GA3272@zero>
	 <Pine.LNX.4.62.0503241855350.18295@numbat.sonytel.be>
	 <20050324133628.196a4c41.Tommy.Reynolds@MegaCoder.com>
	 <d1v67l$4dv$1@terminus.zytor.com>
	 <3e74c9409b6e383b7b398fe919418d54@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2005 15:13:08 -0500, Kyle Moffett <mrmacman_g4@mac.com> wrote:
> I would add ".." and "." to squashfs, just so that it acts like the rest
> of the filesystems on the planet,

Cramfs also doesn't store '.' and '..', which is where I got the idea
from in the first place when originally implementing Squashfs.

Filesystems don't need to store '.' or ''..' in the filesystem, as
they're never looked up by the VFS - as mentioned elsewhere in this
thread, the VFS handles '.' and '..' internally.

Not storing the redundant '.' and '..' entries within the filesystem
achieves a small but nonetheless useful space saving.

> even if it has to emulate them
> internally.

Making readdir return '.' and '..' is trivially easy, as all the
required information to fake '.' and '..' entries are present.

The lack of '.' and '..' entries hasn't caused any problems despite
cramfs/squashfs being used for a large number of years.  I'm inclined
to believe any application that _relies_ on seeing '.' and '..'
returned by readdir is broken.  This situation is easily fixed within
the application rather than forcing the filesystem to unnecessarily
fake '.' and '..' entries which are never used.

> OTOH, I think that the default behavior of find is broken
> and should probably be fixed, maybe by making the default use the full
> readdir and optionally allowing a -fast option that optimizes the
> search using such tricks.
> 

Cramfs/Squashfs and other filesystems set the link count on files and
directories to 1, find correctly interprets this to mean it can't do
any of its 'tricks' and doesn't use any optimisations.

Phillip
