Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbTEHQdY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 12:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbTEHQdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 12:33:24 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:35992 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261808AbTEHQdX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 12:33:23 -0400
X-AuthUser: davidel@xmailserver.org
Date: Thu, 8 May 2003 09:47:34 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
In-Reply-To: <Pine.LNX.4.53.0305080729410.16638@chaos>
Message-ID: <Pine.LNX.4.50.0305080932090.2094-100000@blue1.dev.mcafeelabs.com>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de>
 <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de>
 <Pine.LNX.4.53.0305071008080.11871@chaos> <p05210601badeeb31916c@[207.213.214.37]>
 <Pine.LNX.4.53.0305071323100.13049@chaos> <52k7d2pqwm.fsf@topspin.com>
 <Pine.LNX.4.53.0305071424290.13499@chaos> <52bryeppb3.fsf@topspin.com>
 <Pine.LNX.4.53.0305071523010.13724@chaos> <52n0hyo85x.fsf@topspin.com>
 <Pine.LNX.4.53.0305071547060.13869@chaos> <3EB96FB2.2020401@techsource.com>
 <Pine.LNX.4.53.0305080729410.16638@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 May 2003, Richard B. Johnson wrote:

> In protected mode, the kernel stack. And, regardless of implimentation
> details, there can only be one. It's the one whos stack-selector
> is being used by the CPU. So, in the case of Linux, with multiple
> kernel stacks (!?????), one for each process, whatever process is
> running in kernel mode (current) has it's SS active. It's the
> one that gets hit with the interrupt.

Why the multiple !????? Richard ? The fact that Intel is showing something
different on their manuals does not automatically mean that it is the
right way to do it. The boundary line between tasks is inside switch_to()
that is deep inside the kernel path. The stack space that goes from the
system call entry to the switch_to() call *must* be obviously preserved.
Can it be done in a different way ? Sure it can. Try to think about it and
look at how more complex things become with such scenario. Intel also
suggests to use one TSS per task, while we're recycling the same TSS for
all processes for example ( per CPU ).




- Davide

