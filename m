Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265795AbUATVPU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 16:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265796AbUATVPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 16:15:20 -0500
Received: from rrcs-central-24-123-144-118.biz.rr.com ([24.123.144.118]:24140
	"EHLO zso-proxy.zeusinc.com") by vger.kernel.org with ESMTP
	id S265795AbUATVPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 16:15:15 -0500
Subject: Re: 2.6.1-mm5
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1074633308.14253.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 20 Jan 2004 16:15:08 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having a couple of minor issues with ACPI in the -mm series.

The battery status on my Dell Latitude D800 won't work at all without
the patch from http://bugzilla.kernel.org/show_bug.cgi?id=1766 however,
with vanilla 2.6.1 everything seems to work fine.  Without this patch I
get tons of _ut_allocate: tried to allocate zero bytes (or something
close to this) and no battery status at all.

With the patch mentioned above everything seemed to work OK, however,
recently I enabled both 4GB highmem support (this seems to get me an
extra 128MB on my 1GB system) and preempt support and now, while it
initially works fine, the system eventually quits reporting battery
status and I get a lot of messages like the following every time I poll
for battery status (over and over if a battery status applet is loaded):

    ACPI-0279: *** Error: Looking up [BST0] in namespace,
AE_ALREADY_EXISTS
    ACPI-1120: *** Error: Method execution failed [\_SB_.BAT0._BST]
(Node f7feea60), AE_ALREADY_EXISTS

It seems that I can trigger this much quicker if a generate a lot of
traffic on my aironet wireless adapter, it will only take minutes to
occur.  I'm going to try to back out preempt and 4GB support one at a
time and see what happens.

I haven't been able to reproduce any of these issues on 2.6.1 vanilla.

Later,
Tom


Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-mm5/


