Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316217AbSEKN1z>; Sat, 11 May 2002 09:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316218AbSEKN1y>; Sat, 11 May 2002 09:27:54 -0400
Received: from boden.synopsys.com ([204.176.20.19]:62677 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S316217AbSEKN1t>; Sat, 11 May 2002 09:27:49 -0400
Date: Sat, 11 May 2002 15:27:38 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Mihai RUSU <dizzy@roedu.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mmap, SIGBUS, and handling it
Message-ID: <20020511132738.GA22916@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Mihai RUSU <dizzy@roedu.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020510.083050.55863714.davem@redhat.com> <Pine.LNX.4.33.0205101900090.9661-100000@ahriman.bucharest.roedu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2002 at 07:04:36PM +0300, Mihai RUSU wrote:
> On Fri, 10 May 2002, David S. Miller wrote:
> 
> >    From: Mihai RUSU <dizzy@roedu.net>
> >    Date: Fri, 10 May 2002 18:37:21 +0300 (EEST)
> >
> >    PS: why signal(SIGBUS,SIG_IGN) doesnt work, but a user handler its called
> >    if set with signal(SIGBUS,handle_sigbus) ?
> >
> > How would you like the kernel to "ignore" a page fault that cannot be
> > serviced?
> >
> 
> You are right, its not that I want to ignore it. The problem was that I
> want to handle it some way but I dont know how. If I will make a user
> handler for it how can I know if its a SIGBUS from a HW error or a SIGBUS
> from that write()-case. Because I have to continue serving files even
> after received a SIGBUS in that write (otherwise my file server will exit
> with SIGBUS and thats no good :) ).
> 
> Take for example any single process ftp/http server, they are hit by this
> problem. Which solution would you recommend ? :)
> 

Just take a closer look on sigaction(2). The field sa_sigaction and
flags SA_SIGINFO in sa_flags can help to identify the source of the
SIGBUS.

SIGACTION(2)        Linux Programmer's Manual        SIGACTION(2)
...
       the  sender  of  the  POSIX.1b  signal.   SIGILL,  SIGFPE,
       SIGSEGV and SIGBUS fill in si_addr with the address of the
       fault.  SIGPOLL fills in si_band and si_fd.
...
       si_code indicates why this  signal  was  sent.   It  is  a
       value,  not  a bitmask.  The values which are possible for
       any signal are listed in this table:
...
       |                  SIGBUS                    |
       +-----------+--------------------------------+
       |BUS_ADRALN | invalid address alignment      |
       +-----------+--------------------------------+
       |BUS_ADRERR | non-existent physical address  |
       +-----------+--------------------------------+
       |BUS_OBJERR | object specific hardware error |


-alex
