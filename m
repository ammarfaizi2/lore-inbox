Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266366AbUIMIPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266366AbUIMIPn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 04:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266376AbUIMIPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 04:15:43 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38926 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266366AbUIMIPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 04:15:38 -0400
Date: Mon, 13 Sep 2004 09:15:34 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dan Kegel <dank@kegel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix allnoconfig on arm with small tweak to kconfig?
Message-ID: <20040913091534.B27423@flint.arm.linux.org.uk>
Mail-Followup-To: Dan Kegel <dank@kegel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <414551FD.4020701@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <414551FD.4020701@kegel.com>; from dank@kegel.com on Mon, Sep 13, 2004 at 12:53:33AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 12:53:33AM -0700, Dan Kegel wrote:
> 'make allnoconfig' generates a broken .config on arm because
> none of the boolean CPU types get selected.
> ARCH_RPC *does* get selected ok, and I can make CPU_SA110 the
> default if ARCH_RPC, but that doesn't help, since allnoconfig
> sets all booleans that are exposed to the user to false, so
> CPU_SA110 remains false.

allnoconfig is broken.  It doesn't generate a legal configuration on
this platform.

There are cases where you have the choice of selecting several options
and you may select one or more.  Zero options selected is not valid.
Unfortunately, Kconfig does not provide a way to express this.

> I tried it (see patch below), but couldn't get it to work in first
> few tries.  Can someone who understands kconfig have a look?

I don't think hacking around allnoconfig works - it means that we
have to decide on a default for every configuration.  ARCH_RPC is
only one such small case.  There's loads more.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
