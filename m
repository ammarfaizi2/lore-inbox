Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261586AbSJNLqR>; Mon, 14 Oct 2002 07:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261593AbSJNLqR>; Mon, 14 Oct 2002 07:46:17 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1552 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261586AbSJNLqQ>; Mon, 14 Oct 2002 07:46:16 -0400
Date: Mon, 14 Oct 2002 12:52:06 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Bernd Petrovitsch <bernd@gams.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: open("/dev/ttyS1", O_LARGEFILE) blocks
Message-ID: <20021014125206.A2902@flint.arm.linux.org.uk>
References: <2379.1034595547@frodo.gams.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <2379.1034595547@frodo.gams.co.at>; from bernd@gams.at on Mon, Oct 14, 2002 at 01:39:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 01:39:07PM +0200, Bernd Petrovitsch wrote:
> Hi all!
> 
> Is is normal/correct/intended that an open() of /dev/ttyS1 blocks?
> ----  snip  ----
> {81}strace ./test-open /dev/ttyS0
> [...]
> open("/dev/ttyS0", O_RDONLY|O_NONBLOCK) = 3
> close(3)                                = 0
> open("/dev/ttyS0", O_RDONLY|O_NONBLOCK|O_LARGEFILE) = 3
> close(3)                                = 0
> open("/dev/ttyS0", O_RDONLY|O_LARGEFILE) = 3
> close(3)                                = 0
> _exit(0)                                = ?
> {82}strace ./test-open /dev/ttyS1
> [...]
> open("/dev/ttyS1", O_RDONLY|O_NONBLOCK) = 3
> close(3)                                = 0
> open("/dev/ttyS1", O_RDONLY|O_NONBLOCK|O_LARGEFILE) = 3
> close(3)                                = 0
> open("/dev/ttyS1", O_RDONLY|O_LARGEFILE <unfinished ...>
> {83}lsof /dev/ttyS0
> {84}lsof /dev/ttyS1
> {85}uname -a
> Linux xxx 2.4.20-pre10aa1 #6 Fri Oct 11 13:41:20 CEST 2002 i686 unknown
> ----  snip  ----
> 
> The second one was terminated with a Ctrl-C.
> Nothing was connected to none of the ports.
> Is there a reason that an open() on /dev/ttyS0 works and blocks
> on /dev/ttyS1?

stty -aF /dev/ttyS0
stty -aF /dev/ttyS1

I bet ttyS0 has clocal set, whereas ttyS1 doesn't.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

