Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268544AbTCAKaJ>; Sat, 1 Mar 2003 05:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268545AbTCAKaJ>; Sat, 1 Mar 2003 05:30:09 -0500
Received: from packet.digeo.com ([12.110.80.53]:5565 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268544AbTCAKaH>;
	Sat, 1 Mar 2003 05:30:07 -0500
Date: Sat, 1 Mar 2003 02:40:24 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: anticipatory scheduling questions
Message-Id: <20030301024024.52aefd7a.akpm@digeo.com>
In-Reply-To: <20030301102518.21569.qmail@linuxmail.org>
References: <20030301102518.21569.qmail@linuxmail.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Mar 2003 10:40:23.0778 (UTC) FILETIME=[F6E5BC20:01C2DFDE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org> wrote:
>
> ----- Original Message ----- 
> > > It wasn't a typo... In fact, both deadline and AS give roughly the same 
> > > timings (one second up or down). But I  
> > > still don't understand why 2.5 is performing so much worse than 2.4. 
> >  
> > Me either.  It's a bug. 
> >  
> > Does basic 2.5.63 do the same thing?  Do you have a feel for when it started 
> > happening? 
>  
> This has happened since the moment I switched from 2.4 to 2.5.63-mm1. 

You have not actually said whether 2.5.63 base exhibits the same problem. 
>From the vmstat traces it appears that the answer is "yes"?

> > > Could a "vmstat" or "iostat" dump be interesting?  
> > 2.4 versus 2.5 would be interesting, yes. 
>  
> I have retested this with 2.4.20-2.54, 2.5.63 and 2.5.63-mm1... 
> and have attached the files to this message

Thanks.  Note how 2.4 is consuming a few percent CPU, whereas 2.5 is
consuming 100%.  Approximately half of it system time.

It does appear that some change in 2.5 has caused evolution to go berserk
during this operation.


> (I think pasting them 
> here would result in wrapping, making it harder to read). 
>  
> If you need more testing or benchmarking, ask for it :-) 

Thanks for your patience.

The next step please is:

a) run top during the operation, work out which process is chewing all
   that CPU.  Presumably it will be evolution or aspell

b) Do it again and this time run

	strace -p $(pidof evolution)	# or aspell

This will tell us what it is up to.


