Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290389AbSAPJXS>; Wed, 16 Jan 2002 04:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290393AbSAPJXJ>; Wed, 16 Jan 2002 04:23:09 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:7911 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S290389AbSAPJW6>; Wed, 16 Jan 2002 04:22:58 -0500
Date: Wed, 16 Jan 2002 10:22:56 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-pre4
Message-ID: <20020116102256.C824@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.21.0201151955460.27118-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0201151955460.27118-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Tue, Jan 15, 2002 at 07:56:38PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 07:56:38PM -0200, Marcelo Tosatti wrote:
[pre4 Announcement]

What is this hunk supposed to do?
diff -urN linux-2.4.18-pre3/fs/buffer.c linux/fs/buffer.c
--- linux-2.4.18-pre3/fs/buffer.c   Fri Dec 21 09:41:55 2001
+++ linux/fs/buffer.c   Tue Jan 15 15:10:18 2002
@@ -1633,12 +1671,34 @@
    */
   while(wait_bh > wait) {
      wait_on_buffer(*--wait_bh);
-     err = -EIO;
      if (!buffer_uptodate(*wait_bh))
-        goto out;
+        return -EIO;
   }
   return 0;
 out:
+  /*
+   * Zero out any newly allocated blocks to avoid exposing stale
+   * data.  If BH_New is set, we know that the block was newly
+   * allocated in the above loop.
+   */
+  bh = head;
+  block_start = 0;
[1]
+  do {
+     block_end = block_start+blocksize;
+     if (block_end <= from)
+        continue;
[2]

The situation between [1] and [2] won't change, so I don't
understand the "continue" here and think it will either never be
triggered or an endless loop.

Could you or the one introducing this clarify?

Thanks & Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
     >>>   4. Chemnitzer Linux-Tag - 09.+10. Maerz 2002 <<<
              http://www.tu-chemnitz.de/linux/tag/
