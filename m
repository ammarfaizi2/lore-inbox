Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265237AbTLKUcf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 15:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265240AbTLKUcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 15:32:35 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:38308
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S265237AbTLKUcd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 15:32:33 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>,
       Hua Zhong <hzhong@cisco.com>
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Date: Thu, 11 Dec 2003 14:32:12 -0600
User-Agent: KMail/1.5
Cc: "'Andy Isaacson'" <adi@hexapodia.org>, linux-kernel@vger.kernel.org
References: <20031211125806.B2422@hexapodia.org> <017c01c3c01b$232bd130$d43147ab@amer.cisco.com> <20031211194815.GA10029@wohnheim.fh-wedel.de>
In-Reply-To: <20031211194815.GA10029@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200312111432.12683.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 December 2003 13:48, Jörn Engel wrote:
> On Thu, 11 December 2003 11:15:28 -0800, Hua Zhong wrote:
> > > The abstract interface for make_hole() is simple, but it turns into a
> > > pretty expensive filesystem operation, I think.  After many cycles of
> > > free/allocate, your file would be badly fragmented across the
> > > filesystem.
> >
> > Understood. Two filesystems we are using: tmpfs and ext3. For the
> > former, fragmentation doesn't matter.
> >
> > Hey, I think when I get some cycles I can try to implement this for
> > tmpfs (since it's simpler) myself, and post a patch. :-) But before
> > that, I want to make sure it's doable.
>
> If you really do it, please don't add a syscall for it.  Simply check
> each written page if it is completely filled with zero.  (This will be
> a very quick check for most pages, as they will contain something
> nonzero in the first couple of words)

Cache poisoning, streaming writes to large RAID arrays...  There are about 8 
zllion reasons not to do this.  Really.  (It defeats the whole purpose of 
DMA, doesn't it?)

> Jörn

Rob
