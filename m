Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286335AbRLJRpr>; Mon, 10 Dec 2001 12:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286337AbRLJRpi>; Mon, 10 Dec 2001 12:45:38 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:35595 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S286335AbRLJRp1>;
	Mon, 10 Dec 2001 12:45:27 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Daniel Phillips <phillips@bonn-fries.net>
Date: Mon, 10 Dec 2001 18:44:43 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: File copy system call proposal
CC: quinn@nmt.edu (Quinn Harris),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org),
        acahalan@cs.uml.edu
X-mailer: Pegasus Mail v3.40
Message-ID: <B9C4D5C2F78@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Dec 01 at 16:19, Daniel Phillips wrote:
> On December 10, 2001 06:44 am, Albert D. Cahalan wrote:
> > 
> > No, mmap+write does not do the job. SMB file servers have
> > a remote copy operation. There shouldn't be any need to
> > pull data over the network only to push it back again!
> 
> Hi Albert,
> 
> I don't get it, you're saying that this zero-copy optimization, which happens 
> entirely within the vfs, shouldn't be done because smb can't do it over a 
> network?

VFS can do this optimization (but why...), but having FS-specific
sendfile would be nice too - FS can verify whether both source & destination
are on same filesystem, and if they do, it can perform server filecopy
(if server's implementation filecopy can copy arbitrary long chunk at 
arbitrary offset into another file at some else offset, like Netware's
NWFileServerFileCopy() does).

> > trustees   (NetWare)
> 
> I'd think the mmap-based copy would only use the technique on the data 
> portion of a file.

At least from my exprience with Netware I can say that copy which copies
file trustees happens in at most 1% of all copies (and on Netware
trustees flow through the tree down, so you have usually no trustees
assigned to leaf files) - and this 1% is when you do backup and restore.
In all other cases it would be great surprise that all users which had
rights to old copy have these rights to new copy too.
                                            Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
