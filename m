Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbVAFVc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbVAFVc0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 16:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263033AbVAFV1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 16:27:13 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:15497 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263036AbVAFVZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 16:25:08 -0500
Date: Thu, 6 Jan 2005 13:24:24 -0800
From: Greg KH <greg@kroah.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@davemloft.net>,
       linux-usb-devel@lists.sourceforge.net, mst@mellanox.co.il,
       akpm@osdl.org, linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [PATCH] macros to detect existance of unlocked_ioctl and ioctl_compat
Message-ID: <20050106212424.GA6465@kroah.com>
References: <20050106145356.GA18725@infradead.org> <20050106163559.GG5772@vana.vc.cvut.cz> <20050106165715.GH1830@wotan.suse.de> <20050106172613.GI5772@vana.vc.cvut.cz> <20050106175342.GA28889@wotan.suse.de> <20050106193520.GA5481@kroah.com> <20050106195144.GE28889@wotan.suse.de> <20050106115959.45d793e1.davem@davemloft.net> <20050106204431.GH28889@wotan.suse.de> <20050106210921.GK5772@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106210921.GK5772@vana.vc.cvut.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 10:09:21PM +0100, Petr Vandrovec wrote:
> On Thu, Jan 06, 2005 at 09:44:31PM +0100, Andi Kleen wrote:
> > On Thu, Jan 06, 2005 at 11:59:59AM -0800, David S. Miller wrote:
> > > On Thu, 6 Jan 2005 20:51:44 +0100
> > > Andi Kleen <ak@suse.de> wrote:
> > > 
> > > > DaveM can probably give you more details since he tried unsucessfully
> > > > to make it work. I think the problem is that there is no enough
> > > > information for the compat layer to convert everything.
> > > 
> > > When the usbfs async stuff writes back the status, we are no
> > > longer within the original syscall/ioctl execution any more,
> > > therefore we don't know if we're doing this for a compat task
> > > or not.

Ick, yeah, now I remember...

> P.S.:  When designing new API, please do not make it unnecessary complicated.
> USB video needs rather large bandwidth and low latency, so please no ASCII
> strings, and scatter-gather aware API helps a bit...

In measurements published on linux-usb-devel, pure userspace calls using
the current usbfs code generated almost full bandwidth usage (within the
hardware limits).  So adding the scatter-gather api interface to usbfs
wouldn't really provide that much benefit.

And, we can always use help in designing such an API, if you could find
someone at your company to help us out in doing so... :)

thanks,

greg k-h
