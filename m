Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262648AbUEKKDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbUEKKDM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 06:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUEKKDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 06:03:12 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:3819 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S262648AbUEKKDJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 06:03:09 -0400
Date: Tue, 11 May 2004 12:02:32 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: Steve French <smfltc@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCEMENT PATCH COW] proof of concept impementation of cowlinks
Message-ID: <20040511100232.GA31673@wohnheim.fh-wedel.de>
References: <20040506131731.GA7930@wohnheim.fh-wedel.de> <20040508224835.GE29255@atrey.karlin.mff.cuni.cz> <20040510155359.GB16182@wohnheim.fh-wedel.de> <20040510192601.GA11362@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040510192601.GA11362@delft.aura.cs.cmu.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2004 15:26:02 -0400, Jan Harkes wrote:
> On Mon, May 10, 2004 at 05:53:59PM +0200, Jörn Engel wrote:
> > A real problem is that copyfile() has all errno's from create(),
> > sendfile() and unlink() combined, which doesn't make error handling in
> > userspace easy.  "It could be this, that or another error" is the kind
> > of mess I always hated about Windows, so I should try to do a little
> > better.
> 
> Well, if you leave the create and unlink up to the application and
> simply pass open filedescriptors to copyfile... But then it would be
> equivalent to your new sendfile.
> 
> Copyfile can trivially be implemented in libc. I don't see why it would
> have to be a system call. If a network filesystem wants to optimize the
> file copying it could do this based on the sendfile data. If source and
> destination are within the same filesystem and we're copying the whole
> file starting at offset 0, send a copyfile RPC.

Can you explain this to Steve?  I'm still quite clueless about network
filesystems, but it sounded as if such an optimization was impossible
to do in cifs without a combined create/copy/unlink_on_error system
call.

If your suggestion works and the network filesystems can be changed to
work independently of a struct file*, I agree with you that copyfile()
is a stupid idea and should be forgotten.

Jörn

-- 
Courage is not the absence of fear, but rather the judgement that
something else is more important than fear.
-- Ambrose Redmoon
