Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261963AbVC1S0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbVC1S0h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 13:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVC1S0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 13:26:37 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:57253 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261963AbVC1SWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 13:22:10 -0500
Date: Mon, 28 Mar 2005 10:22:07 -0800
From: "H. J. Lu" <hjl@lucon.org>
To: Andi Kleen <ak@muc.de>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: i386/x86_64 segment register issuses (Re: PATCH: Fix x86 segment register access)
Message-ID: <20050328182207.GA25316@lucon.org>
References: <20050326020506.GA8068@lucon.org> <20050327222406.GA6435@lucon.org> <m14qev3h8l.fsf@muc.de> <20050328174600.GA24675@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050328174600.GA24675@lucon.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 09:46:00AM -0800, H. J. Lu wrote:
> On Mon, Mar 28, 2005 at 05:47:06PM +0200, Andi Kleen wrote:
> > "H. J. Lu" <hjl@lucon.org> writes:
> > > The new assembler will disallow them since those instructions with
> > > memory operand will only use the first 16bits. If the memory operand
> > > is 16bit, you won't see any problems. But if the memory destinatin
> > > is 32bit, the upper 16bits may have random values. The new assembler
> > 
> > Does it really have random values on existing x86 hardware?
> 
> The x86 hardwares will only change the first 16bits. The rest bits
> are unchanged. A simple test program can verify that.
> 
> > 
> > If it is a only a "theoretical" problem that does not happen
> > in practice I would advise to not do the change.
> > 
> 
> It depends on what the initial value in the upper bits is. The
> assembler in CVS generates the same binary code as
> 
> 	movw %ds,(%eax)
> 
> for
> 
> 	movl %ds,(%eax)
> 
> But the previous assemblers will generate
> 
> 	66 8c 18   movw   %ds,(%eax)
> 
> for
> 
> 	movw %ds,(%eax)
> 
> This bug has been fixed for a while. I guess that may be why Linux
> kernel uses
> 
> 	movl %ds,(%eax)

It turns out that both old and new assemblers will generate

   0:   8c 18 movw   %ds,(%eax)

for
 	mov %ds,(%eax)

So kernel can use "mov" instead of "movl" and the binary output will
be the same.


H.J.
