Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132313AbRDPVaJ>; Mon, 16 Apr 2001 17:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132301AbRDPV37>; Mon, 16 Apr 2001 17:29:59 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:22543 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S132224AbRDPV3q>; Mon, 16 Apr 2001 17:29:46 -0400
Date: Tue, 17 Apr 2001 09:29:42 +1200
From: Chris Wedgwood <cw@f00f.org>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: george anzinger <george@mvista.com>, Mark Salisbury <mbs@mc.com>,
        Jamie Lokier <lk@tantalophile.demon.co.uk>,
        Ben Greear <greearb@candelatech.com>,
        Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        linux-kernel@vger.kernel.org,
        high-res-timers-discourse@lists.sourceforge.net
Subject: Re: No 100 HZ timer!
Message-ID: <20010417092942.B1254@metastasis.f00f.org>
In-Reply-To: <3ADB45C0.E3F32257@mvista.com> <200104162045.f3GKjd4522374@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200104162045.f3GKjd4522374@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Mon, Apr 16, 2001 at 04:45:39PM -0400
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2001 at 04:45:39PM -0400, Albert D. Cahalan wrote:

    > CLOCK_10MS a wall clock supporting timers with 10 ms resolution (same as
    > linux today). 
    
    Except on the Alpha, and on some ARM systems, etc.
    The HZ constant varies from 10 to 1200.

Or some people use higher values on x86:

cw@charon(cw)$ uptime
 14:13:02 up 11 days, 21:44,  2 users,  load average: 0.00, 0.00, 0.00
cw@charon(cw)$ cat /proc/interrupts
           CPU0
  0: 2106736381          XT-PIC  timer
  1:     187633          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  7:   94128650          XT-PIC  eth0, usb-uhci, usb-uhci
 10:   18265929          XT-PIC  ide2
 12:    3107415          XT-PIC  PS/2 Mouse
 14:     753375          XT-PIC  via82cxxx
 15:          2          XT-PIC  ide1
NMI:          0
ERR:          0



thats 2048 ticks/sec -- I had to hack the kernel in a couple of
places to make things happy with that, but so far it seems to work.

I also had to hack libproc.so.* -- what a terribly obscure way that
it uses to determine what HZ is defined as!

I know this has ben beaten to death before but can someone tell me:

   - why we cannot export HZ somewhere

   - why is it called HZ, it seems misleading why not something like
     TICKS_PER_SECOND or similar

   - it seems there are a couple of places that assume HZ==100 still,
     or am I just imagining this (ide code, I forget where now)




  --cw
