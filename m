Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265789AbUFWS2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265789AbUFWS2r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 14:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266598AbUFWS2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 14:28:47 -0400
Received: from 82-147-17-1.dsl.uk.rapidplay.com ([82.147.17.1]:54355 "HELO
	82-147-17-1.dsl.uk.rapidplay.com") by vger.kernel.org with SMTP
	id S265789AbUFWS2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 14:28:45 -0400
From: Mark Watts <mrwatts@fast24.co.uk>
To: linux-kernel@vger.kernel.org, ben@easynews.com
Subject: Re: I/O Confirmation/Problem under 2.6/2.4
Date: Wed, 23 Jun 2004 19:28:43 +0100
User-Agent: KMail/1.6.1
References: <1088012966.1347.28.camel@solaris.skunkware.org>
In-Reply-To: <1088012966.1347.28.camel@solaris.skunkware.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406231928.43759.mrwatts@fast24.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I get the following performance numbers from a Dell PowerEdge 1750 (2x Xeon) 
with a Perc 4/Di (megaraid driver). 13x U320 10k 146GB disks configured in a 
raid5 (in a PowerVault 220s external U320 enclosure).

Kernel is 2.6.3 (Mandrake 10.0)


# bonnie++ -u mwatts -d .
Using uid:500, gid:500.
Writing with putc()...done
Writing intelligently...done
Rewriting...done
Reading with getc()...done
Reading intelligently...done
start 'em...done...done...done...
Create files in sequential order...done.
Stat files in sequential order...done.
Delete files in sequential order...done.
Create files in random order...done.
Stat files in random order...done.
Delete files in random order...done.
Version 1.02c       ------Sequential Output------ --Sequential Input- 
--Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- 
--Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec 
%CP
ircd.eris.qineti 4G 28774  99 89047  93 54483  21 34335  89 115549  20 575.2   
1
                    ------Sequential Create------ --------Random 
Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- 
-Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec 
%CP
                 16  2192  99 +++++ +++ +++++ +++  2197  99 +++++ +++  5526  
99
ircd.eris.qinetiq.com,4G,28774,99,89047,93,54483,21,34335,89,115549,20,575.2,1,16,2192,99,
+++++,+++,+++++,+++,2197,99,+++++,+++,5526,99


hdparm:

# hdparm -tT /dev/sdb

/dev/sdb:
 Timing buffer-cache reads:   2812 MB in  2.00 seconds = 1404.11 MB/sec
 Timing buffered disk reads:  294 MB in  3.00 seconds =  97.92 MB/sec


I've been advised that the megaraid2 driver can be faster, but I've yet to try 
it.

Mark.
