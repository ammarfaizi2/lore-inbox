Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBLRSi>; Mon, 12 Feb 2001 12:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129320AbRBLRSS>; Mon, 12 Feb 2001 12:18:18 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:43593 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S129027AbRBLRSA>;
	Mon, 12 Feb 2001 12:18:00 -0500
Message-ID: <3A881A52.962B3ED4@sgi.com>
Date: Mon, 12 Feb 2001 09:16:02 -0800
From: LA Walsh <law@sgi.com>
Organization: Trust Technology, SGI
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.4.2-pre1 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Block driver design issue
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a block driver I inherited that I working on that has a problem and
was wondering for cleaner solutions.

The driver can accept written characters from either userspace programs or from
the kernel.  From userspace it uses sys_write.  That in turn calls block_write.
There's almost 100 lines of duplicated code in a copy of the block_write
code in the driver "block_writek" as well as duplicate code in audit_write vs. audit_writek.
The only difference being down in block_write at the "copy_from_user(p,buf,chars); "
which becomes a "memcpy(p,buf,chars)" in the "block_writek" version.  

I find this duplication of code to be inefficient.  Is there a way to dummy up the
the 'buf' address so that the "copy_from_user" will copy the buffer from kernel space?
My assumption is that it wouldn't "just work" (which may also be an invalid assumption).

Suggestions?  Abuse?

Thanks!
-linda

-- 
L A Walsh                    | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
