Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264760AbUEKOeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264760AbUEKOeF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 10:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264759AbUEKOeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 10:34:04 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:64672 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264760AbUEKOeB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 10:34:01 -0400
Date: Tue, 11 May 2004 16:33:50 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Steve French <smfltc@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCEMENT PATCH COW] proof of concept impementation of cowlinks
Message-ID: <20040511143350.GA19635@wohnheim.fh-wedel.de>
References: <20040506131731.GA7930@wohnheim.fh-wedel.de> <20040508224835.GE29255@atrey.karlin.mff.cuni.cz> <20040510155359.GB16182@wohnheim.fh-wedel.de> <20040510192601.GA11362@delft.aura.cs.cmu.edu> <20040511100232.GA31673@wohnheim.fh-wedel.de> <20040511140853.GT24211@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040511140853.GT24211@delft.aura.cs.cmu.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2004 10:08:53 -0400, Jan Harkes wrote:
> On Tue, May 11, 2004 at 12:02:32PM +0200, Jörn Engel wrote:
> > > Copyfile can trivially be implemented in libc. I don't see why it would
> > > have to be a system call. If a network filesystem wants to optimize the
> > > file copying it could do this based on the sendfile data. If source and
> > > destination are within the same filesystem and we're copying the whole
> > > file starting at offset 0, send a copyfile RPC.
> > 
> > Can you explain this to Steve?  I'm still quite clueless about network
> > filesystems, but it sounded as if such an optimization was impossible
> > to do in cifs without a combined create/copy/unlink_on_error system
> > call.
> > 
> > If your suggestion works and the network filesystems can be changed to
> > work independently of a struct file*, I agree with you that copyfile()
> > is a stupid idea and should be forgotten.
> 
> I would probably do it by overriding the file_operations.sendfile
> function. A first approximation of a possible implementation follows. I
> went a bit crazy on the comments. The only problem is that the type of
> target is unknown, block/loop.c and nfsd/vfs.c are using sendfile to
> to send to something that is not a struct file.

Looks as if it could work.  Steve, can you verify this?

Jörn

-- 
A surrounded army must be given a way out.
-- Sun Tzu
