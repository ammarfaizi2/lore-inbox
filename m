Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276344AbRJGNEC>; Sun, 7 Oct 2001 09:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276347AbRJGNDn>; Sun, 7 Oct 2001 09:03:43 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:38553 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S276344AbRJGNDa>; Sun, 7 Oct 2001 09:03:30 -0400
Date: Sun, 7 Oct 2001 15:03:58 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Mika Liljeberg <Mika.Liljeberg@welho.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Context switch times
Message-ID: <20011007150358.G30515@nightmaster.csn.tu-chemnitz.de>
Mail-Followup-To: Mika Liljeberg <Mika.Liljeberg@welho.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Benjamin LaHaise <bcrl@redhat.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E15pWfR-0006g5-00@the-village.bc.nu> <3BC02709.A8E6F999@welho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3BC02709.A8E6F999@welho.com>; from Mika.Liljeberg@welho.com on Sun, Oct 07, 2001 at 12:57:29PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2001 at 12:57:29PM +0300, Mika Liljeberg wrote:
> For problems 1 and 2 I propose the following solution: Insert the the
> load balancing routine itself as a (fake) task on each CPU and run it
> when the CPU gets around to it. The load balancer should behave almost
> like a CPU-bound task, scheduled on the lowest priority level with other
> runnable tasks. 

The idle-task might be (ab-)used for this, because it has perfect
data for this.

T_SystemElapsed - T_IdleTaskRun = T_CPULoaded

Balancing could be done in schedule() itself, after checking this
value for each CPU.

> The last bit is important: the load balancer should not
> be allowed to starve but should be invoked approximately once every
> "full rotation" of the scheduler.
 
If a artificial CPU-hog is used for this task, the idle task will
never be run and power savings in the CPU are impossible.

Other parts sound interesting.

Regards

Ingo Oeser
-- 
.... Our continuing mission: To seek out knowledge of C, to explore
strange UNIX commands, and to boldly code where no one has man page 4.
                        --- Mike A. Harris <mharris@meteng.on.ca>
