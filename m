Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271832AbRH0Sqq>; Mon, 27 Aug 2001 14:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271838AbRH0Sqg>; Mon, 27 Aug 2001 14:46:36 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:21265 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S271832AbRH0SqZ>;
	Mon, 27 Aug 2001 14:46:25 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Peter Surda <shurdeek@panorama.sth.ac.at>
Date: Mon, 27 Aug 2001 20:46:17 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: memcpy to videoram eats too much CPU on ATI cards (cach
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <1C537DA22F7@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Aug 01 at 20:13, Peter Surda wrote:
> 
> memcpy-ing 380kB at 25fps takes about 5ms per frame and causes X to eat 1% cpu
> time (time measurements were done by tsc)
> memcpy-ing 760kB at 25fps takes about 11ms per frame, but instead of eating
> 2% CPU time, it eats 35% (yes, that's 35 times more)

It is because of way how time accounting to processes works in Linux.
Your X-server gets time quantum, and starts copying data to videoram.
If it finishes before 1/HZ seconds, no consumed time is accounted to it.

As soon as task does not finish its job in 1/HZ seconds, some time is
accounted to it. Just try running some benchmark together with
your memcpy. You'll found that benchmark slowdown is (almost) linear with
memcpy size. Especially if you'll run benchmark on some nice level.

You can try varying size around 650-750kBs, and you'll find that it clibms
up very quickly in this range, just when consumed time crosses 10ms.
                                        Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
