Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135292AbRDZKuG>; Thu, 26 Apr 2001 06:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135284AbRDZKtq>; Thu, 26 Apr 2001 06:49:46 -0400
Received: from mail.crc.dk ([130.226.184.8]:43282 "EHLO mail.crc.dk")
	by vger.kernel.org with ESMTP id <S135292AbRDZKtg>;
	Thu, 26 Apr 2001 06:49:36 -0400
Message-ID: <3AE7FD3E.ADCC9016@crc.dk>
Date: Thu, 26 Apr 2001 12:49:34 +0200
From: Mogens Kjaer <mk@crc.dk>
Organization: Carlsberg Laboratory
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2mk1 i686)
X-Accept-Language: da, en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: NFS Bug  in 2.4.3?
In-Reply-To: <986169711.1485.2.camel@neuromancer>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Thomas J. Baker" wrote:
> 
> There is an NFS bug described here
> 
> http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=30944
> 
> that seems to have been known about for a while that is not fixed in
> 2.4.3.  Is there something wrong with the patch that is discussed?

It works fine for me.

Note, however, the patch should be patched in order to work on the
2.4.2 kernel distributed with rh71.

--- linux-2.4.2-dir.dif Thu Mar  1 14:58:28 2001
+++ linux-2.4.2-dirRH71.dif     Thu Apr 26 12:19:34 2001
@@ -111,13 +111,14 @@
 diff -u --recursive --new-file linux-2.4.2-fh_align/fs/readdir.c
linux-2.4.2-dir/fs/readdir.c
 --- linux-2.4.2-fh_align/fs/readdir.c  Mon Dec 11 22:45:42 2000
 +++ linux-2.4.2-dir/fs/readdir.c       Thu Feb 22 10:47:49 2001
-@@ -315,7 +315,8 @@
+@@ -346,7 +346,9 @@
        lastdirent = buf.previous;
        if (lastdirent) {
                struct linux_dirent64 d;
 -              d.d_off = file->f_pos;
++              /* d.d_off = file->f_pos; */
 +              /* get the sign extension right */
 +              d.d_off = (off_t)file->f_pos;
-               copy_to_user(&lastdirent->d_off, &d.d_off,
sizeof(d.d_off));
                error = count - buf.count;
-       }
+               if (copy_to_user(&lastdirent->d_off, &d.d_off,
sizeof(d.d_off)))
+                       error = -EFAULT;


(patch to a patch; hm...).

Mogens
-- 
Mogens Kjaer, Carlsberg Laboratory, Dept. of Chemistry
Gamle Carlsberg Vej 10, DK-2500 Valby, Denmark
Phone: +45 33 27 53 25, Fax: +45 33 27 47 08
Email: mk@crc.dk Homepage: http://www.crc.dk
