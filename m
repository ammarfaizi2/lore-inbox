Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272836AbRIPVrq>; Sun, 16 Sep 2001 17:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272843AbRIPVri>; Sun, 16 Sep 2001 17:47:38 -0400
Received: from B03c8.pppool.de ([213.7.3.200]:5900 "EHLO bilbo.local")
	by vger.kernel.org with ESMTP id <S272851AbRIPVrW>;
	Sun, 16 Sep 2001 17:47:22 -0400
Date: Sun, 16 Sep 2001 18:53:09 +0200
From: Walter Hofmann <walterh@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: oops with 2.2.19 in get_empty_inode
Message-ID: <20010916185309.A2835@aragorn>
In-Reply-To: <20010916160017.A16225@aragorn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010916160017.A16225@aragorn>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tried 2.2.20pre10. The good news is that it doesn't oops anymore.
The bad news is that Cerberus now reports memory errors. However, the
memory errors don't look like a bad DIMM: I got five reports so far, and
in every case four consecutive bytes of user space memory were
overwritten with what looked like a kernel address:
 c0325048, d8e988df, c0325710, dc2abf88 and d8e9df88
According to System.map,
 c0324de0 is all_requests
 c03269e0 is ro_bits
I attached the full report.

Walter



Ceiling: 379904K
Attempting: 379904K
Testing: 97255424 integers, 379904K
Testing block_size 16384 (64K), alignment 0, with larry...Verifying...Done.
[...]
Testing block_size 19451084 (75980K), alignment 3, with larry...Verifying...Done.
Testing block_size 38902169 (151961K), alignment 0, with larry...Verifying...Done.
Testing block_size 38902169 (151961K), alignment 1, with larry...Verifying...Error at offset 25206248 of 38902168, alignment 1:
Local process address: 0x461677a9
Failure Context: 
            offset           expected                got
          25206245           ac2b488f           ac2b488f
          25206246           ac2b4890           ac2b4890
          25206247           ac2b4891           ac2b4891
          25206248           ac2b4892           482b4892  *** fail location
          25206249           ac2b4893           acc03250
          25206250           ac2b4894           ac2b4894
          25206251           ac2b4895           ac2b4895
          25206252           ac2b4896           ac2b4896
          25206253           ac2b4897           ac2b4897
          25206254           ac2b4898           ac2b4898
Scanning /proc/kcore.  Fire in the hole!
Possible location of memory failure: 0x82d77a9 (130M) on page 33495
1941 795 fail_page_offset
System RAM fault likely.
Son Sep 16 16:57:29 CEST 2001: MEMORY FAILED: on 2/0 after 41s
Ceiling: 379904K
Attempting: 379904K
Testing: 97255424 integers, 379904K
Testing block_size 16384 (64K), alignment 0, with larry...Verifying...Done.
Testing block_size 16384 (64K), alignment 1, with larry...Verifying...Done.
Testing block_size 16384 (64K), alignment 2, with larry...Verifying...Done.
Testing block_size 16384 (64K), alignment 3, with larry...Verifying...Done.
Testing block_size 32768 (128K), alignment 0, with larry...Verifying...Done.
Testing block_size 32768 (128K), alignment 1, with larry...Verifying...Done.
[...]
Ceiling: 379904K
Attempting: 379904K
Testing: 97255424 integers, 379904K
Testing block_size 16384 (64K), alignment 0, with larry...Verifying...Done.
Testing block_size 16384 (64K), alignment 1, with larry...Verifying...Done.
Testing block_size 16384 (64K), alignment 2, with larry...Verifying...Done.
Testing block_size 16384 (64K), alignment 3, with larry...Verifying...Done.
Testing block_size 32768 (128K), alignment 0, with larry...Verifying...Done.
Testing block_size 32768 (128K), alignment 1, with larry...Verifying...Done.
Testing block_size 32768 (128K), alignment 2, with larry...Verifying...Done.
Testing block_size 32768 (128K), alignment 3, with larry...Verifying...Done.
Testing block_size 49152 (192K), alignment 0, with larry...Verifying...Done.
Testing block_size 49152 (192K), alignment 1, with larry...Verifying...Done.
Testing block_size 49152 (192K), alignment 2, with larry...Verifying...Done.
Testing block_size 49152 (192K), alignment 3, with larry...Verifying...Done.
Testing block_size 65536 (256K), alignment 0, with larry...Verifying...Done.
Testing block_size 65536 (256K), alignment 1, with larry...Verifying...Done.
Testing block_size 65536 (256K), alignment 2, with larry...Verifying...Done.
Testing block_size 65536 (256K), alignment 3, with larry...Verifying...Done.
Testing block_size 81920 (320K), alignment 0, with larry...Verifying...Done.
Testing block_size 81920 (320K), alignment 1, with larry...Verifying...Done.
Testing block_size 81920 (320K), alignment 2, with larry...Verifying...Done.
Testing block_size 81920 (320K), alignment 3, with larry...Verifying...Done.
Testing block_size 98304 (384K), alignment 0, with larry...Verifying...Done.
Testing block_size 98304 (384K), alignment 1, with larry...Verifying...Done.
Testing block_size 98304 (384K), alignment 2, with larry...Verifying...Done.
Testing block_size 98304 (384K), alignment 3, with larry...Verifying...Done.
Testing block_size 114688 (448K), alignment 0, with larry...Verifying...Done.
Testing block_size 114688 (448K), alignment 1, with larry...Verifying...Done.
Testing block_size 114688 (448K), alignment 2, with larry...Verifying...Done.
Testing block_size 114688 (448K), alignment 3, with larry...Verifying...Done.
Testing block_size 131072 (512K), alignment 0, with larry...Verifying...Done.
Testing block_size 131072 (512K), alignment 1, with larry...Verifying...Done.
Testing block_size 131072 (512K), alignment 2, with larry...Verifying...Done.
Testing block_size 131072 (512K), alignment 3, with larry...Verifying...Done.
Testing block_size 147456 (576K), alignment 0, with larry...Verifying...Done.
Testing block_size 147456 (576K), alignment 1, with larry...Verifying...Done.
Testing block_size 147456 (576K), alignment 2, with larry...Verifying...Done.
Testing block_size 147456 (576K), alignment 3, with larry...Verifying...Done.
Testing block_size 19451084 (75980K), alignment 0, with larry...Verifying...Done.
Testing block_size 19451084 (75980K), alignment 1, with larry...Verifying...Done.
Testing block_size 19451084 (75980K), alignment 2, with larry...Verifying...Done.
Testing block_size 19451084 (75980K), alignment 3, with larry...Verifying...Done.
Testing block_size 38902169 (151961K), alignment 0, with larry...Verifying...Done.
Testing block_size 38902169 (151961K), alignment 1, with larry...Verifying...Done.
Testing block_size 38902169 (151961K), alignment 2, with larry...Verifying...Done.
Testing block_size 38902169 (151961K), alignment 3, with larry...Verifying...Done.
Testing block_size 58353254 (227942K), alignment 0, with larry...Verifying...Done.
Testing block_size 58353254 (227942K), alignment 1, with larry...Verifying...Done.
Testing block_size 58353254 (227942K), alignment 2, with larry...Verifying...Done.
Testing block_size 58353254 (227942K), alignment 3, with larry...Verifying...Done.
Testing block_size 77804339 (303923K), alignment 0, with larry...Verifying...Done.
Testing block_size 77804339 (303923K), alignment 1, with larry...Verifying...Done.
Testing block_size 77804339 (303923K), alignment 2, with larry...Verifying...Done.
Testing block_size 77804339 (303923K), alignment 3, with larry...Verifying...Done.
Testing block_size 97255424 (379904K), alignment 0, with larry...Verifying...Done.
Testing block_size 97255424 (379904K), alignment 1, with larry...Verifying...Done.
Testing block_size 97255424 (379904K), alignment 2, with larry...Verifying...Error at offset 28510766 of 97255423, alignment 2:
Local process address: 0x46e028c2
Failure Context: 
            offset           expected                got
          28510763           ac5db4d5           ac5db4d5
          28510764           ac5db4d6           ac5db4d6
          28510765           ac5db4d7           ac5db4d7
          28510766           ac5db4d8           df88b4d8  *** fail location
          28510767           ac5db4d9           ac5dd8e9
          28510768           ac5db4da           ac5db4da
          28510769           ac5db4db           ac5db4db
          28510770           ac5db4dc           ac5db4dc
          28510771           ac5db4dd           ac5db4dd
          28510772           ac5db4de           ac5db4de
Scanning /proc/kcore.  Fire in the hole!
Possible location of memory failure: 0x831e8c2 (131M) on page 33566
2222 8ae fail_page_offset
System RAM fault likely.
Son Sep 16 17:36:31 CEST 2001: MEMORY FAILED: on 60/0 after 39m43s
[...]
Testing block_size 19451084 (75980K), alignment 2, with larry...Verifying...Done.
Testing block_size 19451084 (75980K), alignment 3, with larry...Verifying...Done.
Testing block_size 38902169 (151961K), alignment 0, with larry...Verifying...Done.
Testing block_size 38902169 (151961K), alignment 1, with larry...Verifying...Done.
Testing block_size 38902169 (151961K), alignment 2, with larry...Verifying...Done.
Testing block_size 38902169 (151961K), alignment 3, with larry...Verifying...Done.
Testing block_size 58353254 (227942K), alignment 0, with larry...Verifying...Done.
Testing block_size 58353254 (227942K), alignment 1, with larry...Verifying...Done.
Testing block_size 58353254 (227942K), alignment 2, with larry...Verifying...Done.
Testing block_size 58353254 (227942K), alignment 3, with larry...Verifying...Done.
Testing block_size 77804339 (303923K), alignment 0, with larry...Verifying...Done.
Testing block_size 77804339 (303923K), alignment 1, with larry...Verifying...Done.
Testing block_size 77804339 (303923K), alignment 2, with larry...Verifying...Done.
Testing block_size 77804339 (303923K), alignment 3, with larry...Verifying...Done.
Testing block_size 97255424 (379904K), alignment 0, with larry...Verifying...Done.
Testing block_size 97255424 (379904K), alignment 1, with larry...Verifying...Error at offset 44100072 of 97255423, alignment 1:
Local process address: 0x4a97a7a9
Failure Context: 
            offset           expected                got
          44100069           ad4b948f           ad4b948f
          44100070           ad4b9490           ad4b9490
          44100071           ad4b9491           ad4b9491
          44100072           ad4b9492           104b9492  *** fail location
          44100073           ad4b9493           adc03257
          44100074           ad4b9494           ad4b9494
          44100075           ad4b9495           ad4b9495
          44100076           ad4b9496           ad4b9496
          44100077           ad4b9497           ad4b9497
          44100078           ad4b9498           ad4b9498
Scanning /proc/kcore.  Fire in the hole!
Possible location of memory failure: 0x92d77a9 (146M) on page 37591
1941 795 fail_page_offset
System RAM fault likely.
Son Sep 16 17:53:55 CEST 2001: MEMORY FAILED: on 79/0 after 57m7s
[...]
Testing block_size 97255424 (379904K), alignment 2, with larry...Verifying...Done.
Testing block_size 97255424 (379904K), alignment 3, with larry...Verifying...Error at offset 51442222 of 97255423, alignment 3:
Local process address: 0x4c57c8c3
Failure Context:
            offset           expected                got
          51442219           adbb9cd5           adbb9cd5
          51442220           adbb9cd6           adbb9cd6
          51442221           adbb9cd7           adbb9cd7
          51442222           adbb9cd8           2abf88d8  *** fail location
          51442223           adbb9cd9           adbb9cdc
          51442224           adbb9cda           adbb9cda
          51442225           adbb9cdb           adbb9cdb
          51442226           adbb9cdc           adbb9cdc
          51442227           adbb9cdd           adbb9cdd
          51442228           adbb9cde           adbb9cde
Scanning /proc/kcore.  Fire in the hole!
Possible location of memory failure: 0x831e8c3 (131M) on page 33566
2223 8af fail_page_offset
System RAM fault likely.
Son Sep 16 18:31:19 CEST 2001: MEMORY FAILED: on 124/0 after 1h34m31s
[...]
Testing block_size 97255424 (379904K), alignment 1, with larry...Verifying...Done.
Testing block_size 97255424 (379904K), alignment 2, with larry...Verifying...Done.
Testing block_size 97255424 (379904K), alignment 3, with larry...Verifying...Error at offset 55970350 of 97255423, alignment 3:
Local process address: 0x4d6c28c3
Failure Context:
            offset           expected                got
          55970347           ae00b4d5           ae00b4d5
          55970348           ae00b4d6           ae00b4d6
          55970349           ae00b4d7           ae00b4d7
          55970350           ae00b4d8           e9df88d8  *** fail location
          55970351           ae00b4d9           ae00b4d8
          55970352           ae00b4da           ae00b4da
          55970353           ae00b4db           ae00b4db
          55970354           ae00b4dc           ae00b4dc
          55970355           ae00b4dd           ae00b4dd
          55970356           ae00b4de           ae00b4de
Scanning /proc/kcore.  Fire in the hole!
Possible location of memory failure: 0x831e8c3 (131M) on page 33566
2223 8af fail_page_offset
System RAM fault likely.
Son Sep 16 18:39:49 CEST 2001: MEMORY FAILED: on 135/0 after 1h43m1s
