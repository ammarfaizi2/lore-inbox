Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286679AbSACW5M>; Thu, 3 Jan 2002 17:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286893AbSACW5C>; Thu, 3 Jan 2002 17:57:02 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:11789 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S286679AbSACW46>;
	Thu, 3 Jan 2002 17:56:58 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Linus Torvalds <torvalds@transmeta.com>
Date: Thu, 3 Jan 2002 23:56:30 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] smbfs fsx'ed
CC: Dave Jones <davej@suse.de>, <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.40
Message-ID: <DE185415BB6@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  3 Jan 02 at 13:37, Linus Torvalds wrote:
> 
> (Not as horrible as the NCPFS thing that doesn't understand about the page
> cache at all, but still..)

Unfortunately it is not easy for me to add pagecache support
to ncpfs, as couple of ncpfs users uses ncpfs in shared environment
with database record locking, and if I'll now read full 4KB instead of
128B record, it can clash with records locked by other clients.

I can for sure add `leases' like Novell Client for Windows does for
possibility of file caching, but I'm not sure whether size of code
needed for supporting this (and for supporting server driven
cache flushes) is worth of effort.
                                    Best regards,
                                        Petr Vandrovec
                                        vandrove@vc.cvut.cz
                                        
P.S.: And as NCP protocol is totally synchronous (even if it uses
TCP, I explicitly asked in Utah), only local file caching can increase
ncpfs performance, as there is no such thing like asynchronous file
read/write...
