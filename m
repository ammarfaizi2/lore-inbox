Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263747AbTKRRNx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 12:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbTKRRNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 12:13:52 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:40166 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263726AbTKRRNv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 12:13:51 -0500
Date: Tue, 18 Nov 2003 09:38:32 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linus Torvalds <torvalds@osdl.org>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH][2.6-mm] Fix 4G/4G X11/vm86 oops
Message-ID: <149480000.1069177112@flay>
In-Reply-To: <Pine.LNX.4.53.0311181149310.11537@montezuma.fsmlabs.com>
References: <Pine.LNX.4.44.0311180830050.18739-100000@home.osdl.org> <Pine.LNX.4.53.0311181149310.11537@montezuma.fsmlabs.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Btw, you seem to compile with debugging, which makes the assembly 
>> language pretty much unreadable and accounts for most of the 
>> differences: the line numbers change. If you compile a kernel where the 
>> line numbers don't change (by commenting _out_ the printk rather than 
>> removing the whole line), your diff would be more readable.
> 
> Aha! Thanks for mentioning that, noted.
> 
>> Anyway, there are _zero_ differences.
>> 
>> Just for fun, try this: move the "printk()" to _below_ the "asm"  
>> statement. It will never actually get executed, but if it's an issue of
>> some subtle code or data placement things (cache lines etc), maybe that
>> also hides the oops, since all the same code and data will be generated, 
>> just not run...
> 
> Ok i just tried that and it still fails. Matt Mackall suggested i also try 
> writing a minimal printk which has the same effect.

The other thing I've found printks to hide before is timing bugs / races.
Unfortunately I can't see one here, but maybe someone else can ;-)
Maybe inserting a 1ms delay or something in place of the printk would
have the same effect?

M.

