Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132344AbRCZGyL>; Mon, 26 Mar 2001 01:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132351AbRCZGyB>; Mon, 26 Mar 2001 01:54:01 -0500
Received: from samar.sasken.com ([164.164.56.2]:56828 "EHLO samar.sasi.com")
	by vger.kernel.org with ESMTP id <S132344AbRCZGxw>;
	Mon, 26 Mar 2001 01:53:52 -0500
Date: Mon, 26 Mar 2001 17:51:43 +0530 (IST)
From: Manoj Sontakke <manojs@sasken.com>
To: Oleg Drokin <green@ixcelerator.com>
cc: Oleg Drokin <green@dredd.crimea.edu>, linux-kernel@vger.kernel.org,
        davem@redhat.com, kuznet@ms2.inr.ac.ru
Subject: Re: IP layer bug?
In-Reply-To: <20010326100941.A16800@iXcelerator.com>
Message-ID: <Pine.LNX.4.21.0103261739260.25784-100000@pcc65.sasi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Mon, 26 Mar 2001, Oleg Drokin wrote:

> Hello!
> 
> On Mon, Mar 26, 2001 at 04:06:19PM +0530, Manoj Sontakke wrote:
> > >    2.4.x kernel. have not tried 2.2
> > >    I just found somethig, I believe is kernel bug.
> > >    I am working with usbnet.c driver, which stores some of its
> > >    internal state in sk_buff.cb area. But once such skb passed to
> > >    upper layer with netif_rx, net/ipv4/ip_input.c reuses content of cb
> > >    (line #345), 
> > ip_options_compile() when called with first argument NULL resets cb to 0.
> I have found that already.
> 
> > This is probably because the cb is supposed to be used IP and above. The
> Sure.
> 
> > underlying layer(link and phy) could be anything so where from the
> > ip_options should start will depend upon the underlying layer.
> But here's the problem!
> If I won't zero cb in my driver before netif_rx() call,
> IP layer thinks that all my packets have various ip options set
> (source routing most notable)

U can set cb to zero, but u also plan to use cb for storing ur data. If
that happens then u need to modify the way the macro IPCB
(probably in net/ip.h) is defined. Also make sure to increase the size 
of cb to accomodate ur data. This will solve ur problem but making this
general (part of the standard kernel code) needs a lot of work in the ip
layer. The cb is also used by TCP. The same needs to be done in IP layer
but this will again largly depend on the layers below and hence the
complexity.

The alternative to this is that u can add another buffer like cb in
sk_buff.

Manoj Sontakke

