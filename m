Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270381AbRHXNMa>; Fri, 24 Aug 2001 09:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271283AbRHXNMU>; Fri, 24 Aug 2001 09:12:20 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:50436 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S270381AbRHXNMJ>; Fri, 24 Aug 2001 09:12:09 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Anwar P" <anwarp@mail.com>, linux-kernel@vger.kernel.org
Subject: Re: What version of the kernel fixes these VM issues?
Date: Fri, 24 Aug 2001 15:18:53 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20010824084729.19008.qmail@mail.com>
In-Reply-To: <20010824084729.19008.qmail@mail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010824131220Z16405-32383+1155@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 24, 2001 10:47 am, Anwar P wrote:
> We have big system (8 processors, 8GB ram), running Oracle and this other 
> ETL tool.  Oracle is up and running all the time, and the ETL tool runs 
> once a day.  But everytime the ETL tool runs (along with Oracle), the 
> system seems to run out of memory, and the server comes to a crawl, often 
> with keyborad response in 10 to 15 minute intervals.  We are currently 
> using the 2.4.3-6 kernel that comes with Redhat 7.1.
>  
> We know that Oracle comsumes no more than 2GB of memory at peak usage, and 
> the ETL tool itself consumes less than 1GB.  But the ETL tool does process 
> a whole bunch of text files (total about 6GB worth of), and it runs for 
> about 2 hours.  What happens is that while they are both running, the 
> filesystem cache size increases progressively, and some time later, it 
> begins swapping.  We do have 16GB (2x RAM) of swap.  And when it starts to 
> swap, the server responds to keystrokes/commands randomly and appears dead 
> for 10s of minutes. We know that together our applications do not need more 
> than 4GB of RAM on this 8GB box, so it is the VM that is causing this 
> unnecessary swapping by trying to use too much memory for filesystem cache. 
  
There is no way your system should be going into swap under these conditions 
- it's a bug.  We have probably fixed this already.
  
> So the first question is, is there any way I can limit the amount of memory 
> used for FS cache ?

Um, no, sorry.  This should not be necessary.

> And the next one is, are there any (later) versions of the kernel that are 
> more sane about what the maximum FS cache it should use is ?

Please try 2.4.9 and 2.4.8-ac10.  If the system slows down, look in your logs 
and see if there are any "allocation failed" messages.  Use top or do watch 
cat /proc/meminfo to be sure your system isn't going into swap, and please 
let us know what happens.

--
Daniel
