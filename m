Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274603AbRJEXaq>; Fri, 5 Oct 2001 19:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274596AbRJEXag>; Fri, 5 Oct 2001 19:30:36 -0400
Received: from smi-105.smith.uml.edu ([129.63.206.105]:55558 "HELO
	buick.pennace.org") by vger.kernel.org with SMTP id <S274586AbRJEXa2>;
	Fri, 5 Oct 2001 19:30:28 -0400
Date: Fri, 5 Oct 2001 19:30:49 -0400
From: Alex Pennace <alex@pennace.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Bernd Eckenfels <ecki@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: Desperately missing a working "pselect()" or similar...
Message-ID: <20011005193049.A6981@buick.pennace.org>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	Bernd Eckenfels <ecki@lina.inka.de>, linux-kernel@vger.kernel.org
In-Reply-To: <3BBDD37D.56D7B359@isg.de> <E15pbid-0007fi-00@calista.inka.de> <20011005190523.A6516@buick.pennace.org> <15294.16536.430907.650513@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15294.16536.430907.650513@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 06, 2001 at 09:21:38AM +1000, Neil Brown wrote:
> On Friday October 5, alex@pennace.org wrote:
> > The select system call doesn't return EINTR when the signal is caught
> > prior to entry into select.
> 
> A technique I used in a similar situation once went something like:
> 
> tv.tv_sec=bignum;
> tv.tv_usec = 0;
> enable_signals();
> select(nfds, &readfds,&writefds,0,&tv);
> 
> and have the signal handlers set tv.tv_sec to 0. (tv is a global
> variable).

I've thought about that, but I haven't been able to find any guarantee
that there will be no user space futzing around with &tv, like a
library wrapper that copies tv to another spot in memory and invokes
the syscall with that address.
