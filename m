Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132756AbRDURF7>; Sat, 21 Apr 2001 13:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132758AbRDURFq>; Sat, 21 Apr 2001 13:05:46 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:24080 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S132756AbRDURFm>;
	Sat, 21 Apr 2001 13:05:42 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200104211702.VAA14712@ms2.inr.ac.ru>
Subject: Re: Bug report: tcp staled when send-q != 0, timers == 0.
To: berd@elf.ihep.su (Eugene B. Berdnikov)
Date: Sat, 21 Apr 2001 21:02:32 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010421194503.H23490@elf.ihep.su> from "Eugene B. Berdnikov" at Apr 21, 1 07:45:03 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>  Im my case P-MTU discovery

Sorry, I lied. Not pmtu discovery but exaclty opposite effect
is important here: collapsing of small frames to larger ones.
Each such merge results in loss of 1 "sack" in 2.2.

>  I only wrote that it was active when got stuck. It may be idle before -
>  I do not remember, but have a habit to keep connections for weeks. :)

Good. 8)

>  As my experiments show, any connection, entering keepalive once,
>  have lose its ability to send zero probes - forever.

Exactly.


>  OK. Let us return to the "mss/mtu bug". The most mystifying thing for
>  me is the dependance of the MTU threshold on the kernel version, etc.

Well, you can reinvestigate this to get more reliable results...

Actually, this problem is so difficult that the study would be purely
academical; there is no hope to fix it in 2.2. It is partially
repaired during 2.3 and completely resolved only in 2.4.4.


>  But the question is what the minimum "reliable" MTU. There are lots of
>  situations when data comes rapidly in small packets (say, monitoring logs).
>  Is there a danger to lose such connections on a heavily loaded host?

There is no real danger. Bad things can happen only when receiver does not
read data for very long time, in this case connection times out not
receiving any acks.

What's about minimum/maximum mtu... it does not exist. F.e. if sender floods
1 byte frames in TCP_NODELAY mode and receiver does not read them, 2.2 will
fail not depending on mtu. See? Even 40 bytes of IP+TCP headers (not counting
for additional overhead) guarantee that memory will exhaust by order earlier
than receiver can close window.

Alexey
