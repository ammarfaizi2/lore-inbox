Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268532AbTCCQll>; Mon, 3 Mar 2003 11:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268560AbTCCQlH>; Mon, 3 Mar 2003 11:41:07 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:50644 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S268532AbTCCQkz>; Mon, 3 Mar 2003 11:40:55 -0500
Date: Mon, 3 Mar 2003 11:50:54 -0500
To: Oleg Drokin <green@namesys.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@digeo.com>,
       mason@suse.com, trond.myklebust@fys.uio.no, jaharkes@cs.cmu.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 iget5_locked port attempt to 2.4
Message-ID: <20030303165054.GC13151@delft.aura.cs.cmu.edu>
Mail-Followup-To: Oleg Drokin <green@namesys.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@digeo.com>,
	mason@suse.com, trond.myklebust@fys.uio.no, jaharkes@cs.cmu.edu,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030220175309.A23616@namesys.com> <20030220154924.7171cbd7.akpm@digeo.com> <20030221220341.A9325@namesys.com> <20030221200440.GA23699@delft.aura.cs.cmu.edu> <20030303170924.B3371@namesys.com> <1046708741.6509.5.camel@irongate.swansea.linux.org.uk> <20030303183838.B4513@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030303183838.B4513@namesys.com>
User-Agent: Mutt/1.5.3i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 06:38:38PM +0300, Oleg Drokin wrote:
> Hello!
> 
> On Mon, Mar 03, 2003 at 04:25:41PM +0000, Alan Cox wrote:
> > >    It's me again, I basically got no reply for this iget5_locked patch
> > >    I have now. Would there be any objections if I try push it to Marcelo
> > >    tomorrow? ;)
> > I just binned it. Certainly its not the kind of stuff I want to test in -ac, 
> > too many VFS changes outside reiserfs
> 
> Andrew Morton said "iget5_locked() looks simple enough, and as far as I can
> tell does not change any existing code - it just adds new stuff.",
> also this code (in its 2.5 incarnation) was tested in 2.5 for long
> time already.

It is simple enough, and it does fixe real bug. However at the time it
was decided that the change should not go into 2.4 because it breaks the
VFS API for 3rd party filesystems. Basically anyone that might be using
iget4 and/or read_inode2 will have to change their filesystem in the
middle of a supposedly stable series.

I believe that argument still stands. Ofcourse anyone using the existing
iget4/read_inode[2] interface is pretty much guaranteed to have broken
code.

> Also it fixes real bug (and while I have another reiserfs-only fix for
> the bug, it is fairly inelegant).

Yeah, I actually hit that bug while working on Coda which prompted the
whole iget5_locked implementation. The fix I used for 2.4 is trivial but
inefficient. Just grab a lock around any call to iget4. I think I used a
semaphore as I wasn't sure whether the iget4 code would sleep.

Jan

