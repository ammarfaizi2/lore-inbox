Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278959AbRKXSgi>; Sat, 24 Nov 2001 13:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279064AbRKXSg3>; Sat, 24 Nov 2001 13:36:29 -0500
Received: from [65.13.170.37] ([65.13.170.37]:50778 "EHLO
	cx662584-c.okcnc1.ok.home.com") by vger.kernel.org with ESMTP
	id <S278959AbRKXSgV>; Sat, 24 Nov 2001 13:36:21 -0500
Message-ID: <3BFFE8A2.1010708@rueb.com>
Date: Sat, 24 Nov 2001 12:36:18 -0600
From: Steve Bergman <steve@rueb.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, steve@rueb.com
Subject: Disk hardware caching, performance, and journalling
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I made a couple of discoveries today which were surprising to me:

1. Disk hardware caching defaults to ON. (hdparm -W1 /dev/hda)
2. It makes a *big* difference in write performance.

I had always thought that the default was off.  I also always assumed 
that a small cache behind a large (OS) cache would make no difference.

Here are my results with bonnie under kernel 2.4.14 on a reiserfs with a 
maxtor Diamond max+ 60GB udma100 drive:

Write caching on:
-------Sequential Output-------- ---Sequential Input-- --Random--
-Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --Seeks---
Machine    MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU  
/sec %CPU
                 256 12618 97.1 38027 36.3  9647  6.9 11250 73.6 31832 
12.1 200.9  1.2


Write caching off:
-------Sequential Output-------- ---Sequential Input-- --Random--
-Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --Seeks---
Machine    MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU  
/sec %CPU
                 256  9917 76.3 12280 11.2  5159  3.5  9934 65.3 33056 
14.1 203.9  1.4
                                        
Note that block writes are over 3 times faster with caching on.

So what are the implications here for journalling?  Do I have to turn 
off caching and suffer a huge performance hit?


-Steve Bergman

