Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129556AbQJ3CFr>; Sun, 29 Oct 2000 21:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129693AbQJ3CF2>; Sun, 29 Oct 2000 21:05:28 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:61817 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129556AbQJ3CFV>; Sun, 29 Oct 2000 21:05:21 -0500
Message-ID: <39FCE576.9425F7F5@mandrakesoft.com>
Date: Sun, 29 Oct 2000 22:05:26 -0500
From: Kevin Lawton <kevin@mandrakesoft.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.15-4mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: kevin@mandrakesoft.com
Subject: bug fix for 'include/linux/wrapper.h', bad parentheses for macros
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Listed in 2.4 headers as:

        #define mem_map_reserve(p) set_bit(PG_reserved, &p->flags)
        #define mem_map_unreserve(p) clear_bit(PG_reserved, &p->flags)
 
...but should be:
 
        #define mem_map_reserve(p) set_bit(PG_reserved, &((p)->flags))
        #define mem_map_unreserve(p) clear_bit(PG_reserved, &((p)->flags))

Because of the 'void *' nature of the 2nd parameter to set_bit/clear_bit,
the compiler is not picking up this error.  Either expression generates
a pointer, but not the same values.

Might as well also wrap the parameter 'p' with parentheses in the
subsequent macros, mem_map_inc_count() and mem_map_dec_count(),
for clarity.

CC me if needed.  I'm not on this list.

-Kevin Lawton
Plex86 project
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
