Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbTFFNom (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 09:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbTFFNom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 09:44:42 -0400
Received: from almesberger.net ([63.105.73.239]:53512 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261279AbTFFNol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 09:44:41 -0400
Date: Fri, 6 Jun 2003 10:57:53 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "David S. Miller" <davem@redhat.com>
Cc: chas@cmf.nrl.navy.mil, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2)
Message-ID: <20030606105753.A3275@almesberger.net>
References: <20030606.023618.13768006.davem@redhat.com> <200306061100.h56B08sG024506@ginger.cmf.nrl.navy.mil> <20030606.040410.54190551.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030606.040410.54190551.davem@redhat.com>; from davem@redhat.com on Fri, Jun 06, 2003 at 04:04:10AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> This is very different from how you are using the lock+rtnl scheme
> for your ATM stuff.

What should help in the ATM code is that it pushes synchronization
"down", i.e. "close" functions usually can't return until they are
truly done (or at least have made sure there is nothing externally
visible left).

In the case of devices, delayed removal is possible, but is then
initiated when closing a VCC (VCCs act as an implicit reference
count for devices), which is another synchronous operation.

VCC creation/removal in response to other asynchronous activity,
e.g. after ARP, is relayed through user-space demons, which then
make normal system calls to implement the change.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
