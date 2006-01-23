Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWAWNwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWAWNwx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 08:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWAWNwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 08:52:53 -0500
Received: from uproxy.gmail.com ([66.249.92.193]:52211 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751414AbWAWNww convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 08:52:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QGEzbPDtL+s/qMTKVg6qXzgBlevzGgPUV658ZFk/cKG93SZxNAUOg0xLMYe/vqgWvpVgigvRW5mpzliSKqnYTqmLjwgbL8YkEZd4k1/BdgmF2wimGGJe+ND5uR6krbI2+YvOSA4dF2neoTLbhQjDshk600uHijANFTlMDBM/7O0=
Message-ID: <69304d110601230552n4c7656cal9c6901e180e82504@mail.gmail.com>
Date: Mon, 23 Jan 2006 14:52:51 +0100
From: Antonio Vargas <windenntw@gmail.com>
To: Kyle Moffett <mrmacman_g4@mac.com>, "Theodore Ts'o" <tytso@mit.edu>,
       John Richard Moser <nigelenki@comcast.net>,
       linux-kernel@vger.kernel.org
Subject: Re: soft update vs journaling?
In-Reply-To: <536E71BF-44FF-430C-8C19-F06526F0C78D@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43D3295E.8040702@comcast.net> <20060122093144.GA7127@thunk.org>
	 <43D3D4DF.2000503@comcast.net> <20060122210238.GA28980@thunk.org>
	 <4D75B95E-2595-4B60-91B3-28AD469C3D39@mac.com>
	 <20060123072447.GA8785@thunk.org>
	 <536E71BF-44FF-430C-8C19-F06526F0C78D@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/06, Kyle Moffett <mrmacman_g4@mac.com> wrote:
> On Jan 23, 2006, at 02:24, Theodore Ts'o wrote:
> > Hot-shrinking a filesystem is certainly possible for any
> > filesystem, but the problem is how many filesystem data structures
> > you have to walk in order to find all the owner of all of the
> > blocks that you have to relocate.  That generally isn't a RAM
> > overhead problem, but the fact that in general, most filesystems
> > don't have an efficient way to answer the question, "who owns this
> > arbitrary disk block?"  Having extents means you have a slightly
> > more efficient encoding system, but it still is the case that you
> > have to check potentially every file in the filesystem to see if it
> > is the owner of one of the disk blocks that needs to be moved when
> > you are shrinking the filesystem.
>
> The way that I'm considering implementing this is by intentionally
> fragmenting the allocation bitmap, catalog file, etc, such that each
> 1/8 or so of the disk contains its own allocation bitmap describing
> its contents, its own set of files or directories, etc.  The
> allocator would largely try to keep individual btree fragments
> cohesive, such that one of the 1/8th divisions of the disk would only
> have pertinent data for itself.  The idea would be that when trying
> to look up an allocation block, in the common case you need only
> parse a much smaller subsection of the disk structures.

this sounds exactly the same as ext2/ext3 allocation groups :)

> > And the only use for such a [reverse-mapping] data structure would
> > be to make shrinking a filesystem more efficient.
>
> Not entirely true.  I _believe_ you could use such data structures to
> make the allocation algorithm much more robust against fragmentation
> if you record the right kind of information.
>
> Cheers,
> Kyle Moffett
>
> --
> If you don't believe that a case based on [nothing] could potentially
> drag on in court for _years_, then you have no business playing with
> the legal system at all.
>    -- Rob Landley
>

--
Greetz, Antonio Vargas aka winden of network

http://wind.codepixel.com/
windNOenSPAMntw@gmail.com
thesameasabove@amigascne.org

Every day, every year
you have to work
you have to study
you have to scene.
