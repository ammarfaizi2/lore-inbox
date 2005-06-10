Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262590AbVFJQB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbVFJQB5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 12:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbVFJQB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 12:01:57 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:22470 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S262590AbVFJQBz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 12:01:55 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: PNP parallel&serial ports: module reload fails (2.6.11)?
Date: Fri, 10 Jun 2005 10:01:40 -0600
User-Agent: KMail/1.8
Cc: Michael Tokarev <mjt@tls.msk.ru>, Adam Belay <ambx1@neo.rr.com>,
       matthieu castet <castet.matthieu@free.fr>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050602222400.GA8083@mut38-1-82-67-62-65.fbx.proxad.net> <42A8AFA5.3090703@tls.msk.ru> <20050609221657.C14513@flint.arm.linux.org.uk>
In-Reply-To: <20050609221657.C14513@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506101001.40980.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 June 2005 3:16 pm, Russell King wrote:
> The reason that 8250 first detects your ports is that they're found
> via the legacy method which is independent of PnP.  As you correctly
> sumise, when you unload 8250_pnp, it disables the device so when you
> re-load 8250, it's unable to detect your ports using the legacy method.
> 
> But the legacy method needs to continue to exist for systems which
> don't have PnP enabled.

But shouldn't we someday move the legacy probing from 8250
into an 8250_platform and only do it if we don't have 8250_pnp?

I think David Woodhouse suggested something like this a while
back, but I can't find a great reference for it.  Here's a
thread (unfortunately split into sections by the archive)
that mentions it:

http://www.ussg.iu.edu/hypermail/linux/kernel/0409.3/1545.html
http://www.ussg.iu.edu/hypermail/linux/kernel/0410.0/0084.html
http://www.ussg.iu.edu/hypermail/linux/kernel/0411.0/0127.html

