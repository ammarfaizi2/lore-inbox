Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbTIQTmd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 15:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262952AbTIQTmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 15:42:33 -0400
Received: from animal.blarg.net ([206.124.128.1]:63712 "EHLO animal.blarg.net")
	by vger.kernel.org with ESMTP id S262776AbTIQTmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 15:42:22 -0400
Date: Wed, 17 Sep 2003 12:42:21 -0700
From: Ben Johnson <ben@blarg.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linear vs. logical addresses?  how does cpu interpret kernel addrs?
Message-ID: <20030917124221.A3970@blarg.net>
References: <20030916154747.A22526@blarg.net> <Pine.LNX.4.53.0309170734240.881@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.53.0309170734240.881@chaos>; from root@chaos.analogic.com on Wed, Sep 17, 2003 at 07:39:53AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 17, 2003 at 07:39:53AM -0400, Richard B. Johnson wrote:
> 
> All stack offsets are accessed relative to SS. No exceptions.
> However a compiler may calculate those offsets based upon
> something else.
> This is why DS must equal SS if 'C' is going to access both
> stack data variables and data segment variables. This is how
> the 'C' code converter is set up. It is not a CPU limitation.
> If you change the SS in the kernel, strange and wonderful
> things will occur.

Let me see if I understand you.  If SS and DS point to segments that
have different base addresses then code like this...  (I'm an assembly
newbie.  hope I get this right.)

# get whatever is at %ss:%esp + 4 and put it in eax
movl 4(%esp), %eax
movl %esp, %edx
# get whatever is at %ds:%edx + 4 and put it in eax
movl 4(%edx), %eax

# eax probably changed twice because while esp and edx have same value,
# if SS->baseaddr != DS->baseaddr, then (%esp) and (%edx) don't point to
# the same memory location.

I'm pretty sure I've seen plenty of code like this, which must mean,
like you just told me, that the C compiler assumes the base address of
DS and SS are the same.  So, if I want to change segment base addresses
then I'm up shit creek.

Thanks very much for the info!

- Ben

