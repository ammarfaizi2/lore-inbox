Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310673AbSCMPkw>; Wed, 13 Mar 2002 10:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310675AbSCMPkm>; Wed, 13 Mar 2002 10:40:42 -0500
Received: from [195.63.194.11] ([195.63.194.11]:64018 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310673AbSCMPk2>; Wed, 13 Mar 2002 10:40:28 -0500
Message-ID: <3C8F7292.5080409@evision-ventures.com>
Date: Wed, 13 Mar 2002 16:38:58 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE(?) lockups in 2.5.7pre1, 2.5.6, 2.5.6pre3
In-Reply-To: <200203131533.HAA09497@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter wrote:
> 	Under 2.5.6-pre3 and 2.5.6, my desktop workstation would
> occasionally get into a state where all disk I/O would block.
> Process would run until they had to go to the disk, and then they
> would stop.  Hitting ctrl-<scroll lock> shows these process in "D"
> state.  The IDE controller in this machine is:
> 
> 00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
> 
> 	I just built 2.5.7-pre1 and have discovered the other machne
> that has a VIA IDE controller developed the same problem just after
> printing its first "login: " prompt, although it did not have the problem
> on a subsequent reboot.  This other machine did not lock up with
> 2.5.6-pre3 or 2.5.6, although that is probably just due to random
> chance, as the problem was occurring only once a day.  The
> IDE controller in this second machine is:
> 
> 00:04.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10)
> 
> 	I will try to track this down from the process stack traces
> when it happens next, but I thought I ought to report it in the meantime.
> 

You may have noted that I'm gradually trying to replace
all cli() sti() stuff, where it's using for data structure
access by proper spin locks on ide_lock. Maybe this just
uncovered something which was hidden by the brute force used
before? (Could you possible have a look at this direction?)

