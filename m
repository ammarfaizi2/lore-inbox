Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318734AbSHQSrA>; Sat, 17 Aug 2002 14:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318735AbSHQSrA>; Sat, 17 Aug 2002 14:47:00 -0400
Received: from gra-vd1.iram.es ([150.214.224.250]:34492 "EHLO gra-vd1.iram.es")
	by vger.kernel.org with ESMTP id <S318734AbSHQSq7>;
	Sat, 17 Aug 2002 14:46:59 -0400
Message-ID: <3D5E9B03.4070503@iram.es>
Date: Sat, 17 Aug 2002 20:50:43 +0200
From: Gabriel Paubert <paubert@iram.es>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.0.0) Gecko/20020531
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: James Bottomley <James.Bottomley@HansenPartnership.com>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: Boot failure in 2.5.31 BK with new TLS patch
References: <Pine.LNX.4.44.0208171134070.3169-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
 > The gdt descriptor alignment really shouldn't matter, but that bogus
 > GDT _size_ thing in the descriptor might do it.

Indeed.


 > Right now it's set to be 0x8000, which is not a legal GDT size (it
 > should be of the form n*8-1), and is nonsensical anyway (the comment
 > says 2048 entries, but the fact is, we don't _have_ 2048 entries in
 > there).

In my source tree pulled about at the end of last night here (10pm in 
California) it is still GDT_ENTRIES*8-1. Time to pull :-)

	Gabriel.

P.S: since the first entry is not used, the first 8 bytes could be filled
with
	1:	.word 0
gdt_table_desc: .word GDT_ENTRIES*8-1
		.long 1b

to eliminate the array of GDT descriptors and save a few bytes.

