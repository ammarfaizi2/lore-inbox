Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQLOCdF>; Thu, 14 Dec 2000 21:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbQLOCcz>; Thu, 14 Dec 2000 21:32:55 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:52745 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S129257AbQLOCcw>; Thu, 14 Dec 2000 21:32:52 -0500
Message-ID: <3A397BA9.CB0EC8E5@thebarn.com>
Date: Thu, 14 Dec 2000 20:02:17 -0600
From: Russell Cattelan <cattelan@thebarn.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-whipme11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Test12 ll_rw_block error.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This would seem to be an error on the part of ll_rw_block.
Setting b_end_io to a default handler without checking to see
a callback has already been defined defeats the purpose of having
a function op.

void ll_rw_block(int rw, int nr, struct buffer_head * bhs[])
 {
@@ -928,7 +1046,8 @@
                if (test_and_set_bit(BH_Lock, &bh->b_state))
                        continue;

-               set_bit(BH_Req, &bh->b_state);
+               /* We have the buffer lock */
+               bh->b_end_io = end_buffer_io_sync;

                switch(rw) {
                case WRITE:


-Russell Cattelan


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
