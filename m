Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268214AbUHQNKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268214AbUHQNKR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 09:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268218AbUHQNKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 09:10:16 -0400
Received: from mail.gmx.de ([213.165.64.20]:14540 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268214AbUHQNKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 09:10:09 -0400
X-Authenticated: #1725425
Date: Tue, 17 Aug 2004 15:25:23 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Christer Weinigel <christer@weinigel.se>
Cc: fsteiner-mail@bio.ifi.lmu.de, alan@lxorguk.ukuu.org.uk,
       jwendel10@comcast.net, linux-kernel@vger.kernel.org,
       Kai.Makisara@kolumbus.fi
Subject: Re: 2.6.8.1 Mis-detect CRDW as CDROM
Message-Id: <20040817152523.5c6fc0f6.Ballarin.Marc@gmx.de>
In-Reply-To: <m37jry57fa.fsf@zoo.weinigel.se>
References: <411FD919.9030702@comcast.net>
	<20040816143817.0de30197.Ballarin.Marc@gmx.de>
	<1092661385.20528.25.camel@localhost.localdomain>
	<20040816231211.76360eaa.Ballarin.Marc@gmx.de>
	<4121A689.8030708@bio.ifi.lmu.de>
	<m37jry57fa.fsf@zoo.weinigel.se>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Aug 2004 13:29:45 +0200
Christer Weinigel <christer@weinigel.se> wrote:

> ...
> Some commands are a bit questionable though, for example, should it be
> possible to use GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL with only read
> permissions?  
> 
> The MODE_SELECT command I belive is needed for read on some tape
> drives because tape parameters such as compression and tape density
> are configured this way.  But there might be a device where a
> MODE_SELECT on a vendor configuration page might destroy the device,
> so it might not be such a good idea to allow MODE_SELECT and in that
> case I don't know how it should be handled.
> 

That's the biggest problem. I fear it might be necessary to make checks
device specific (at least for device classes) *and* even include operation
modes.
For example WRITE BUFFER in default mode would be safe and maybe useful
for read. However it can also be used to overwrite firmware, which makes it
unsafe even for regular write.

> Hopefully all commands needed for CD/DVD reading and writing are safe
> enough to be allowed with just read or write permission.
> 

The question is how other device types will interpret some of those commands.

Regards
