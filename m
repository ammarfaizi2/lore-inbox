Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312380AbSCYJuj>; Mon, 25 Mar 2002 04:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312381AbSCYJua>; Mon, 25 Mar 2002 04:50:30 -0500
Received: from mario.gams.at ([194.42.96.10]:22634 "EHLO mario.gams.at")
	by vger.kernel.org with ESMTP id <S312380AbSCYJuT>;
	Mon, 25 Mar 2002 04:50:19 -0500
Message-Id: <200203250950.KAA23657@merlin.gams.co.at>
Content-Type: text/plain; charset=US-ASCII
From: Axel Kittenberger <Axel.Kittenberger@maxxio.com>
Organization: Maxxio Technologies
To: David Brown <dave@codewhore.org>
Subject: Re: Patch, forward release() return values to the close() call
Date: Mon, 25 Mar 2002 10:50:17 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200203210747.IAA25949@merlin.gams.co.at> <200203220758.IAA09819@merlin.gams.co.at> <20020322085143.A16251@codewhore.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This is me talking prior to having coffee, but Chapter 3 of the
> Rubini/Corbet book says:
>
>   The flush operation is invoked when a process closes its copy of a file
>   descriptor for a device; it should execute (and wait for) any outstanding
>   operations on the device. This must not be confused with the fsync
> operation requested by user programs. Currently, flush is used only in the
> network file system (NFS) code. If flush is NULL, it is simply not invoked.
>
> I guess it doesn't specifically say it's not called in midstream, but
> it reads as if flush() is called on /only/ close(). I may test this
> today, just for fun.

Oh thats interesting, indeed, so the function name "flush" is just 
contra-intentional. Oxay I know now how I could have written this driver 
without patching the kernel.....

Still the basic issue/idea is remaining. release() is defined as int return 
type, but everywhere it's called it's value is discarded. (except internally 
in "intermezzo" whatever that is)

btw: blkdev_put()  has int return type and seems to return correctly the 
return value from release()s for block devices, so I guess it would be the 
right thing for char devs to do also.

The other way I would also see as okay is to state release() can't return 
anything senseful to anybody, bet then declare it as void return instead. But 
as the state is currently it's suboptimal from both views.

