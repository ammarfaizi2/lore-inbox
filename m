Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSFNKpY>; Fri, 14 Jun 2002 06:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317205AbSFNKpX>; Fri, 14 Jun 2002 06:45:23 -0400
Received: from softail.visi.com ([208.42.22.17]:24058 "EHLO ns.nerdvest.com")
	by vger.kernel.org with ESMTP id <S293680AbSFNKpW>;
	Fri, 14 Jun 2002 06:45:22 -0400
Message-ID: <3D09C91A.D3DA652E@visi.com>
Date: Fri, 14 Jun 2002 05:44:42 -0500
From: Bryan Andersen <bryan@visi.com>
Organization: Bogonomicon
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.16d04 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Wakeling <mnw21@bigfoot.com>
CC: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        BugTraq Mailing List <bugtraq@securityfocus.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Very large font size crashing X Font Server and Grounding Serverto a 
 Halt (was: remote DoS in Mozilla 1.0)
In-Reply-To: <Pine.LNX.4.44.0206132255220.4999-100000@server3.jumpleads.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wakeling wrote:

> In this case,
> either the process grows very quickly, or is just plain big. I think the
> out-of-memory killer should target big or growing processes. If it doesn't
> hit the correct process the first time, it will free up a lot more RAM
> than it would otherwise, and it would be likely to get it right the second
> time.

Um, so you want to kill the database server?  Think carefully 
about making automatic selections like that.  Wouldn't it be 
much better to just tell a process that makes a memory request 
that won't fit that it can't have it?  The process can then 
decide on it's own if it is capable of continuing or aborting.

The real solution lies in getting rid of over subscription and 
properly returning NULL for memory allocations when RAM+SWAP 
has run out.  To me this is a kernel memory subsystem issue.  
When the X font server requested that huge block of memory it 
should have been told you can't have it as there is no way it 
would fit within RAM+SWAP-other processes.  No need to kill a 
process.

-- 
|  Bryan Andersen   |   bryan@visi.com   |   http://www.nerdvest.com   |
| Buzzwords are like annoying little flies that deserve to be swatted. |
|      "Linux, the OS Microsoft doesn't want you to know about.".      |
|   -Bryan Andersen                                                    |
