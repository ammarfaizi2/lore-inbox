Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbVFMRBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVFMRBb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 13:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbVFMRBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 13:01:30 -0400
Received: from mailhub3.nextra.sk ([195.168.1.146]:55556 "EHLO
	mailhub3.nextra.sk") by vger.kernel.org with ESMTP id S261877AbVFMRB2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 13:01:28 -0400
Message-ID: <42ADBBE0.1030901@rainbow-software.org>
Date: Mon, 13 Jun 2005 19:01:20 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Nick Piggin <nickpiggin@yahoo.com.au>,
       Grant Coady <grant_lkml@dodo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Odd IDE performance drop 2.4 vs 2.6?
References: <ac0qa19omlt7bsh8mcfsfr2uhshk338f0c@4ax.com>	 <42AD6362.1000109@rainbow-software.org>	 <1118669975.13260.23.camel@localhost.localdomain>	 <42AD92F2.7080108@yahoo.com.au> <1118675343.13773.1.camel@localhost.localdomain>
In-Reply-To: <1118675343.13773.1.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Llu, 2005-06-13 at 15:06, Nick Piggin wrote:
> 
>>>Make sure you have pre-empt disabled and the antcipatory I/O scheduler
>>>disabled. 
>>>
>>
>>I don't think that those could explain it.
> 
> 
> Try it and see. The anticipatory I/O scheduler does horrible things to
> my IDE streaming performance numbers and to swap performance. It tries
> to merge I/O by delaying it which is deeply ungood when it comes to IDE
> streaming even if its good for general I/O.

Changing the scheduler did not help (the results are about the same with 
any of the 4 schedulers). Read ahead is already set to 256 (increasing 
to 1024 did not help either). Kernel compilation takes too much time 
here so I didn't test with preempt disabled.
The drive is WD300BB (7200RPM) in UDMA2 mode.

root@pentium:~# cat /sys/block/hda/queue/scheduler
noop anticipatory [deadline] cfq
root@pentium:~# hdparm -tT /dev/hda

/dev/hda:
  Timing cached reads:   176 MB in  2.00 seconds =  88.00 MB/sec
  Timing buffered disk reads:   34 MB in  3.02 seconds =  11.26 MB/sec
root@pentium:~# hdparm /dev/hda

/dev/hda:
  multcount    = 16 (on)
  IO_support   =  1 (32-bit)
  unmaskirq    =  1 (on)
  using_dma    =  1 (on)
  keepsettings =  1 (on)
  readonly     =  0 (off)
  readahead    = 256 (on)
  geometry     = 58168/16/63, sectors = 58633344, start = 0


-- 
Ondrej Zary
