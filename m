Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267311AbTBPRW2>; Sun, 16 Feb 2003 12:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267315AbTBPRW2>; Sun, 16 Feb 2003 12:22:28 -0500
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.223]:8592 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S267311AbTBPRW0>; Sun, 16 Feb 2003 12:22:26 -0500
Message-ID: <3E4FCADE.2070306@nyc.rr.com>
Date: Sun, 16 Feb 2003 12:31:10 -0500
From: John Weber <weber@nyc.rr.com>
Organization: My House
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: Duncan Sands <baldrick@wanadoo.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5 freezing after uncompressing linux
References: <3E4EFD75.3000708@nyc.rr.com> <200302161017.43944.baldrick@wanadoo.fr>
In-Reply-To: <200302161017.43944.baldrick@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands wrote:
> On Sunday 16 February 2003 03:54, John Weber wrote:
> 
>>[1.] One line summary of the problem:
>>
>>[Linux 2.5] Freezing after Uncompressing Linux
>>
>>[2.] Full description of the problem/report:
>>
>>The kernel freezes immediately after "Uncompressing Linux... OK".
>>No further messages are displayed.  I'm following wli's advice to
>>add some printk's to check whether the system is even getting to
>>startup_32(), but perhaps others have seen this problem.
> 
> 
> Did it really freeze?  Can you see disk activity if you wait?  You may
> simply not have turned on the console in your .config.  For example,
> if you choose to compile the input subsystem as a module, then the
> console automagically gets deselected!
> 
> Duncan.
> 

I finally got around to applying early printk, and I found out that the 
system does indeed get to startup_32().  As it turns out this was simply 
related to a CONFIG problem.  I built-in INPUT (instead of using it as a 
module), and the virtual console CONFIG was then made available.  (NOTE: 
I didn't think to check the input subsystem config, because the last 
time I mistakenly disabled input -- because I simply used "make 
oldconfig" which didn't enable CONFIG_INPUT -- the only thing it 
disabled was the keyboard and mouse).  Why does CONFIG_INPUT affect the 
console?

