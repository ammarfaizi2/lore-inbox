Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262365AbSJ2WFk>; Tue, 29 Oct 2002 17:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262374AbSJ2WFk>; Tue, 29 Oct 2002 17:05:40 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:55424 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262365AbSJ2WFj>; Tue, 29 Oct 2002 17:05:39 -0500
Subject: Re: [BK updates] fbdev changes updates.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: James Simmons <jsimmons@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <20021029200838.GA27552@suse.de>
References: <Pine.LNX.4.33.0210291240170.14451-100000@maxwell.earthlink.net> 
	<20021029200838.GA27552@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Oct 2002 22:31:04 +0000
Message-Id: <1035930664.1603.23.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-29 at 20:08, Dave Jones wrote:
> On Tue, Oct 29, 2002 at 12:45:10PM -0800, James Simmons wrote:
>  > The reason for this is we will see in the future embedded ix86
>  > boards with things like i810 framebuffers with NO vga core. In this case
>  > we will need a fbdev driver for a graphical console. Thus the agp code
>  > must be started before the fbdev layer.
> 
> Can you explain exactly what the agpgart code is doing that needs
> to be done earlier than framebuffer ? I don't see any reason for this
> change. There should be no GART mappings until we've booted userspace
> (except for the case of IOMMU)

The i8xx draws the frame buffer memory from AGP as well as the texture
mappings and other goodies. The practical impact of that is that if you
want any useful video mode you need AGP initialized first. For UMA video
devices its an extremely neat way of avoiding pre-allocation of fixed
size frame buffers before the OS boots


