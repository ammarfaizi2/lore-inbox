Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbTFFViN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 17:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbTFFViN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 17:38:13 -0400
Received: from [63.205.85.133] ([63.205.85.133]:18899 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S262297AbTFFViM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 17:38:12 -0400
Date: Fri, 6 Jun 2003 14:54:06 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: "David S. Miller" <davem@redhat.com>
Cc: wa@almesberger.net, chas@cmf.nrl.navy.mil, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2)
Message-ID: <20030606215406.GE21217@gaz.sfgoth.com>
References: <20030606122616.B3232@almesberger.net> <20030606.082802.124082825.davem@redhat.com> <20030606125416.C3232@almesberger.net> <20030606.085558.56056656.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030606.085558.56056656.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    (If you want to keep Chas busy, the communication between
>    the kernel and its demons may be a much more interesting
>    topic ;-)
>    
> Tell me it at least uses netlink ;(

No.... not even close :-(

The really gross part is that it uses kernel-land pointers as "opaque" VC
descriptors, so basically if atmsigd goes nuts in can easily stomp all
over the kernel's memory.  Way back when I added a CAP_SYS_RAWIO check to
the ATMSIGD_CTRL ioctl so at least there's no security hole but it's still
damn gross (no offense, Werner :-)

I agree that fixing that old cruft would be a lot more productive than
trying to shoehorn the ATM devices into the netdevice framework.

-Mitch
