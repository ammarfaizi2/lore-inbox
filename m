Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265635AbUBFSWN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 13:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265644AbUBFSWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 13:22:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59105 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265635AbUBFSWJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 13:22:09 -0500
Date: Fri, 6 Feb 2004 18:22:08 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: John Cherry <cherry@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: IA32 (2.6.2 - 2004-02-05.22.30) - 3 New warnings (gcc 3.2.2)
Message-ID: <20040206182208.GI21151@parcelfarce.linux.theplanet.co.uk>
References: <200402061122.i16BMZ10009537@cherrypit.pdx.osdl.net> <20040206113305.GF21151@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0402060850380.30672@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402060850380.30672@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 06, 2004 at 08:52:00AM -0800, Linus Torvalds wrote:
> 
> 
> On Fri, 6 Feb 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> > 
> > IOW, gcc doesn't realize that we never return from BUG().  AFAICS, it
> > should.  Some changes of __volatile__ semantics?
> 
> Thsrs is no way to tell gcc that an inline asm doesn't return. The only
> way to do it would be to add something like a "for (;;);" (that gcc will
> actually generate real code for) inside the BUG() macro, but I'd hate to 
> do that.

Umm...  How about

static inline void BUG() __attribute__((noreturn));

static inline void BUG(void)
{
	__asm__ ....
}
 
> Better to just initialize the variable to a default value and avoid the 
> warning for now.

Alternatively, we can just turn the damn thing into
	if (dev->mode == IMM_NIBBLE || dev->mode = IMM_PS2)
		ports = 3;
	else
		ports = 8;
and be done with that...
