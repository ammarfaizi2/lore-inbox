Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbTKRXtA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 18:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263852AbTKRXtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 18:49:00 -0500
Received: from mra02.ex.eclipse.net.uk ([212.104.129.89]:38564 "EHLO
	mra02.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S263850AbTKRXsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 18:48:54 -0500
Message-ID: <3FBAAFDF.5000803@jon-foster.co.uk>
Date: Tue, 18 Nov 2003 23:48:47 +0000
From: Jon Foster <jon@jon-foster.co.uk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-gb, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: zwane@arm.linux.org.uk
Subject: Re:Re: [PATCH][2.6-mm] Fix 4G/4G X11/vm86 oops
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> The other thing I've found printks to hide before is timing bugs / races.
> Unfortunately I can't see one here, but maybe someone else can ;-)
> Maybe inserting a 1ms delay or something in place of the printk would
> have the same effect?

One of my colleagues had an interesting bug caused by an
uninitialized variable - a printk() in the right place happened
to set the variable (which gcc had put in a register) to the
correct value for his code to work.

I've tried looking for uses of uninitialized registers in entry.S,
but the assembly there isn't easy to follow.

What happens if you replace the printk with assembly code
that clobbers eax, ecx, edx and (most of) eflags?  (Assuming
I've remembered the calling convention correctly, those are
the registers that printk will be overwriting).

Kind regards,

Jon

