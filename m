Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264734AbUGBRcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264734AbUGBRcB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 13:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264775AbUGBRb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 13:31:59 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:36562 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264734AbUGBRbr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 13:31:47 -0400
Subject: Re: [PATCH] [2.6] PPC64: log firmware errors during boot.
From: Hollis Blanchard <hollisb@us.ibm.com>
To: nfont@austin.ibm.com
Cc: Paul Mackerras <paulus@samba.org>, linas@austin.ibm.com,
       linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
In-Reply-To: <40E58AE9.6050009@austin.ibm.com>
References: <20040629191046.Q21634@forte.austin.ibm.com>
	 <16610.39955.554139.858593@cargo.ozlabs.ibm.com>
	 <20040701160614.I21634@forte.austin.ibm.com>
	 <16613.15510.325099.273419@cargo.ozlabs.ibm.com>
	 <3EC84E0C-CC32-11D8-BDBD-000A95A0560C@us.ibm.com>
	 <40E58AE9.6050009@austin.ibm.com>
Content-Type: text/plain
Message-Id: <1088789345.26946.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 02 Jul 2004 12:29:08 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-02 at 11:18, Nathan Fontenot wrote:
> > I asked about this before, and was told that there is no way to
> > determine the severity of an event without doing full parsing of the
> > binary data. I'd be thrilled to be wrong...
> 
> Gettting the severity of an RTAS event is possible, and not too 
> difficult.  Check out asm-ppc64/rtas.h for a definition of the
> RTAS event header (struct rtas_error_log).  All RTAS events have the 
> same initial header containing the severity of the event.

Great! Of course that won't help much if we get repeating "important"
events that aren't even interesting much less important, but it's worth
trying to printk only the important ones and leave the rest to netlink.

Note that currently we printk them all as KERN_DEBUG messages. Although
they aren't spewed to console, they still take up (lots of) space in the
printk buffer, and dmesg is still afflicted too...

-- 
Hollis Blanchard
IBM Linux Technology Center

