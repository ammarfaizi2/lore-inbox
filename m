Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314887AbSDVWvf>; Mon, 22 Apr 2002 18:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314889AbSDVWvc>; Mon, 22 Apr 2002 18:51:32 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:62642 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S314887AbSDVWvW>; Mon, 22 Apr 2002 18:51:22 -0400
To: "Saxena, Sunil" <sunil.saxena@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Initial process CPU state was Re: SSE related security hole
In-Reply-To: <9287DC1579B0D411AA2F009027F44C3F171C1A9E@FMSMSX41>
From: Andi Kleen <ak@muc.de>
Date: 23 Apr 2002 00:51:09 +0200
Message-ID: <m3ofgbcppe.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.070095 (Pterodactyl Gnus v0.95) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Saxena, Sunil" <sunil.saxena@intel.com> writes:

Hallo Sunil,

> We recognized that there is a discrepancy in the individual instruction
> descriptions in Vol 2 where it is indicated that the instruction would
> generate a UD#. We will be rectifying this discrepancy in the next revision
> of Vol 2 as well as via the monthly Specification Updates.

Could you quickly describe what the Intel recommended way is to clear
the whole CPU at the beginning of a process? Is there a better way
than "save state with fxsave at bootup and restore into each
new process"? After all it would be a bit unfortunate to have
instructions which are transparently tolerant to new CPU state (fxsave/fxrstor 
for context switching), but no matching way to clear the same state for 
security reasons.  Using the bootup FXSAVE image would make linux
depend on the BIOS for this (so in the worst case when the bios 
doesn't clear e.g. the XMM registers or some future registers each 
process could see the state of some previous boot after a warm boot) 

Another way would be to do a fxsave after clearing of known state (x87,MMX,
SSE) at OS bootup and then afterwards set all the so far reserved parts of the 
FXSAVE image to zero. Then restore this image later into each new process.
This would avoid any BIOS/direct warmboot dependencies.  It would work 
assuming that all future IA32 state can be safely initialized with zeroes
via FXRSTOR. Is this a safe assumption?

Thanks, 
-Andi

