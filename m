Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267368AbUH3Hst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267368AbUH3Hst (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 03:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267285AbUH3Hst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 03:48:49 -0400
Received: from codepoet.org ([166.70.99.138]:40618 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S267195AbUH3Hsh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 03:48:37 -0400
Date: Mon, 30 Aug 2004 01:48:35 -0600
From: Erik Andersen <andersen@codepoet.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: mmazur@kernel.pl, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.8.1
Message-ID: <20040830074835.GA12963@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	"David S. Miller" <davem@davemloft.net>, mmazur@kernel.pl,
	linux-kernel@vger.kernel.org
References: <200408292232.14446.mmazur@kernel.pl> <20040830062856.GA10475@codepoet.org> <20040830002422.4b634c6c.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040830002422.4b634c6c.davem@davemloft.net>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Aug 30, 2004 at 12:24:22AM -0700, David S. Miller wrote:
> On Mon, 30 Aug 2004 00:28:56 -0600
> Erik Andersen <andersen@codepoet.org> wrote:
> 
> > I really do not like this change.  Since PAGE_SIZE has always
> > been a constant, the change you have made is likely to break a
> > fair amount of code, basically any code doing stuff like:
> 
> It has never been a constant, and any portable piece of
> software needs to evaluate it not at compile time.
> 
> When I first did the sparc64 port, the biggest source of
> portability problems was of the "uses PAGE_SIZE in some way"
> nature.
> 
> This is a positive change, we should break the build of these
> apps and thus get them fixed.

There is no question that using PAGE_SIZE should be considered
harmful.  But this particular change to the linux-libc-headers
makes it easy for the common case (bog standard x86) folk to keep
using a fixed PAGE_SIZE value, and keep writing crap code which
is now _guaranteed_ to blow chunks on mips, x86_64, etc.

I think outright removal of PAGE_SIZE from user space may be a
much better choice, with some sortof #error perhaps...  Wouldn't
it be better for the whole world if people would get errors like

    foo.c:10:2: #error "Don't use PAGE_SIZE, use sysconf(_SC_PAGESIZE)"

making people actually fix their code?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
