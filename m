Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274983AbTHAXBy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 19:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274982AbTHAXBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 19:01:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:30865 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274980AbTHAXBv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 19:01:51 -0400
Date: Fri, 1 Aug 2003 16:01:49 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Peter Johanson <latexer@gentoo.org>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: rmmodding e100 trace calls on 2.6.0-test2-mm2
Message-Id: <20030801160149.2392a079.shemminger@osdl.org>
In-Reply-To: <20030801224932.GA4241@gonzo.peterjohanson.com>
References: <20030801224932.GA4241@gonzo.peterjohanson.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.3claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of the -mm patches produces a warning which will be taken care of later when
all the network drivers are converted to dynamically allocating net_device's.
At that point, a massive patch will be needed that changes all instances of:

	unregister_netdev(dev);
	my cleanup...
	kfree(dev);   // becomes release_netdev(dev);

new release_netdev() will release the dev kobject at that point.

I have the code ready, just been waiting till all net device's converted.
Prefer not to break the world at this point.
