Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264907AbSKUWBL>; Thu, 21 Nov 2002 17:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264919AbSKUWBL>; Thu, 21 Nov 2002 17:01:11 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:15491 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S264907AbSKUWBJ>; Thu, 21 Nov 2002 17:01:09 -0500
Date: Thu, 21 Nov 2002 14:08:08 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Brian Gerst <bgerst@didntduck.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Wim Coekaerts <Wim.Coekaerts@oracle.com>
Subject: Re: [RFC] hangcheck-timer module
Message-ID: <20021121220807.GN770@nic1-pc.us.oracle.com>
References: <20021121201711.GG770@nic1-pc.us.oracle.com> <3DDD4288.70605@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDD4288.70605@didntduck.org>
User-Agent: Mutt/1.4i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 03:31:04PM -0500, Brian Gerst wrote:
> Joel Becker wrote:
> >	Attached is a module, hangcheck-timer.  It is used to detect
> >when the system goes out to lunch for a period of time, such as when a
> >driver like qla2x00 udelays a bunch.
> 
> There is already an NMI watchdog that is better than what you propose, 
> because it will also catch cases where something gets stuck with 
> interrupts disabled.

	The issue at hand is not permanent hangs.  The issue is hangs
that return.  Consider a clustering enviornment where the other nodes
have given up on the delayed node and clean up after it.  When the hang
finally ends, the node still thinks it is "alive" and happily scribbles
to places it shouldn't.
	udelay will not ever trigger the NMI watchdog, as it is running
on the processor, so the cpu timer will run happily.  But as far as
everything higher up (kernel + userspace), the delay will be unnoticed
and bad things can happen.

Joel

-- 

"I'm so tired of being tired,
 Sure as night will follow day.
 Most things I worry about
 Never happen anyway."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
