Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278768AbRJVMUW>; Mon, 22 Oct 2001 08:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277955AbRJVMUJ>; Mon, 22 Oct 2001 08:20:09 -0400
Received: from dutind4.twi.tudelft.nl ([130.161.210.154]:43652 "EHLO
	dutind4.twi.tudelft.nl") by vger.kernel.org with ESMTP
	id <S278768AbRJVMTz>; Mon, 22 Oct 2001 08:19:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kees Lemmens <C.W.J.Lemmens@its.tudelft.nl>
Reply-To: C.W.J.Lemmens@its.tudelft.nl
To: linux-kernel@vger.kernel.org
Subject: little bug in drivers/parport/ieee1284_ops.c
Date: Mon, 22 Oct 2001 14:20:24 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01102214202401.01543@dutind6>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Think I found a bug in linux-2.4.12 in the module ieee1284_ops 
It fails to compile the modules :

gcc -D__KERNEL__ -I/usr/src/linux-2.4.12/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i586 -DMODULE   -c -o 
ieee1284_ops.o ieee1284_ops.c
ieee1284_ops.c: In function `ecp_forward_to_reverse':
ieee1284_ops.c:365: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in this 
function)
ieee1284_ops.c:365: (Each undeclared identifier is reported only once
ieee1284_ops.c:365: for each function it appears in.)
ieee1284_ops.c: In function `ecp_reverse_to_forward':
ieee1284_ops.c:397: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in this 
function)
make[2]: *** [ieee1284_ops.o] Error 1


I checked include/linux/parport.h  and decided that it probably had to be 
EEE1284_PH_ECP_DIR_UNKNOWN.

After this modification everything compiles fine.

-- 
groeten,
Kees Lemmens.

-----------------------------------------------------------------------
 Department of Applied Mathematical Analysis, Faculty of Information
 Technology and Systems, Delft University of Technology,

 Address 	: PO Box 5031, NL-2600 GA, Delft, The Netherlands.
 Phone work/home: (+31) 015-2787224/010-4740254, Fax : 015-2787209
 Email     	: C.W.J.Lemmens@its.tudelft.nl.
 WWW       	: http://ta.twi.tudelft.nl/DV/Staff/C.W.J.Lemmens.html
-----------------------------------------------------------------------
