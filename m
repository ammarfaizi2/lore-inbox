Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265766AbTF3FxT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 01:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265762AbTF3FxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 01:53:19 -0400
Received: from tag.witbe.net ([81.88.96.48]:40460 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S265759AbTF3FxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 01:53:14 -0400
From: "Paul Rolland" <rol@as2917.net>
To: "'Chris Friesen'" <cfriesen@nortelnetworks.com>, <paulus@samba.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-ppp@vger.kernel.org>
Subject: Re: [BUG]:   problem when shutting down ppp connection since 2.5.70
Date: Mon, 30 Jun 2003 08:07:25 +0200
Message-ID: <005e01c33ecd$e20ce6e0$4100a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <3EFFA1EA.7090502@nortelnetworks.com>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chris,

> Summary:
> On 2.5.70 and later kernels, shutting down a pppoe connection causes 
> pppd to hang and results in a usage count stuck at 1.
> 
> Details:
> 
> I have a pppoe dsl connection and I use the roaring penguin 
> stuff that 
> comes default with Mandrake 9.  My connection is brought up at init 
> time.  With kernels past 2.5.69, if I try and shut down the 
> connection I 
> get logs as follows:
> 
> Jun 29 17:18:39 doug kernel: unregister_netdevice: waiting 
> for ppp0 to 
> become free. Usage count = 1

Interestingly, I've got the same with device tun0 on my box, and
it appeared at the same time.
2.5.70 was really blocking as it even prevented a normal shutdown
of the box :-(

Problem is that now, there is a counter of how many "instances" are
using a netdevice... and somehow, the counter can be inc'ed, but
ppp and tun seems to never be dec'ed...

I haven't found where it is, but I made a quick fix in my own kernel
tree to decrement the reference counter each time the message is
printed... This allow my box to stop bugging me with these messages,
and now it can shutdown nicely.

Sorry, I have no other clue as to where it is broken....

Regards,
Paul

