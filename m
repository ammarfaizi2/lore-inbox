Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbWGWW1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWGWW1q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 18:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWGWW1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 18:27:46 -0400
Received: from dvhart.com ([64.146.134.43]:42169 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751358AbWGWW1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 18:27:45 -0400
From: Vernon Mauery <vernux@us.ibm.com>
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: what is necessary for directory hard links
Date: Sun, 23 Jul 2006 15:27:23 -0700
User-Agent: KMail/1.9.1
References: <200607230219.k6N2JMHI021999@laptop13.inf.utfsm.cl>
In-Reply-To: <200607230219.k6N2JMHI021999@laptop13.inf.utfsm.cl>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607231527.23484.vernux@us.ibm.com>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 July 2006 19:19, you wrote:
> Bodo Eggert <7eggert@elstempel.de> wrote:
> > Horst H. von Brand <vonbrand@inf.utfsm.cl> wrote:
> > > Joshua Hudson <joshudson@gmail.com> wrote:
> > >> This patch is the sum total of all that I had to change in the kernel
> > >> VFS layer to support hard links to directories
> > >
> > > Can't be done, as it creates the possibility of loops.
> >
> > Don't do that then?
>
> Stop /everything/ to make sure no concurrent activity creates a loop, while
> checking the current mkdir(2) doesn't create one?

This doesn't seem that big of an issue for people to be up in arms about.  You 
wouldn't have to stop /everything/, would you, just have an in kernel mutex 
in vfs_mkdir.  It's not the most commonly used system call in the book -- 
meaning serializing the checking/creating of new directories would not really 
hamper your system /that/ much.

Personally, I don't think hard linked directories are necessary or even that 
interesting, but they certainly aren't impossible to do.  I suppose there 
might be some specialty filesystem that might like to do hardlinked 
directories and I don't think the vfs core should make it difficult.  

--Vernon

> > > The "only files can
> > > be hardlinked" idea makes garbage collection (== deleting of
> > > unreachable objects) simple: Just check the number of references.
> > >
> > > Detecting unconnected subgraphs uses a /lot/ of memory; and much worse,
> > > you have to stop (almost) all filesystem activity while doing it.
> >
> > In order to disconnect a directory, you'd have to empty it first, and
> > after emptying a directory, it won't be part of a loop. Maybe emtying is
> > the problem ...
>
> What does "emptying a directory" mean if there might be loops?
>
> > This feature was implemented,
>
> Never in my memory of any Unix (and lookalike) system in real use (I've
> seen a few).
>
> >                               and I asume it was removed for a reason.
> > Can somebody remember?
>
> See my objections.
