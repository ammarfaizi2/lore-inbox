Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289824AbSAWLxH>; Wed, 23 Jan 2002 06:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289817AbSAWLw6>; Wed, 23 Jan 2002 06:52:58 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:30215 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S289811AbSAWLwt>; Wed, 23 Jan 2002 06:52:49 -0500
Message-ID: <3C4EA3FB.93A98AB9@aitel.hist.no>
Date: Wed, 23 Jan 2002 12:52:27 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.2-dj2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: m.knoblauch@teraport.de, linux-kernel@vger.kernel.org
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <3C4E85BB.FBC5C2E4@TeraPort.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Knoblauch wrote:
> 
> > Re: Possible Idea with filesystem buffering.
> >
> > From: Richard B. Johnson (root@chaos.analogic.com)
> > Date: Tue Jan 22 2002 - 17:10:27 EST
> >
> >
> > We need a free-RAM target, possibly based upon a percentage of
> > available RAM. The lack of such a target is what causes the
> > out-of-RAM condition we have been experiencing. Somebody thought
> > that "free RAM is wasted RAM" and the VM has been based upon
> > that theory. That theory has been proven incorrect. You need
> 
As far as I know, there is a free target.  The kernel will try to get 
rid of old pages (swapout program memory, toss cache pages)
when there's too little free memory around.  This keeps memory
around so future allocations and IO request may start
immediately.  Maybe the current target is too small, but it is there.
Without it, _every_ allocation or file operation would block
waiting for a swapout/cache flush in order to get free pages.  Linux
isn't nearly _that_ bad.

>  Now, I think the theory itself is OK. The problem is that the stuff in
> buffer/caches is to sticky. It does not go away when "more important"
> uses for memory come up. Or at least it does not go away fast enough.
> 
Then we need a larger free target to cope with the slow cache freeing.

> > free RAM, just like you need "excess horsepower" to make
> > automobiles drivable. That free RAM is the needed "rubber-band"
> > to absorb the dynamics of real-world systems.
> 
>  Question: what about just setting a maximum limit to the cache/buffer
> size. Either absolute, or as a fraction of total available memory? Sure,
> it maybe a waste of memory in most situations, but sometimes the
> administrator/user of a system simply "knows better" than the FVM (F ==
> Fine ? :-)
[...]
>  I know, the tuning-knob approach is frowned upon. But sometimes there
> are workloads where even the best VM may not know how to react
> correctly.

Wasting memory "in most situations" isn't really an option.  But I
see nothing wrong with "knobs" as long as they are automatic by
default.  Those who want to optimize for a corner case can
go and turn off the autopilot.

Helge Hafting
