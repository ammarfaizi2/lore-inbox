Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131887AbRDNXai>; Sat, 14 Apr 2001 19:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131976AbRDNXa3>; Sat, 14 Apr 2001 19:30:29 -0400
Received: from lange.hostnamen.sind-doof.de ([212.15.192.219]:8207 "HELO
	xena.sind-doof.de") by vger.kernel.org with SMTP id <S131887AbRDNXaW>;
	Sat, 14 Apr 2001 19:30:22 -0400
Date: Sun, 15 Apr 2001 01:29:42 +0200
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Manfred Spraul <manfred@colorfullife.com>,
        Rod Stewart <stewart@dystopia.lab43.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 8139too: defunct threads
Message-ID: <20010415012942.A2171@kallisto.sind-doof.de>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Manfred Spraul <manfred@colorfullife.com>,
	Rod Stewart <stewart@dystopia.lab43.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3AD88A00.DF54EC12@colorfullife.com> <E14oVAp-0005Nj-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14oVAp-0005Nj-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Apr 14, 2001 at 07:53:28PM +0100
X-Operating-System: Debian GNU/Linux (Linux 2.4.3-ac5-int1-nf20010413-dc1 i686)
X-Disclaimer: Are you really taking me serious?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Apr 14, 2001 at 07:53:28PM +0100, Alan Cox wrote:
> > Rod's init version (from RH 7.0) doesn't reap children that died before
> > it was started. Is that an init bug or should the kernel reap them
> > before the execve?
> I would say thats an init bug

It doesn't seem to be that simple.

Redhat's init does child reaping in its SIGCHLD handler using the
following:

while((pid = waitpid(-1, &st, WNOHANG)) != 0) {
    if (errno == ECHILD) break;
    /* do some stuff, nothing which could break out of the loop */
}

This should reap all leftover childs from kernel startup when init
receives SIGCHLD for the first time, but somehow the kernel seems to
skip them while searching for a dead process in sys_wait4().  I can't
do any further testing because I don't have a 8139 NIC, but I can't
find a problem in init's child reaping code.

Please tell me if I'm missing something, but I think this is really a
kernel issue, not a bug in init.

Andreas
-- 
I've finally learned what "upward compatible" means.  It means we get to
keep all our old mistakes.
		-- Dennie van Tassel

