Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289117AbSA1FjZ>; Mon, 28 Jan 2002 00:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289118AbSA1FjN>; Mon, 28 Jan 2002 00:39:13 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:15793 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S289117AbSA1Fi7>; Mon, 28 Jan 2002 00:38:59 -0500
Subject: in_softirq(): Pls Help
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OFA4D32EE3.786B35B6-ON65256B4F.001DFA80@in.ibm.com>
From: "Rajasekhar Inguva" <irajasek@in.ibm.com>
Date: Mon, 28 Jan 2002 11:08:08 +0530
X-MIMETrack: Serialize by Router on d23m0067/23/M/IBM(Release 5.0.8 |June 18, 2001) at
 28/01/2002 11:08:09 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All , I am unable to understand the below code snippet. Any explanation
would be of great help.

File: net/ipv4/route.c
Routine: rt_intern_hash()

...
...
int attempts = ! in_softirq();
...
...
..
if( attempts-- > 0 )
{
     ...
     ...
     rt_garbage_collect();
     ...
     ...
}

The code inside the 'if' block runs only if the local_bh_count is zero. In
effect, the garbage collection is done only if local_bh_count is zero.

So, in a situation wherein neighbour tables are full and local_bh_count is
not zero, then we have to bear the dreaded "neighbour table overflow"
message.

Why is it done the way it is ?

Thanks a lot, in advance !

Cheers,

Raj

