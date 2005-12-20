Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbVLTVX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbVLTVX7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 16:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbVLTVX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 16:23:58 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:14763
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932121AbVLTVX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 16:23:58 -0500
Date: Tue, 20 Dec 2005 13:23:58 -0800 (PST)
Message-Id: <20051220.132358.106631597.davem@davemloft.net>
To: benh@kernel.crashing.org
Cc: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, davem@redhat.com,
       eric.lemoine@gmail.com
Subject: Re: sungem hangs in atomic if netconsole enabled but no carrier
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1135113521.10035.107.camel@gaston>
References: <1135080538.3937.3.camel@localhost>
	<1135113521.10035.107.camel@gaston>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 21 Dec 2005 08:18:40 +1100

> 
> > Turns out that if I remove the netconsole=... option to my kernel, all
> > works fine and the system no longer hangs. Obviously not plugging in a
> > network cable is pretty useless when netconsole is turned on, but I
> > think it should not hang the system completely. So far I haven't been
> > able to figure out where it actually hangs and don't even know how to do
> > so -- I'm open for suggestions on how to find out why/where it hangs or
> > even fixes.
> 
> Hrm... I've heard various reports about problems with netconsole... I've
> never tried it myself so far though. One thing I remember to beware of
> is if sungem does a printk while holding its lock...

I bet that's it, doing a printk while already in the netconsole
printk output path.
