Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316257AbSEKSsA>; Sat, 11 May 2002 14:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316258AbSEKSr7>; Sat, 11 May 2002 14:47:59 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:19206 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S316257AbSEKSr6>;
	Sat, 11 May 2002 14:47:58 -0400
Date: Sat, 11 May 2002 12:45:07 -0600
From: yodaiken@fsmlabs.com
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Gerrit Huizenga <gh@us.ibm.com>, Lincoln Dale <ltd@cisco.com>,
        Andrew Morton <akpm@zip.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT performance impact on 2.4.18 (was: Re: [PATCH] 2.5.14 IDE 56)
Message-ID: <20020511124507.A7603@hq.fsmlabs.com>
In-Reply-To: <E176LG9-0002cP-00@w-gerrit2> <Pine.LNX.4.44.0205111047280.2355-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2002 at 11:04:45AM -0700, Linus Torvalds wrote:
>  (1) readahead: allocate pages, and start the IO asynchronously
>  (2) mmap the file with a MAP_UNCACHED flag, which causes read-faults to
>      "steal" the page from the page cache and make it private to the
>      mapping on page faults.
> 
> If you split it up like that, you can do much more interesting things than
> O_DIRECT can do (ie the above is inherently asynchronous - we'll wait only
> for IO to complete when the page is actually faulted in).


I've never liked mmap although that may just be my advanced age
("we never had mmap, we copied files by cutting cuneiform in fresh
  clay tablets, the way the gods intended ")

	struct kio k;
	k.count = RECORDSIZE;
	fd1 = open("inputfile",KIO_READ);
	fd1a = dup(fd1); //dup creates a non KIO descript for the samefile
	fd2 = open("outputfile",KIO_WRITE);
	while( (n=read(fd1,&k,sizeof struct kio) 
            {
		write(fd2,&k,sizof struct kio);
		if(k.seekposition%10000){
			write(fd1a,"Another record sent,Mr  E.\n",GROVELSIZE);
		}
            }


		
> Sadly, database people don't seem to have any understanding of good taste,
> and various OS people end up usually just saying "Yes, Mr Oracle, I'll
> open up any orifice I have for your pleasure".


When you drive by that campus in redwood city you start to understand how
insignificant you are.


-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

