Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264076AbUEMK6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264076AbUEMK6v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 06:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264090AbUEMK6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 06:58:51 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:3739 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264076AbUEMK6t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 06:58:49 -0400
Date: Thu, 13 May 2004 12:56:13 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Pavel Machek <pavel@ucw.cz>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [ANNOUNCEMENT PATCH COW] proof of concept impementation of cowlinks
Message-ID: <20040513105613.GA31123@wohnheim.fh-wedel.de>
References: <20040506131731.GA7930@wohnheim.fh-wedel.de> <200405081645.06969.vda@port.imtp.ilyichevsk.odessa.ua> <20040508221017.GA29255@atrey.karlin.mff.cuni.cz> <200405091709.37518.vda@port.imtp.ilyichevsk.odessa.ua> <20040509215351.GA15307@atrey.karlin.mff.cuni.cz> <20040510154450.GA16182@wohnheim.fh-wedel.de> <20040512002606.GB22081@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040512002606.GB22081@mail.shareable.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2004 01:26:06 +0100, Jamie Lokier wrote:
> Jörn Engel wrote:
> > What about ino?  I currently return 1, so diff remains fast without
> > any changes.  If someone really needs the difference between inode 2
> > and 3, I would introduce a cstat() system call similar to lstat(),
> > which would return ino=2.
> > 
> > Is this sane?  Should it be reversed and cstat() return ino=1, while
> > stat returns ino=2?  I can imagine that "tar -x" would create hard
> > links for every cowlink that "tar -c" saw, but I'm not sure yet.
> 
> I think it should be reversed.

Aye.

> One very useful application for cowlinks is for virtual machine (UML)
> and chroot jail setups, where an entire filesystem tree is copied
> perhaps hundreds of times on a single disk.  I'm surprised we didn't
> think of this earlier, as it's potentially one of the most useful
> applications for cowlinks.
> 
> In that scenario, cowlinks would save enormous amounts of storage and
> potentially save memory too.  However to be useful at all, they'd need
> to have accurate POSIX semantics: that is, cowlinks must behave very
> much as a storage optimisation only.
> 
> That means stat() should return ino==2.

Hmm, true.  Up 'till now, that was done with disk images and block
based diffs/snapshots.  Nice application.

Jörn

-- 
He who knows others is wise.
He who knows himself is enlightened.
-- Lao Tsu
