Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274520AbRJEXWg>; Fri, 5 Oct 2001 19:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274522AbRJEXW1>; Fri, 5 Oct 2001 19:22:27 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:270 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S274520AbRJEXWJ>; Fri, 5 Oct 2001 19:22:09 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Alex Pennace <alex@pennace.org>
Date: Sat, 6 Oct 2001 09:22:00 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15294.16536.430907.650513@notabene.cse.unsw.edu.au>
Cc: Bernd Eckenfels <ecki@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: Desperately missing a working "pselect()" or similar...
In-Reply-To: message from Alex Pennace on Friday October 5
In-Reply-To: <3BBDD37D.56D7B359@isg.de>
	<E15pbid-0007fi-00@calista.inka.de>
	<20011005190523.A6516@buick.pennace.org>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday October 5, alex@pennace.org wrote:
> On Fri, Oct 05, 2001 at 10:36:53PM +0200, Bernd Eckenfels wrote:
> > In article <3BBDD37D.56D7B359@isg.de> you wrote:
> > > Without a proper pselect() implementation (the one in glibc is just
> > > a mock-up that doesn't prevent the race condition) I'm currently
> > > unable to come up with a good idea on how to wait on both types
> > > of events.
> > 
> > Isnt select() returning with EINTR?
> 
> The select system call doesn't return EINTR when the signal is caught
> prior to entry into select.

A technique I used in a similar situation once went something like:

tv.tv_sec=bignum;
tv.tv_usec = 0;
enable_signals();
select(nfds, &readfds,&writefds,0,&tv);

and have the signal handlers set tv.tv_sec to 0. (tv is a global
variable).

Then if the signal comes before the select, the select exits
immediately.

NeilBrown
