Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132328AbRCZGNL>; Mon, 26 Mar 2001 01:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132329AbRCZGNC>; Mon, 26 Mar 2001 01:13:02 -0500
Received: from zeus.kernel.org ([209.10.41.242]:23494 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132328AbRCZGM4>;
	Mon, 26 Mar 2001 01:12:56 -0500
Date: Mon, 26 Mar 2001 10:09:41 +0400
From: Oleg Drokin <green@ixcelerator.com>
To: Manoj Sontakke <manojs@sasken.com>
Cc: Oleg Drokin <green@dredd.crimea.edu>, linux-kernel@vger.kernel.org,
        davem@redhat.com, kuznet@ms2.inr.ac.ru
Subject: Re: IP layer bug?
Message-ID: <20010326100941.A16800@iXcelerator.com>
In-Reply-To: <20010325005731.A5243@dredd.crimea.edu> <Pine.LNX.4.21.0103261555250.25563-100000@pcc65.sasi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0103261555250.25563-100000@pcc65.sasi.com>; from manojs@sasken.com on Mon, Mar 26, 2001 at 04:06:19PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Mar 26, 2001 at 04:06:19PM +0530, Manoj Sontakke wrote:
> >    2.4.x kernel. have not tried 2.2
> >    I just found somethig, I believe is kernel bug.
> >    I am working with usbnet.c driver, which stores some of its
> >    internal state in sk_buff.cb area. But once such skb passed to
> >    upper layer with netif_rx, net/ipv4/ip_input.c reuses content of cb
> >    (line #345), 
> ip_options_compile() when called with first argument NULL resets cb to 0.
I have found that already.

> This is probably because the cb is supposed to be used IP and above. The
Sure.

> underlying layer(link and phy) could be anything so where from the
> ip_options should start will depend upon the underlying layer.
But here's the problem!
If I won't zero cb in my driver before netif_rx() call,
IP layer thinks that all my packets have various ip options set
(source routing most notable)

Bye,
    Oleg
