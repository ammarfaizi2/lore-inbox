Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbTEVON4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 10:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbTEVON4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 10:13:56 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41233 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261873AbTEVONz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 10:13:55 -0400
Date: Thu, 22 May 2003 15:26:53 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>,
       davej@suse.de
Subject: Re: 2.5.69-mm6: pccard oops while booting: gcc bug?
Message-ID: <20030522152653.D12171@flint.arm.linux.org.uk>
Mail-Followup-To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
	Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>,
	davej@suse.de
References: <1053110098.648.1.camel@teapot.felipe-alfaro.com> <20030516132908.62e54266.akpm@digeo.com> <1053121346.569.1.camel@teapot.felipe-alfaro.com> <3EC56173.1000306@gmx.net> <1053166275.586.9.camel@teapot.felipe-alfaro.com> <20030517031840.486683fc.akpm@digeo.com> <1053169552.613.1.camel@teapot.felipe-alfaro.com> <3EC61B63.9020906@gmx.net> <1053175886.660.4.camel@teapot.felipe-alfaro.com> <1053286732.812.5.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1053286732.812.5.camel@teapot.felipe-alfaro.com>; from felipe_alfaro@linuxmail.org on Sun, May 18, 2003 at 09:38:53PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 18, 2003 at 09:38:53PM +0200, Felipe Alfaro Solana wrote:
> I've read the announcement of gcc 3.3 and saw that gcc 3.2 is not yet
> supported for linux kernel compilations (I've been using Red Hat's
> gcc-3.2.3-4 to compile 2.5.69-mm6). So I thought, what would happen if I
> use gcc 2.96 to compile the kernel instead?
> 
> And voilà... I've compiled 2.5.69-mm6 with Red Hat's 2.96.118 and now,
> I'm unable to reproduce the pccard oops you've been trying to chase
> down. Does this mean the pccard oops was caused by a compiler bug?

Interesting.  We know GCC 3.2.x produces wrong code on ARM without
the patch in PR8896 (http://gcc.gnu.org/cgi-bin/gnatsweb.pl?cmd=view&pr=8896)
being applied.  GCC people aren't happy about applying this patch
because it touches the generic reload code, which apparantly is
sacred voodoo.

I'm wondering if this problem isn't only ARM, but affects others as
well.  (The result is that gcc pokes '4' instead of '3' into the ELF
AUX entries as the value of AT_PHDR.)

Obviously, if x86 is affected and this patch fixes the problem, there's
more motivation for the GCC people to include this fix.  Someone needs
to track down what's going wrong, and then gcc people need to comment.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

