Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132705AbRDMIzE>; Fri, 13 Apr 2001 04:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135445AbRDMIyy>; Fri, 13 Apr 2001 04:54:54 -0400
Received: from elf.ihep.su ([194.190.161.106]:17668 "EHLO elf.ihep.su")
	by vger.kernel.org with ESMTP id <S132705AbRDMIyt>;
	Fri, 13 Apr 2001 04:54:49 -0400
Date: Fri, 13 Apr 2001 12:54:37 +0400
From: "Eugene B. Berdnikov" <berd@elf.ihep.su>
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: Bug report: tcp staled when send-q != 0, timers == 0.
Message-ID: <20010413125437.D25085@elf.ihep.su>
In-Reply-To: <20010411225051.B19364@elf.ihep.su> <200104111909.XAA10870@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <200104111909.XAA10870@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Wed, Apr 11, 2001 at 11:09:35PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello.

On Wed, Apr 11, 2001 at 11:09:35PM +0400, kuznet@ms2.inr.ac.ru wrote:
> BTW if that cursed socket is still alive, try to make the experiment
> with filling window on it. It must stuck, or my theory is completely wrong.

 Filling the socket via writing to pty (controlled by sshd), I found
 the state, which seems very similar to that I have reported:

 # netstat -n -eot | grep 1018
 tcp        0  37684 194.190.166.31:22       194.190.161.106:1018
    ESTABLISHED 0          11964      off (0.00/0/0)

 You see, timers are zero and send-q is not. Zero probes were NOT observed,
 exactly as you predict, but keepalive is correct.

 However, this is _not_ a staled state. When I resume ssh on 194.190.166.31,
 buffer gets empty and connection behaves as normal. I made this experiment
 waiting for keepalive packets from both sides, as well as resuming ssh
 before keepalives. In both cases connection did not become stale.

 So, my conclusion is that your statement about zero probe breakdown due
 to keepalives is right, and, I hope, your patch also makes the right thing.
 However, this is not an answer for the question how such a stale connection
 could arise, and predicted machanism to get it "stuck" does not work.

 [I hope we will continue this discussion later.]
-- 
 Eugene Berdnikov
