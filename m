Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263564AbTJVLQN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 07:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263591AbTJVLQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 07:16:13 -0400
Received: from dwdmx2.dwd.de ([141.38.3.197]:43390 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id S263564AbTJVLOv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 07:14:51 -0400
Date: Wed, 22 Oct 2003 11:14:47 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@praktifix.dwd.de
To: "David S. Miller" <davem@redhat.com>
cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Finding memory leak
In-Reply-To: <20031019212316.58e64378.davem@redhat.com>
Message-Id: <Pine.LNX.4.44.0310221058520.7238-100000@praktifix.dwd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Oct 2003, David S. Miller wrote:

> On Sat, 18 Oct 2003 19:59:12 +0200
> Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
> 
> > Andrew, DaveM, can this go into -test9?
> 
> Please have a look at current sources before asking questions
> like this ok? :-)
> 
But what about 2.4.22? I am having a leak there, my size-2048 value
is always going up. As mentioned earlier this seems to happen
everytime igmpv3_newpack() gets called and allocates 1529 bytes.

I took igmpv3_newpack() from 2.6.0-test8, had to made some changes

        {
                struct rt_key key = {};

                key.dst = IGMPV3_ALL_MCR;
                key.oif = dev->ifindex;
                if (ip_route_output_key(&rt, &key)) {
                        kfree_skb(skb);
                        return 0;
                }
        }

since there is no struct flowi in 2.4.x. Don't know if the above is
correct, but the leak is still there.

The size-2048 values always go up when we receive data via a DVB card from
multiple multicast streams. Depending on the amount of memory the system
has, they always hangup after a certain time.

What else can I do find the leak?

Please help.

Thanks,
Holger

