Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263177AbREaT3U>; Thu, 31 May 2001 15:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263187AbREaT3K>; Thu, 31 May 2001 15:29:10 -0400
Received: from mail2.netcabo.pt ([212.113.161.137]:47372 "EHLO netcabo.pt")
	by vger.kernel.org with ESMTP id <S263177AbREaT26>;
	Thu, 31 May 2001 15:28:58 -0400
Message-ID: <3B169C06.1010507@europe.com>
Date: Thu, 31 May 2001 20:31:18 +0100
From: Vasco Figueira <figueira@europe.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5 i686; en-US; rv:0.9+) Gecko/20010530
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] reclaim dirty dead swapcache pages
In-Reply-To: <Pine.LNX.4.21.0105301729080.5231-100000@freak.distro.conectiva> <3B168B59.70906@europe.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

Vasco Figueira wrote:

 >I've opened x, gnome, mozilla, mozilla -mail, 3 gnome-terminals, pan, 
 >xmms, some files and javac. Swap was totally filled up and it didn't 
 >froze (good!). However suddently it came very busy (i thougth it was 
 >going to freeze again), the music stopped, and came back to normal 
 >again. It had killed xmms, I noticed after.

 >Is it intentional to kill processes? Well, it does reolve the problem, 
 >but kills some processes, probably the most eager ones. I will keep 
 >using this patch and report again if something relevant is found.

 >So far, so good, this is better tha having to swapoff & swapon all the 
 >time. Nice work Marcelo.

Continuing the saga of testing this patch, some more things:

* Swap gets *really* filled up. I don't remember having swap totally 
filled with 2.2. and this has 20M more (doesn't have to do with this 
patch, I think)

* kernel appears to try to free pages only when they are desperatly 
needed, i.e., when swap is full and a big process is needing mem. As an 
example, i was calm editing some text files (swap was full), and called 
javac. System went down to his knees, music stopped, mouse had repent 
stops and javac outputed:"Killed". I assume it was killed :-)

javac was called again and then ran more smootly. Perhaps because his 
pages were already there, no?

It may be better to try to free pages before we get into heavy load. If 
not, we get a pseudo-freeze and a killed process. Wich is not... wonderful.

Comments?
-- 
Regards,
                             Vasco Figueira

http://students.fct.unl.pt/users/vaf12086/

