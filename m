Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267277AbSK3RsT>; Sat, 30 Nov 2002 12:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267278AbSK3RsT>; Sat, 30 Nov 2002 12:48:19 -0500
Received: from monarch.prairienet.org ([192.17.3.5]:59609 "HELO
	mail.prairienet.org") by vger.kernel.org with SMTP
	id <S267277AbSK3RsS>; Sat, 30 Nov 2002 12:48:18 -0500
Message-ID: <3DE8FB9A.2080009@prairienet.org>
Date: Sat, 30 Nov 2002 11:55:38 -0600
From: John Belmonte <jvb@prairienet.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: seq_file / proc_fs userdata issue
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The proc_fs interface supports userdata, which can be used for an
object-oriented style of programming.  Used intelligently, this can
eliminate a fair amount of code redundancy in drivers that handle many
proc files.

Recently there has been work on the kernel to convert proc reads to use
seq_file.  The problem is, although seq_file also has userdata support,
the userdata given to proc_fs is not automatically propagated to
seq_file.  The only way to set the seq_file userdata is in the open
handler, which as far as I can tell does not have access to the
proc_dir_entry.  The result is a proliferation of nearly-identical
functions and tables that could otherwise be generalized.

In summary, I'm suggesting that the proc_fs internals automatically
propagate the userdata placed in the proc_dir_entry to the seq_file 
instance, so that it is available in the read handler.  After all, this 
is what we enjoyed before the move to seq_file.


Regards,
-John Belmonte

