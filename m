Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbTFFPFW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 11:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbTFFPFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 11:05:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:6380 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261840AbTFFPFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 11:05:20 -0400
Date: Fri, 06 Jun 2003 08:16:18 -0700 (PDT)
Message-Id: <20030606.081618.108808702.davem@redhat.com>
To: wa@almesberger.net
Cc: chas@cmf.nrl.navy.mil, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations
 (take 2)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030606121339.A3232@almesberger.net>
References: <20030606105753.A3275@almesberger.net>
	<20030606.070747.48395512.davem@redhat.com>
	<20030606121339.A3232@almesberger.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Werner Almesberger <wa@almesberger.net>
   Date: Fri, 6 Jun 2003 12:13:39 -0300

   But in the case of ATM device and VCC handling, you
   already have all the synchronous code paths (because things are
   initiated by user space), they're not very timing-critical, and
   reuse before destruction has completed is unlikely.

VCC's are just like routes, they are setup by a control
layer in userspace, and RTNL should therefore protect changes
to such things.

But regardless I should be able to yank an ATM device out of the
kernel (unregistering it) even if there are a thousand VCC's attached
to it.  The user control process gets a netlink message saying to kill
them off, but that's entirely seperate from the unregistering act
itself.
