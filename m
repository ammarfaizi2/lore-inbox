Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265816AbUBPUEJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 15:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265839AbUBPUEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 15:04:09 -0500
Received: from columba.eur.3com.com ([161.71.171.238]:41687 "EHLO
	columba.eur.3com.com") by vger.kernel.org with ESMTP
	id S265816AbUBPUEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 15:04:04 -0500
Message-ID: <4031222B.5030503@jburgess.uklinux.net>
Date: Mon, 16 Feb 2004 20:03:55 +0000
From: Jon Burgess <lkml@jburgess.uklinux.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-gb, en-us, en
MIME-Version: 1.0
To: Alex Zarochentsev <zam@namesys.com>
CC: Jon Burgess <lkml@jburgess.uklinux.net>, linux-kernel@vger.kernel.org
Subject: Re: ext2/3 performance regression in 2.6 vs 2.4 for small interleaved
 writes
References: <402BE01E.2010506@jburgess.uklinux.net> <20040216175127.GJ1298@backtop.namesys.com>
In-Reply-To: <20040216175127.GJ1298@backtop.namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Zarochentsev wrote:

>The fs with delayed block allocation (Reiser4, XFS, seems JFS too) look much
>better.
>  
>
Yes those results are in line with what I found on Reiserfs4 as well. I 
also tried incresing the number of streams to see when things start to 
break. Reiserfs4 seems to do well here as well. I stopped some tests 
early because some filesystems were just too slow.

Streams:   1     1      2      2      4     4      8     8      16    
16     32    32
           Write Read   Write  Read   Write Read   Write Read   Write 
Read   Write Read     
----------------------------------------------------------------------------------------
ext2       26.10 29.22  8.27   14.51  6.91   7.31  
-------------------------------------
ext3-order 25.45 28.21  4.96   14.29  
--------------------------------------------------
JFS        27.76 29.17  26.72  28.93  25.72 28.86  24.76 29.01  22.94 
28.49   4.25  6.03
Reiser4    27.08 29.28  27.02  28.69  27.09 28.47  27.26 27.26  27.09 
25.52  26.94 22.59 
XFS        28.09 29.16  28.15  28.11  27.60 27.19  26.81 26.23  25.68 
24.04  22.59 21.45

It would appear that with XFS and Reiser4 I would be able to 
simultaneously record >32 MPEG TV channels on to a single disk. I think 
that exceeds my TV recording requirements by some considerable margin :-)

    Jon

