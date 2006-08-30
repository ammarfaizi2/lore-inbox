Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbWH3UEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWH3UEJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 16:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWH3UEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 16:04:08 -0400
Received: from 1wt.eu ([62.212.114.60]:45073 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751462AbWH3UEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 16:04:07 -0400
Date: Wed, 30 Aug 2006 22:03:54 +0200
From: Willy Tarreau <w@1wt.eu>
To: Andi Kleen <ak@suse.de>
Cc: pageexec@freemail.hu, davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] exception processing in early boot
Message-ID: <20060830200354.GA496@1wt.eu>
References: <20060830063932.GB289@1wt.eu> <200608302026.05968.ak@suse.de> <20060830190125.GA21041@1wt.eu> <200608302136.54624.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608302136.54624.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2006 at 09:36:54PM +0200, Andi Kleen wrote:
> 
> > Andi, if you remove the HLT here, some CPUs will spin at full speed. This
> > is nasty during boot because some of them might not have enabled their
> > fans yet for instance
> 
> That would be a severe bug in the platform. Basically always the fans are managed
> by SMM code.

It was just an example. Other examples include virtual machines never
stopping because they will see the guest is working and not halted.

Anyway, the "hlt;jmp $" is already used in boot/setup.S, and the
HLT bug you have pointed is, as explained by Richard, a problem
preventing some CPUs from WAKING up from HLT. It causes a problem
when HLT is used in the idle loop. Users who have this problem must
pass the "no-hlt" command line option, otherwise their CPU will
halt during the idle loop (which is the effect we're looking for),
and those without the bug (those who don't have to pass "no-hlt")
will also have the HLT working.

So, to conclude, with or without the bug, "hlt;jmp $" will halt the
CPU as we expect it to. Therefore, I'd like you to restore it in
the patch.

Thanks,
Willy

