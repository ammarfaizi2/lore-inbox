Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRADFaL>; Thu, 4 Jan 2001 00:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132868AbRADFaB>; Thu, 4 Jan 2001 00:30:01 -0500
Received: from web2303.mail.yahoo.com ([128.11.68.66]:22031 "HELO
	web2303.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129436AbRADF3t>; Thu, 4 Jan 2001 00:29:49 -0500
Message-ID: <20010104052948.12042.qmail@web2303.mail.yahoo.com>
Date: Wed, 3 Jan 2001 21:29:48 -0800 (PST)
From: Asang K Dani <asang@yahoo.com>
Subject: generic_file_write code segment in 2.2.18
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi everyone,
   I was trying to understand following piece of code in
'generic_file_read' (mm/filemap.c) for 2.2.18 kernel. The code
segment
is as follows:

----------------------------------------------------------------
		dest = (char *) page_address(page) + offset;
		if (dest != buf) { /* See comment in
                                      update_vm_cache_cond. */
			bytes -= copy_from_user(dest, buf, bytes);
			flush_dcache_page(page_address(page));
		}
		status = -EFAULT;
		if (bytes)
			status = inode->i_op->updatepage(file, page,                      
                      offset, bytes, sync);

 unlock:
		/* Mark it unlocked again and drop the page.. */
		clear_bit(PG_locked, &page->flags);
		wake_up(&page->wait);
		page_cache_release(page);

		if (status < 0)
			break;

		written += status;
		count -= status;
		pos += status;
		buf += status;
----------------------------------------------------------------
copy_from_user returns the number of bytes copied from userspace
to 'dest'. In case it succeeds, 'bytes' will be set to 0 after the
call. However, 'status' is set to -EFAULT. So wouldn't it break
out of the while loop (prematurely)?

Please post/CC your comments to me if this is not of general interest
to the list and is too silly to be answered there.

regards,
Asang Dani

__________________________________________________
Do You Yahoo!?
Yahoo! Photos - Share your holiday photos online!
http://photos.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
