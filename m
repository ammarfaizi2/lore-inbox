Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292702AbSCOPDC>; Fri, 15 Mar 2002 10:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292707AbSCOPCw>; Fri, 15 Mar 2002 10:02:52 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:51981 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S292702AbSCOPCt>; Fri, 15 Mar 2002 10:02:49 -0500
Date: Fri, 15 Mar 2002 15:02:41 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Nicholas Berry <nikberry@med.umich.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4 and 2.5: remove Alt-Sysrq-L
Message-ID: <20020315150241.H24984@flint.arm.linux.org.uk>
In-Reply-To: <sc91c4ce.020@mail-01.med.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <sc91c4ce.020@mail-01.med.umich.edu>; from nikberry@med.umich.edu on Fri, Mar 15, 2002 at 09:54:05AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 09:54:05AM -0500, Nicholas Berry wrote:
> > I distinctly recall it working perfectly OK in around 2.1.50. I had boxen 
> > where /sbin/init was a shell script which would bring up the interfaces,
> > enable routing, and exit.
> 
> That's a different thing, I think. 
> 
> That is, 'init exiting' versus 'all the code to prevent init being killed
> is bypassed and init is killed'

Very true.

With all recent kernels, init exiting causes the last of these to trigger:

NORET_TYPE void do_exit(long code)
{
        struct task_struct *tsk = current;

        if (in_interrupt())
                panic("Aiee, killing interrupt handler!");
        if (!tsk->pid)
                panic("Attempted to kill the idle task!");
        if (tsk->pid == 1)
                panic("Attempted to kill init!");

It is this very test that Alt-SysRQ-L is attempting to bypass which causes
the problem.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

