Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272121AbTHSEOh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 00:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275344AbTHSEOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 00:14:37 -0400
Received: from waste.org ([209.173.204.2]:6575 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S272121AbTHSEOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 00:14:36 -0400
Date: Mon, 18 Aug 2003 23:14:04 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, davej@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: Debug: sleeping function called from invalid context
Message-ID: <20030819041404.GI16387@waste.org>
References: <20030815101856.3eb1e15a.rddunlap@osdl.org> <20030815173246.GB9681@redhat.com> <20030815123053.2f81ec0a.rddunlap@osdl.org> <20030816070652.GG325@waste.org> <20030818140729.2e3b02f2.rddunlap@osdl.org> <20030819001316.GF22433@redhat.com> <20030818171545.5aa630a0.akpm@osdl.org> <32789.4.4.25.4.1061263463.squirrel@www.osdl.org> <20030818203513.393c4a48.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030818203513.393c4a48.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 08:35:13PM -0700, Andrew Morton wrote:
> "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> >
> > Debug: sleeping function called with interrupts disabled at
> >  include/asm/uaccess.h:473
> 
> OK, now my vague understanding of what's going on is that the app has
> chosen to disable local interupts (via iopl()) and has taken a vm86 trap. 

Are you suggesting that whatever's calling sys_vm86 has disabled
interrupts beforehand? I don't see why that's necessary at all. The
vm86 fault handler is called via do_general_protection in any case and
as such is in_interrupt() by definition. And a vm86 general protection
fault can be caused by any of cli, sti, pushf, popf, intx, or iret. In
fact, typical usage of vm86 mode is to setup a call to a 16-bit
software interrupt handler and return via fault on the iret.

I'm increasingly convinced it's actually broken.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
