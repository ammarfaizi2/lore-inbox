Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVCCBBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVCCBBh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 20:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVCCA64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 19:58:56 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:2762 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261212AbVCCAyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 19:54:39 -0500
Date: Thu, 3 Mar 2005 01:54:37 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.11
Message-ID: <20050303005436.GA11516@mail.13thfloor.at>
Mail-Followup-To: Michael Tokarev <mjt@tls.msk.ru>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0503012356480.25732@ppc970.osdl.org> <20050302124728.GD14002@mail.13thfloor.at> <4225C86C.8000502@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4225C86C.8000502@tls.msk.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 05:06:36PM +0300, Michael Tokarev wrote:
> Herbert Poetzl wrote:
> []
> >BUG_ON() and friends are still broken (at least on x86)
> []
> >Freeing unused kernel memory: 244k freed
> >------------[ cut here ]------------
> >kernel BUG at <bad filename>:9377!
> >	      ~~~~~~~~~~~~~~~~~~~
> 
> Have you tried compiling with CONFIG_DEBUG_INFO=y ?
> (Looks like CONFIG_DEBUG_BUGVERBOSE should either
> depend on CONFIG_DEBUG_INFO or turn it on).

egrep 'CONFIG_DEBUG_(INFO|BUGVERBOSE)' .config
# CONFIG_DEBUG_BUGVERBOSE is not set
CONFIG_DEBUG_INFO=y

good point, just it seems to be the other way round ..

with CONFIG_DEBUG_BUGVERBOSE set I get the correct
file and line, but no stack information ...

Freeing unused kernel memory: 104k freed
------------[ cut here ]------------
kernel BUG at init/main.c:692!
invalid operand: 0000 [#1]
PREEMPT 
CPU:    0
EIP:    0060:[<c0100330>]    Not tainted VLI
EFLAGS: 00000246   (2.6.11-rc1) 
eax: 00000000   ebx: c01002b0   ecx: 00000000   edx: 00000000
esi: 00000000   edi: 00000000   ebp: 00000000   esp: c10bdff0
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c10bc000 task=c10b3aa0)
Stack: c0100635 00000000 00000000 00000000 
Call Trace:
 [<c0100635>]
Code: 29 c0 01 00 00 00 6a 00 6a 02 68 97 0a 24 c0 e8 47 07 06 00 83 c4 0c 85 c0 78 60 6a 00 e8 a9 80 07 00 6a 00 e8 a2 80 07 00 58 5a <0f> 0b b4 02 13 0a 24 c0 a1 24 21 29 c0 85 c0 75 32 68 a4 0a 24 

maybe there is another option which sneaked in,
will investigate ...

thanks,
Herbert

PS: was it ever considered to hard code the explicit BUG_*
files and lines via a macro instead of that (probably very
fancy and efficient but nevertheless) strange address stuff?

I mean, are bug reports with missing/wrong file/line info
really what the kernel developers want to see in the future?

> /mjt
