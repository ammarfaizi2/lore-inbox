Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130615AbRABTcm>; Tue, 2 Jan 2001 14:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131549AbRABTcd>; Tue, 2 Jan 2001 14:32:33 -0500
Received: from hermes.mixx.net ([212.84.196.2]:7696 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130615AbRABTcT>;
	Tue, 2 Jan 2001 14:32:19 -0500
Message-ID: <3A5224F8.CA0F266B@innominate.de>
Date: Tue, 02 Jan 2001 19:59:04 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>
Subject: Happy new year^H^H^H^H BUG...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After a long session of heavy use I triggered the BUG at inode.c line
372 in clear_inode:

        if (inode->i_data.nrpages)
               
BUG();                                                                                                                        

This occured when a gdb xterm was attempting to close.  Unfortunately I
wasn't able to translate or capture the oops.  I'll do some heavy
beating on 24-pre again tomorrow on my test machine and see if can
capture this oops over serial.

This call most likely came from invalidate_inodes.  It looks like some
pages have escaped cleanup.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
