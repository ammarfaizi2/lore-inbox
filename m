Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267635AbRG0PNI>; Fri, 27 Jul 2001 11:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267641AbRG0PM7>; Fri, 27 Jul 2001 11:12:59 -0400
Received: from garlic.amaranth.net ([216.235.243.195]:23305 "EHLO
	garlic.amaranth.net") by vger.kernel.org with ESMTP
	id <S267635AbRG0PMp>; Fri, 27 Jul 2001 11:12:45 -0400
Message-ID: <3B6184F0.A4D2CE5B@egenera.com>
Date: Fri, 27 Jul 2001 11:12:48 -0400
From: "Philip R. Auld" <pauld@egenera.com>
Organization: Egenera Inc.
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: reiserfs-list@namesys.com, kernel <linux-kernel@vger.kernel.org>,
        Chris Mason <mason@suse.com>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <E15Q7eW-0005cP-00@the-village.bc.nu> <3B6177DB.26C6D378@egenera.com> <3B617FF5.3FCB46A@namesys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hans Reiser wrote:
> 
> "Philip R. Auld" wrote:
> 
> > reiserfs with full data logging enabled of course does not show this behavior
> > (and works really well if you are willing to take the performance hit).
> 
> Hmmm, I didn't realize this had made off our wish list and into the code.:)
> We should benchmark the cost to performance.
> 
> Hans

Ooops, hope I'm not getting Chris in trouble ;)

This is reiserfs 3.5.33, with a few changes from Chris to enable full logging, 
and from me to make it a mount option. 

We are in a situation where we need the safety more than the speed so it was
necessary.


Here is a simple comparison using bonnie:

              -------Sequential Output-------- ---Sequential Input-- --Random--
              -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --Seeks---
Machine    MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU  /sec %CPU
pblade 1 (reiserfs defaults)
         1000 13048 98.9 21609 27.4  6599 10.7 11066 72.3 16483  8.4 1011.2  5.3 
	 1000 12771 96.7 21058 25.9  5536  9.0 10430 67.5 17347  8.4 1065.2  6.7 
	 1000 13034 98.6 19746 21.6  7026 11.6  9884 64.4 14838  7.2 1106.0  9.7
         1000 13091 99.3 19483 28.9  7586 12.3 10520 68.4 14685  6.9  900.9  6.3
pblade 2 (ext2 defaults)
         1000 14373 99.9 14940  8.8  7494 11.1 10093 65.3 22213  9.3 1028.3 
6.4      
	 1000 14305 99.6 16129  9.4  7768 11.9  9629 62.2 26108 10.8 1135.8  7.7    
	 1000 14400 99.9 16769  9.8  7397 11.2  9805 63.4 21820  9.1 1139.8  5.7
	 1000 14361 100. 17089 10.4  7768 11.5  9924 64.1 24154  9.8 1112.9  7.2
pblade 3 (log all data)
	 1000  5932 47.6  7244 12.5  4708  9.7 13909 90.5 17051  8.1 894.5  6.5
	 1000  5839 46.9  7229 12.5  4604  9.9 13437 87.9 19852  9.7 724.3  4.7
	 1000  5853 47.0  7176 12.3  4611  9.8 13995 91.1 18838  8.7 908.0  5.7
	 1000  5604 45.1  7106 12.2  4627  9.5 13628 88.6 15248  6.9 882.9  6.6
pblade 6 ( log new data )
	 1000  5556 49.0  7057 11.9  7714 12.6 11559 92.8 18075  8.8 1264.3  7.3    
	 1000  5631 49.8  7307 12.3  7945 13.0 11558 93.0 18859  9.0 1230.7  8.0
	 1000  5610 49.6  7337 12.5  6620 11.0 11821 95.0 16484  7.5 1236.8  9.3
	 1000  5592 49.4  7070 12.1  7422 12.0 11575 92.9 16198  7.3 1236.6  4.9


I suugest we move this to reiserfs-list for more discussion if needed :)


Cheers,

Phil


------------------------------------------------------
Philip R. Auld, Ph.D.                  Technical Staff 
Egenera Corp.                        pauld@egenera.com
165 Forest St, Marlboro, MA 01752        (508)786-9444
