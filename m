Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316824AbSGLVtc>; Fri, 12 Jul 2002 17:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318009AbSGLVtb>; Fri, 12 Jul 2002 17:49:31 -0400
Received: from hdfdns02.hd.intel.com ([192.52.58.11]:17091 "EHLO
	mail2.hd.intel.com") by vger.kernel.org with ESMTP
	id <S316824AbSGLVta>; Fri, 12 Jul 2002 17:49:30 -0400
Message-ID: <01BDB7EEF8D4D3119D95009027AE99951B0E6428@fmsmsx33.fm.intel.com>
From: "Griffiths, Richard A" <richard.a.griffiths@intel.com>
To: "'Andrea Arcangeli'" <andrea@suse.de>
Cc: "'Andrew Morton'" <akpm@zip.com.au>,
       "'Marcelo Tosatti'" <marcelo@conectiva.com.br>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'Carter K. George'" <carter@polyserve.com>,
       "'Don Norton'" <djn@polyserve.com>,
       "'James S. Tybur'" <jtybur@polyserve.com>,
       "Gross, Mark" <mark.gross@intel.com>
Subject: Re: fsync fixes for 2.4
Date: Fri, 12 Jul 2002 14:52:11 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark is off climbing Mt. Hood, so he asked me to post the data on the fsync
patch.
It appears from these results that there is no appreciable improvement using
the
fsync patch - there is a slight loss of top end on 4 adapters 1 drive. 
 It's worthnoting that these numbers  are a definite improvement over
generic 2.4.18.
 Something has been done right in 2.4.19rc1.  I included an excerpt of the
data that Mark
 posted for 2.4.18 at the end of this email.

As to scaling - well it scales in reverse.  Two adapters from one to three
drives 
is scaling in the right direction. From then on it's in decline.
Here's the data.
The system is a dual PCI/66 box with 4 good SCSI cards with up to 6
15KRPM ST318452LC drives per card.  (dual 1.2Ghz Pentium 3 with 2 Gig RAM
running kernels high mem support == OFF ) 
 
http://www.intel.com/design/servers/scb2/index.htm?iid=ipp_browse+motherbd_s
cb2&

http://www.adaptec.com/worldwide/product/proddetail.html?sess=no&prodkey=ASC
-39160&cat=Products

The benchmark we are using is bonnie++ version 1.02
http://www.coker.com.au/bonnie++

Running on 2.4.19rc1 base 8KB writes to a 1GB file  on an 
ext2 filesystem:

 2 adapters (on separate PCI buses)
 Drives per card  Total system throughput EXT2        
           1                    105983 KB/sec                 
           2                    179214 KB/sec                  
           3                    180237 KB/sec
           4                    178795 KB/sec
           5                    175484 KB/sec
           6                    172903 KB/sec                 
 
 4 adapters
 Drives per card  Total system throughput EXT2          
           1                     184150 KB/sec                  
           2                     165774 KB/sec                   
           3                     160775 KB/sec
           4                     158326 KB/sec
           5                     157291 KB/sec
           6                     155901 KB/sec

===	===	===	===	===	===

Running on 2.4.19rc1 with the fsync patch:
 2 adapters (on separate PCI buses)
 Drives per card  Total system throughput EXT2        
           1                    107940 KB/sec                 
           2                    176749 KB/sec                  
           3                    181073 KB/sec
           4                    177064 KB/sec
           5                    175080 KB/sec
           6                    173583 KB/sec                 
 
 4 adapters
 Drives per card  Total system throughput EXT2          
           1                     176876 KB/sec                  
           2                     164800 KB/sec                   
           3                     161371 KB/sec
           4                     158792 KB/sec
           5                     156509 KB/sec
           6                     155913 KB/sec    
----------------------------------------------------------------------------
----------------------------------------
Mark's original data on 2.4.18:

> Running on 2.4.18 base, 8KB writes to 300MB files I get the following data
> when run on the ext 2 file system.
> 
> 2 adapters (on separate PCI buses)
> Drives per card  Total system throughput EXT2          EXT3
>           1                      73357 KB/sec                   92095
KB/sec
>           2                    115953 KB/sec                   110956
KB/sec
>           3                    132176 KB/sec
>           4                    139578 KB/sec
>           5                    139085 KB/sec
>           6                    140033 KB/sec                   106883
KB/sec
> 
> 4 adapters
> Drives per card  Total system throughput EXT2          EXT3
>           1                     125282 KB/sec                   121125
KB/sec
>           2                     146632 KB/sec                   117575
KB/sec
>           3                     146622 KB/sec
>           4                     142472 KB/sec
>           5                     142560 KB/sec
>           6                     138835 KB/sec                   116570
KB/sec

