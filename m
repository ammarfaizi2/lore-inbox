Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291114AbSAaPo5>; Thu, 31 Jan 2002 10:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291113AbSAaPor>; Thu, 31 Jan 2002 10:44:47 -0500
Received: from ns0.cobite.com ([208.222.80.10]:26377 "EHLO ns0.cobite.com")
	by vger.kernel.org with ESMTP id <S291117AbSAaPol>;
	Thu, 31 Jan 2002 10:44:41 -0500
Date: Thu, 31 Jan 2002 10:44:33 -0500 (EST)
From: David Mansfield <lkml@dm.cobite.com>
X-X-Sender: <david@admin>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Errors in the VM - detailed
In-Reply-To: <Pine.LNX.4.30.0201311604470.14025-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.33.0201311017290.15100-100000@admin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2002, Roy Sigurd Karlsbakk wrote:

> hi all
> 
> The last month or so, I've been trying to make a particular configuration work
> with Linux-2.4.17 and other 2.4.x kernels. Two major bugs have been blocking
> my way into the light. Below follows a detailed description on both bugs. One
> of them seems to be solved in the latests -rmap patches. The other is still
> unsolved.
> 
> CONFIGURATION INTRO
> 

My config:

Athlon 1400mhz, 512mb ram, single HD seagate ST360020A 60GB ATA100.  I am 
running the 2.4.17rc2aa2 kernel, which many on the list (and I will 
second) have stated to be a very excellent kernel.  I noticed you haven't 
tried the aa kernels.  You should.

I'm *not* running sw raid however, and this may be the significant factor, 
have you tested your drives singly (without the raid?).


I created 100 100mb files (I don't have enough free space to do anything 
else) using dd if=/dev/zero of=file???.  I did this sequentially.  Then I 
wrote a  second script to use dd if=file??? of=/dev/null & and started 100 
reader in parallel.  There were no stalls in the read from beginning to 
end, my system maintained about 6-8Mb/s xfer rate throughout the test.  
That's about what I would expect for 100 simultaneous readers.


In your tests, are you sure that you are synchronising the starting of 
your reader processes?  Maybe you are seeing the first readers getting 
started first (and you have less seeks ruining your I/O bandwidth) and 
then as they get going, the additional seeks ruin everything.  I honestly 
think this is unlikely, since your I/O level does drop to a disgustingly 
low level.

Hope this helps.


David


-- 
/==============================\
| David Mansfield              |
| david@cobite.com             |
\==============================/

