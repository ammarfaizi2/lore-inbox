Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263467AbUELAcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbUELAcF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 20:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265086AbUELA2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 20:28:23 -0400
Received: from mail.shareable.org ([81.29.64.88]:33926 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263467AbUELA0Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 20:26:25 -0400
Date: Wed, 12 May 2004 01:26:06 +0100
From: Jamie Lokier <jamie@shareable.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Pavel Machek <pavel@ucw.cz>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [ANNOUNCEMENT PATCH COW] proof of concept impementation of cowlinks
Message-ID: <20040512002606.GB22081@mail.shareable.org>
References: <20040506131731.GA7930@wohnheim.fh-wedel.de> <200405081645.06969.vda@port.imtp.ilyichevsk.odessa.ua> <20040508221017.GA29255@atrey.karlin.mff.cuni.cz> <200405091709.37518.vda@port.imtp.ilyichevsk.odessa.ua> <20040509215351.GA15307@atrey.karlin.mff.cuni.cz> <20040510154450.GA16182@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040510154450.GA16182@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
> What about ino?  I currently return 1, so diff remains fast without
> any changes.  If someone really needs the difference between inode 2
> and 3, I would introduce a cstat() system call similar to lstat(),
> which would return ino=2.
> 
> Is this sane?  Should it be reversed and cstat() return ino=1, while
> stat returns ino=2?  I can imagine that "tar -x" would create hard
> links for every cowlink that "tar -c" saw, but I'm not sure yet.

I think it should be reversed.

One very useful application for cowlinks is for virtual machine (UML)
and chroot jail setups, where an entire filesystem tree is copied
perhaps hundreds of times on a single disk.  I'm surprised we didn't
think of this earlier, as it's potentially one of the most useful
applications for cowlinks.

In that scenario, cowlinks would save enormous amounts of storage and
potentially save memory too.  However to be useful at all, they'd need
to have accurate POSIX semantics: that is, cowlinks must behave very
much as a storage optimisation only.

That means stat() should return ino==2.

-- Jamie
