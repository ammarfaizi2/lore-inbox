Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293603AbSCEEey>; Mon, 4 Mar 2002 23:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293604AbSCEEep>; Mon, 4 Mar 2002 23:34:45 -0500
Received: from mail.gmx.de ([213.165.64.20]:23942 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S293603AbSCEEef>;
	Mon, 4 Mar 2002 23:34:35 -0500
Message-ID: <3C8449FE.830F881F@gmx.de>
Date: Tue, 05 Mar 2002 05:30:54 +0100
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Davide Libenzi <davidel@xmailserver.org>,
        Hubertus Franke <frankeh@watson.ibm.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fast Userspace Mutexes III.
In-Reply-To: <Pine.LNX.4.44.0203041305250.1561-100000@blue1.dev.mcafeelabs.com> <1015293007.882.87.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> On Mon, 2002-03-04 at 17:15, Davide Libenzi wrote:
> 
> > That's great. What if the process holding the mutex dies while there're
> > sleeping tasks waiting for it ?
> 
> I can't find an answer in the code (meaning the lock is lost...) and no
> one has yet answered.  Davide, have you noticed anything?
> 
> I think this needs a proper solution..

You can't do very much.  The futex holder has probably damaged some
data.  The only thing you could do is to kill all current and future
waiters too.  But the "future waiters" is difficult.  The process
may hold other locks the kernel does not know anything about.

The only thing one could do is to kill all processes that share a
MAP_SEM page with a dying process.

Ciao, ET.
