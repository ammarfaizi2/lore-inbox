Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267491AbTBQSer>; Mon, 17 Feb 2003 13:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267492AbTBQSer>; Mon, 17 Feb 2003 13:34:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61202 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267491AbTBQSeq>;
	Mon, 17 Feb 2003 13:34:46 -0500
Message-ID: <3E512D82.4010509@pobox.com>
Date: Mon, 17 Feb 2003 13:44:18 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Roger Luethi <rl@hellgate.ch>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [0/4][via-rhine] Improvements
References: <20030215225204.GA6887@k3.hellgate.ch> <Pine.LNX.4.44.0302151611310.23496-100000@home.transmeta.com> <20030216110117.GA2821@k3.hellgate.ch>
In-Reply-To: <20030216110117.GA2821@k3.hellgate.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Luethi wrote:
>>On Sat, 15 Feb 2003, Roger Luethi wrote:
>>
>>>Thanks for raising that issue. It is my understanding that PIO ops are
>>>synchronous (on IA-32). If that is correct, problems should only occur if
>>>the driver is built with MMIO support, no?
>>
>>No, even PIO ops are asynchronous. They are _more_ synchronous than the
>>MMIO ones (I think the CPU waits until they hit the bus, and most bridges
> 
> 
> Hmmm... A recent thread on PCI write posting seemed to confirm my view [1].
> What am I missing here?


Basically, in a wait_for_reset, performance doesn't matter, so just 
flush with a read, and it will work in all cases :)

A PIO write may be posted through multiple levels of PCI bridges, 
perhaps... in any case, even if PIO is completely synchronous in test 
cases, an additional read will not hurt here.

	Jeff



