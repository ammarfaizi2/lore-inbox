Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144123AbRAHOxh>; Mon, 8 Jan 2001 09:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144154AbRAHOx1>; Mon, 8 Jan 2001 09:53:27 -0500
Received: from hermes.mixx.net ([212.84.196.2]:11526 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S144123AbRAHOxR>;
	Mon, 8 Jan 2001 09:53:17 -0500
Message-ID: <3A59D3A4.AEE91B1@innominate.de>
Date: Mon, 08 Jan 2001 15:50:12 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Ext2 descriptor corruption in 2.4.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After 3 days up doing fairly normal things with an unremarkable
configuration and a vanila 2.4.0 kernel (nfs) I tried to log out of KDE 
and hung in 'preparing session for logout'.  In a text console, dmesg
showed an infinite number of "Free blocks count corrupted" messages:

  EXT2-fs error (device ide0(3,66)): ext2_new_block: Free blocks count
corrupted for block group 93
  EXT2-fs error (device ide0(3,66)): ext2_new_block: Free blocks count
corrupted for block group 93                                             

and gdb showed all the processes under X waiting in poll or select, not
surprising considering the way ext2 handles this:

  if (j >= EXT2_BLOCKS_PER_GROUP(sb)) {
         ext2_error (sb, "ext2_new_block",
                     "Free blocks count corrupted for block group %d",
i);
         goto out;
  }

I shut down and restarted hoping to get an fsck, but instead continued
past the ext2 mount.  I interrupted that, restarted and fscked, which
turned up a single special file with size 0 and no other problems.

So I think this may be a cache problem.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
