Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVAFVQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVAFVQR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 16:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262997AbVAFVOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 16:14:49 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:129 "EHLO vana")
	by vger.kernel.org with ESMTP id S262969AbVAFVJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 16:09:26 -0500
Date: Thu, 6 Jan 2005 22:09:21 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Andi Kleen <ak@suse.de>
Cc: "David S. Miller" <davem@davemloft.net>, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net, mst@mellanox.co.il,
       akpm@osdl.org, linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [PATCH] macros to detect existance of unlocked_ioctl and ioctl_compat
Message-ID: <20050106210921.GK5772@vana.vc.cvut.cz>
References: <20050106140636.GE25629@mellanox.co.il> <20050106145356.GA18725@infradead.org> <20050106163559.GG5772@vana.vc.cvut.cz> <20050106165715.GH1830@wotan.suse.de> <20050106172613.GI5772@vana.vc.cvut.cz> <20050106175342.GA28889@wotan.suse.de> <20050106193520.GA5481@kroah.com> <20050106195144.GE28889@wotan.suse.de> <20050106115959.45d793e1.davem@davemloft.net> <20050106204431.GH28889@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106204431.GH28889@wotan.suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 09:44:31PM +0100, Andi Kleen wrote:
> On Thu, Jan 06, 2005 at 11:59:59AM -0800, David S. Miller wrote:
> > On Thu, 6 Jan 2005 20:51:44 +0100
> > Andi Kleen <ak@suse.de> wrote:
> > 
> > > DaveM can probably give you more details since he tried unsucessfully
> > > to make it work. I think the problem is that there is no enough
> > > information for the compat layer to convert everything.
> > 
> > When the usbfs async stuff writes back the status, we are no
> > longer within the original syscall/ioctl execution any more,
> > therefore we don't know if we're doing this for a compat task
> > or not.
> 
> [...]
> 
> Thanks Dave for the update. I misremembered and I don't think
> I can fix this up for x86-64.  We'll need a new interface of some sort.

Poor man way of doing this is just ripping ioctl-related code from usb's devio.c
to separate file, and build this file twice, once for native_ioctl and 64bit
urb structure, and once for compat_ioctl and 32bit urb structure.

I see no reason why it should not work for apps which submit & reap URBs through
32bit or 64bit API exclusively, without mixing them (and when you mix them,
you'll get reasonable error that you did not submit specified URB).

Only problem is that after that USB code "knows" about 32bit API.  But it is
intention of compat_ioctl, no?
								Petr

P.S.:  When designing new API, please do not make it unnecessary complicated.
USB video needs rather large bandwidth and low latency, so please no ASCII
strings, and scatter-gather aware API helps a bit...
