Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272559AbTHFXF4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 19:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272561AbTHFXF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 19:05:56 -0400
Received: from waste.org ([209.173.204.2]:30639 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S272559AbTHFXFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 19:05:55 -0400
Date: Wed, 6 Aug 2003 18:05:53 -0500
From: Matt Mackall <mpm@selenic.com>
To: kwijibo@zianet.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Machine check expection panic
Message-ID: <20030806230553.GG31810@waste.org>
References: <3F3182B5.3040301@zianet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F3182B5.3040301@zianet.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 04:35:33PM -0600, kwijibo@zianet.com wrote:
> I decided to try out the new 2.6.0-test2 kernel today but
> ran into a problem with booting it.  I narrowed it down to
> the machine check expection code.  I get this panic from
> the kernel on boot when I have it enabled
> 
> CPU0: Machine Check Exception: 0000000000000004
> Bank0: f606200000000833 at 0000000000004040
> Kernel Panic: CPU context corrupt.

$ parsemce -b 0 -e 0000000000000004 -s f606200000000833 -a 0000000000004040
Status: (4) Machine Check in progress.
Restart IP invalid.
parsebank(0): f606200000000833 @ 4040
        External tag parity error
        Uncorrectable ECC error
        CPU state corrupt. Restart not possible
        Address in addr register valid
        Error enabled in control register
        Error not corrected.
        Error overflow
        Bus and interconnect error
        Participation: Local processor originated request
        Timeout: Request did not timeout
        Request: Generic error
        Transaction type : Instruction
        Memory/IO : Other

Looks like corruption with your L2 cache. Odds are its heat-related.

> I disabled this option in the kernel and recompiled and everything
> went smooth.  I figured maybe there could actually possibly be
> something wrong with the CPU but I can boot with RedHat's
> 2.4.20-19 kernel fine which I *think* includes machine check exception
> code.  I have no beef with leaving the exception code out but I figured
> someone on this list may want to know. 
> 
> Little bit of hardware info:
> Tyan 2466 motherboard
> 2 Athon MP 1200 processors

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
