Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262456AbREUK3D>; Mon, 21 May 2001 06:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262459AbREUK2x>; Mon, 21 May 2001 06:28:53 -0400
Received: from ns.suse.de ([213.95.15.193]:40973 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S262456AbREUK2p>;
	Mon, 21 May 2001 06:28:45 -0400
Date: Mon, 21 May 2001 12:27:53 +0200
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Andi Kleen <ak@suse.de>, Andrea Arcangeli <andrea@suse.de>,
        Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010521122753.A2507@gruyere.muc.suse.de>
In-Reply-To: <20010520163323.G18119@athlon.random> <15112.26868.5999.368209@pizda.ninka.net> <20010521034726.G30738@athlon.random> <15112.48708.639090.348990@pizda.ninka.net> <20010521105944.H30738@athlon.random> <15112.55709.565823.676709@pizda.ninka.net> <20010521112357.A1718@gruyere.muc.suse.de> <15112.57377.723591.710628@pizda.ninka.net> <20010521114216.A1968@gruyere.muc.suse.de> <15112.59192.613218.796909@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15112.59192.613218.796909@pizda.ninka.net>; from davem@redhat.com on Mon, May 21, 2001 at 03:00:24AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2001 at 03:00:24AM -0700, David S. Miller wrote:
>  > That's currently the case, but at least on IA32 the block layer
>  > must be fixed soon because it's a serious performance problem in
>  > some cases (and fixing it is not very hard).
> 
> If such a far reaching change goes into 2.4.x, I would probably
> begin looking at enhancing the PCI dma interfaces as needed ;-)

Hmm, I don't think it'll be a far reaching change. As far as I can see 
all it needs is a new entry point for block device drivers that uses 
bh->b_page. When that entry point exists skip the create_bounce call 
in __make_request. After that it is purely problem for selected drivers.

[BTW, the 2.4.4 netstack does not seem to make any attempt to handle the
pagecache > 4GB case on IA32 for sendfile, as the pci_* functions are dummies 
here.  It probably needs bounce buffers there for this case]



-Andi
