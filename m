Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313184AbSD3J5t>; Tue, 30 Apr 2002 05:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313187AbSD3J5s>; Tue, 30 Apr 2002 05:57:48 -0400
Received: from [195.63.194.11] ([195.63.194.11]:10504 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313184AbSD3J5r>; Tue, 30 Apr 2002 05:57:47 -0400
Message-ID: <3CCE5BED.9010809@evision-ventures.com>
Date: Tue, 30 Apr 2002 10:55:09 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: ivangurdiev@linuxfreemail.com
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.11 ide kernel panic
In-Reply-To: <02042920011502.00813@cobra.linux>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Ivan G. napisa?:
> Here's my next attempt to get the kernel working.
> This is 2.5.11 + framebuffer patch for compilation + framebuffer patch for 
> kernel panic (both from James Simmons).
> 
> Oops portion below was copied from the screen. 
> It's a portion since the rest scrolled off the screen.
> Inaccuracies are possible but unlikely ( I double-checked). 
> 


Coudl you please remove the following code (or similar)
from the ata_irq_request() function and see whatever the crash still
happens? It could very well we that hwgroup->drive isn't
initialized during boot under seom cirumstances.



		if (hwgroup->drive->channel->sharing_irq && ch != hwgroup->drive->channel && 
ch->io_ports[IDE_CONTROL_OFFSET]) {
			/* set nIEN for previous channel */
			/* FIXME: check this! It appears to act on the current channel! */

			if (ch->intrproc)
				ch->intrproc(drive);
			else
				OUT_BYTE((drive)->ctl|2, ch->io_ports[IDE_CONTROL_OFFSET]);
		}

