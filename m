Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbTELIJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 04:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbTELIJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 04:09:59 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38154 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261994AbTELIJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 04:09:58 -0400
Date: Mon, 12 May 2003 09:20:21 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Bernhard Kaindl <bernhard.kaindl@gmx.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem: strace -ff fails on 2.4.21-rc1
Message-ID: <20030512092020.A10073@flint.arm.linux.org.uk>
Mail-Followup-To: Chuck Ebbert <76306.1226@compuserve.com>,
	Bernhard Kaindl <bernhard.kaindl@gmx.de>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200305112106_MC3-1-3868-D6B1@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200305112106_MC3-1-3868-D6B1@compuserve.com>; from 76306.1226@compuserve.com on Sun, May 11, 2003 at 09:03:12PM -0400
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 11, 2003 at 09:03:12PM -0400, Chuck Ebbert wrote:
> Proc;  minicom
> >>EIP; c01183a1 <schedule+351/3b0>   <===== ignore this bogus address
> Trace; c0122f24 <schedule_timeout+14/a0>
> Trace; c0134a31 <__alloc_pages+41/170>
> Trace; c021195b <tty_wait_until_sent+9b/e0>
> Trace; c0220d79 <rs_close+129/1f0>
> Trace; c020d997 <release_dev+247/500>
> Trace; c011690d <do_page_fault+11d/43b>
> Trace; c020e01a <tty_release+2a/60>
> Trace; c013c52e <fput+4e/100>
> Trace; c013b1d5 <filp_close+95/a0>
> Trace; c013b23b <sys_close+5b/70>
> Trace; c0108b73 <system_call+33/38>
> 
> It's hung up somewhere inside schedule().

Wait 30 seconds and see if it exits by itself.  I bet you have hardware
RTS/CTS handshaking enabled on the serial port, but without anything
connected.

When a port is closed, we wait up to 30 seconds (or a user specified time
period) for any characters in the transmit queue to be sent.  If CTS is
inactive and we're using RTS/CTS handshaking, we can't send any characters,
so we'll wait the full timeout.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

