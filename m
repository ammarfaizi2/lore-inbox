Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136616AbREJN7y>; Thu, 10 May 2001 09:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136641AbREJN7q>; Thu, 10 May 2001 09:59:46 -0400
Received: from zeus.kernel.org ([209.10.41.242]:54674 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S136608AbREJN71>;
	Thu, 10 May 2001 09:59:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: reiserfs-list@namesys.com
Subject: IDE DMA timeouts and reiserfs stability
Date: Wed, 9 May 2001 23:42:35 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01050923423500.00777@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using 2.4.5-pre1.  Over the course of the last two weeks I have had
DMA timeouts occur twice.  Both times corrupted my fs.  While this is not
ideal, its not unexpected as things stand now.  I have seen at least three 
other reports on lkml about errors of this type - suspect that 2.4's ide 
is a little fragile in some corner cases...

Contrary to normal practice, after an IO error and fsck is a very wise thing
to do.  Can we automate this process.  ie can reiserfs detect that it has
experienced IO error(s) and set fsck required bits (two bits) in the SB?  
It would also be nice to be able to manually set these bits.  This way a script 
could be triggered at boot (from initrd for those of us with reiserfs boot disks) 
to do something like this

reiserfsck -a 	this should check each FS an does a --check when the bits are set
		to 01.  It changes the SB bits as follows (logging to <dev>01.log)
		00 - fs is ok
		10 - fix-fixable run required (logging to <dev>10.log)
		11 - rebuild-tree required (logging to <dev>11.log)

		writing those logs could be a bit of a catch 22...
			
then the script would call reiserfsck -a again to do the work (if required) and
ask if its ok to do the fix-fixable or rebuild-tree

Think reiserfsck is getting good enough for this, and it would probably avoid 
many of the problem currently popping up on the list. 

Thoughts?

Ed Tomlinson <tomlins@cam.org>

PS. Chris, with the fix you supplied for LVM, snapshots work 100% of the time when
I put them on hda or hde and fail 100% on hdg...  




