Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbVC1R76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbVC1R76 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 12:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbVC1R4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 12:56:31 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:12929 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261972AbVC1RqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 12:46:01 -0500
Date: Mon, 28 Mar 2005 09:46:00 -0800
From: "H. J. Lu" <hjl@lucon.org>
To: Andi Kleen <ak@muc.de>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: i386/x86_64 segment register issuses (Re: PATCH: Fix x86 segment register access)
Message-ID: <20050328174600.GA24675@lucon.org>
References: <20050326020506.GA8068@lucon.org> <20050327222406.GA6435@lucon.org> <m14qev3h8l.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m14qev3h8l.fsf@muc.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 05:47:06PM +0200, Andi Kleen wrote:
> "H. J. Lu" <hjl@lucon.org> writes:
> > The new assembler will disallow them since those instructions with
> > memory operand will only use the first 16bits. If the memory operand
> > is 16bit, you won't see any problems. But if the memory destinatin
> > is 32bit, the upper 16bits may have random values. The new assembler
> 
> Does it really have random values on existing x86 hardware?

The x86 hardwares will only change the first 16bits. The rest bits
are unchanged. A simple test program can verify that.

> 
> If it is a only a "theoretical" problem that does not happen
> in practice I would advise to not do the change.
> 

It depends on what the initial value in the upper bits is. The
assembler in CVS generates the same binary code as

	movw %ds,(%eax)

for

	movl %ds,(%eax)

But the previous assemblers will generate

	66 8c 18   movw   %ds,(%eax)

for

	movw %ds,(%eax)

This bug has been fixed for a while. I guess that may be why Linux
kernel uses

	movl %ds,(%eax)


H.J.
