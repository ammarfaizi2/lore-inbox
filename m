Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266527AbSLUGGk>; Sat, 21 Dec 2002 01:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266528AbSLUGGk>; Sat, 21 Dec 2002 01:06:40 -0500
Received: from sabre.velocet.net ([216.138.209.205]:12809 "HELO
	sabre.velocet.net") by vger.kernel.org with SMTP id <S266527AbSLUGGk>;
	Sat, 21 Dec 2002 01:06:40 -0500
To: Gregory Stark <gsstark@MIT.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with read blocking for a long time on /dev/scd1
References: <87adj0b3hj.fsf@stark.dyndns.tv>
In-Reply-To: <87adj0b3hj.fsf@stark.dyndns.tv>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 21 Dec 2002 01:14:38 -0500
Message-ID: <87u1h799v5.fsf@stark.dyndns.tv>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Gregory Stark <gsstark@MIT.EDU> writes:

> I'm having a problem with ogle that seems to be being caused by the scsi or
> ide-scsi driver. The video playback freezes for a second or randomly,
> sometimes every few seconds, sometimes not for several minutes. Every such
> glitch is correlated perfectly with a read syscall reading on /dev/scd1
> blocking for an inordinate amount of time.
> 
> Most read syscalls from ogle seem to take between 30us to 100ms depending on
> the size of the read. In fact plotting the time taken reported by strace -T vs
> the size of the read in gnuplot produces a nice obvious linear correlation.

One more piece of data I just found. Whenever the read blocks for a long time
like this it seems ps lists the process's wait channel as "lock_p". The only
matching symbol is lock_page. 

Does that help narrow down the source of the latency or is that just what the
device driver happens to use as its synchronization primitive?

--
greg

