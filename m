Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132707AbRDUPp1>; Sat, 21 Apr 2001 11:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132708AbRDUPpR>; Sat, 21 Apr 2001 11:45:17 -0400
Received: from elf.ihep.su ([194.190.161.106]:56327 "EHLO elf.ihep.su")
	by vger.kernel.org with ESMTP id <S132707AbRDUPpI>;
	Sat, 21 Apr 2001 11:45:08 -0400
Date: Sat, 21 Apr 2001 19:45:03 +0400
From: "Eugene B. Berdnikov" <berd@elf.ihep.su>
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug report: tcp staled when send-q != 0, timers == 0.
Message-ID: <20010421194503.H23490@elf.ihep.su>
In-Reply-To: <20010413125437.D25085@elf.ihep.su> <200104181928.XAA04912@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <200104181928.XAA04912@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Wed, Apr 18, 2001 at 11:28:43PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello.

On Wed, Apr 18, 2001 at 11:28:43PM +0400, kuznet@ms2.inr.ac.ru wrote:
> >  However, this is _not_ a staled state. When I resume ssh on 194.190.166.31,
> >  buffer gets empty and connection behaves as normal. I made this experiment
> >  waiting for keepalive packets from both sides, as well as resuming ssh
> >  before keepalives. In both cases connection did not become stale.
> 
> Yes, I have said that it is practically impossible to reproduce this.
> My guess was that it is due to inaccurate counting of sacks when path
> mtu discovery happens or when segments are fragmented due to SWS avoidance
> override.

 Im my case P-MTU discovery and fragmentation should be ruled out, but
 sacks are really frequent: my hosts are connected via poor leased line.

> Actually, the most dubious place is your statement that this connection
> was not idle for 2 hours. It is _necessary_ condition
> for my scenario to work...

 I only wrote that it was active when got stuck. It may be idle before -
 I do not remember, but have a habit to keep connections for weeks. :)

 As my experiments show, any connection, entering keepalive once,
 have lose its ability to send zero probes - forever.

> >  [I hope we will continue this discussion later.]
> 
> I am ready.

 OK. Let us return to the "mss/mtu bug". The most mystifying thing for
 me is the dependance of the MTU threshold on the kernel version, etc.

 I also wrote that it depends on keepalive flag. It seems, it was a mistake.
 My additional experiments show that there is no distinct threshold of MTU:
 trying the same value many times, I observed loss of acks in some cases,
 and in some did not. So, the MTU boundary is not strict. Well, let it be.

 But the question is what the minimum "reliable" MTU. There are lots of
 situations when data comes rapidly in small packets (say, monitoring logs).
 Is there a danger to lose such connections on a heavily loaded host?
-- 
 Eugene Berdnikov
