Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbUL0LtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbUL0LtA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 06:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbUL0Ls7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 06:48:59 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:47785 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261879AbUL0Lss convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 06:48:48 -0500
Date: Mon, 27 Dec 2004 13:49:21 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Arnd Bergmann <arnd@arndb.de>
Cc: discuss@x86-64.org, Chris Wedgwood <cw@f00f.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, pavel@suse.cz, gordon.jin@intel.com
Subject: Re: [discuss] Re: unregister_ioctl32_conversion and modules. ioct l32 revisited.
Message-ID: <20041227114921.GD9233@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <200412262349.24856.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <200412262349.24856.arnd@arndb.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Quoting r. Arnd Bergmann (arnd@arndb.de) "Re: [discuss] Re: unregister_ioctl32_conversion and modules. ioct l32 revisited.":
> On Sünndag 26 Dezember 2004 23:26, Chris Wedgwood wrote:
> > > It's an internal error code as Arnd pointed out.
> > 
> > can we be sure this will never escape to userspace?  i can think of
> > somewhere else we already do this (EFSCORRUPTED) and it does (somewhat
> > deliberately escape to userspace) and this causes confusion from time
> > to time when applications see 'errno == 990'
> 
> It's safe for the compat ioctl case. If someone wants to use the
> same function for the compat and native handler, it would be a bug
> to return -ENOIOCTLCMD from that handler with the current code.
> 
> To work around this, we could either convert -ENOIOCTLCMD to -EINVAL
> when returning from sys_ioctl().

That would be -ENOTTY, I think.

> Or we could WARN_ON(err ==
> -ENOIOCTLCMD)
> for the native path in order to make the intention clear.
> 
>  Arnd <><
