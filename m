Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131317AbRAGMsK>; Sun, 7 Jan 2001 07:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131338AbRAGMrv>; Sun, 7 Jan 2001 07:47:51 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:50981 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S131317AbRAGMrk>; Sun, 7 Jan 2001 07:47:40 -0500
Date: Sun, 7 Jan 2001 13:45:31 +0100
From: Christian Ullrich <chris@chrullrich.de>
To: rgooch@atnf.csiro.au
Cc: linux-kernel@vger.kernel.org
Subject: Problem with devfs and Unix98 pty
Message-ID: <20010107134531.A1039@christian.chrullrich.de>
Mail-Followup-To: rgooch@atnf.csiro.au, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
X-M$-Free-System: since 1999-11-28
X-Current-Uptime: 0 d, 00:10:25 h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The automatic saving and reloading of permissions and ownerships
by devfsd is not compatible with Unix98 ptys (in /dev/pts). 

Imagine a user A trying to get a pty, for example by starting an
xterm. If there's a saved inode /dev-state/pts/<whatever> owned by
user B, and the next free number in /dev/pts equals <whatever>,
devfsd will replace the automatically created inode with the saved,
which is owned by B. So A does not have any chance at all to get 
another pty.

I propose to add the following lines to the default devfsd.conf,
just above the last three lines:

REGISTER        ^pts/.*         IGNORE
CHANGE          ^pts/.*         IGNORE
CREATE          ^pts/.*         IGNORE

This fixed the problem for me. If you know a better solution,
please let me know.

-- 
Christian Ullrich		     Registrierter Linux-User #125183

"Sie können nach R'ed'mond fliegen -- aber Sie werden sterben"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
