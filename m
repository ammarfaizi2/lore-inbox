Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129402AbRB1XuI>; Wed, 28 Feb 2001 18:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129389AbRB1Xt6>; Wed, 28 Feb 2001 18:49:58 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:49424 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S129156AbRB1Xtl>;
	Wed, 28 Feb 2001 18:49:41 -0500
Date: Wed, 28 Feb 2001 16:50:26 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Andrew Morton <morton@nortelnetworks.com>
Cc: ebuddington@wesleyan.edu, linux-kernel@vger.kernel.org
Subject: Re: time drift and fb comsole activity
Message-ID: <20010228165026.K28471@ftsoj.fsmlabs.com>
In-Reply-To: <20010228170030.C2122@sparrow.nad.adelphia.net> <3A9D8BC4.45009947@asiapacificm01.nt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A9D8BC4.45009947@asiapacificm01.nt.com>; from morton@nortelnetworks.com on Wed, Feb 28, 2001 at 11:37:40PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have the same trouble on PPC but we make sure to re-sync on each
interrupt.  We can see several lost timer interrupts after a ^L in emacs
running on the fb console.  The resync lets us catch up on those interrupts
(and not lose time) but we still spend a lot of time not servicing
interrupts.

Does x86 not resync on timer interrupts?

} Eric Buddington wrote:
} > 
} > I know this has been reported on the list recently, but I think I can
} > provide better detail. I'm running 2.4.2 with atyfb on a K6-2/266
} > running at 250. This system has no history of clock problems.
} > 
} > adjtimex-1.12 --compare gives me "2nd diff" readings of -0.01 in quiescent
} > conditions.
} > 
} > flipping consoles rapidly cboosts this number to -3 or -4.
} > 
} > catting the full documentation to ntpd (seemed appropriate) gives me
} > "2nd diff" numbers a little over 34. If I read the numbers correctly,
} > 47 seconds of CMOS time passed while the system clock only passed 13
} > seconds.
} > 
} > The processor and the CMOS clock were moving at zero velocity relative
} > to each other, and were both in normal Earth gravity.
} 
} The kernel blocks interrupts during console output.  fbdev
} consoles are slow.  Net result: many lost timer interrupts.
} 
} I'm working on it.  Slowly.  Should have something next week.
