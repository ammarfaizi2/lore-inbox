Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264394AbTFIOmh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 10:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264403AbTFIOmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 10:42:37 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:58802 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S264394AbTFIOmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 10:42:36 -0400
Message-Id: <200306091456.h59Eu5sG022768@ginger.cmf.nrl.navy.mil>
To: "David S. Miller" <davem@redhat.com>
cc: baldrick@wanadoo.fr, wa@almesberger.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2) 
In-reply-to: Your message of "Mon, 09 Jun 2003 07:00:14 PDT."
             <20030609.070014.118613484.davem@redhat.com> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Mon, 09 Jun 2003 10:54:13 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: (*) hits=1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030609.070014.118613484.davem@redhat.com>,"David S. Miller" write
s:
>   (see latest rfc patch).
>   
>You do know that won't compile with current 2.5.x right?
>All the struct sock members got renamed to have a "sk_" prefix
>2 days ago :-)

i do remember you telling me that.  i pulled a new copy of the tree
and will get my patch fixed.  in the meantime the curious should use
a slightly older kernel.

>But I did like the general direction you were going in.  I can't
>comment on things like getting rid of ATM_*_ITF or whatever it's
>called because I don't know what that thing does ;)

you could say open vcp.vci but i dont care which interface you use.
typically you care which atm interface you might exit.  they might
not be connected to the same network.  i can see how this might be
useful for load balancing.  but even then you still might something
smarter to do the selection.  perhaps only two interfaces are load
balancing.  the third might be your dsl uplink.  forethought (the 
marconi atm stack) has an idea of failover groups.  you define these
as a list of adapters.  any adapter in the group can handle a call
setup.  this works ok for svc's since sigd can take care of the mess.
for pvc's i dont entirely see the point.  regardless, i think the 'any'
interface idea should be handled in user space and the kernel always
passed a 'real' interface.
