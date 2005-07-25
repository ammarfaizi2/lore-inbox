Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVGYTb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVGYTb6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 15:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbVGYT3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 15:29:43 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:58045 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261282AbVGYT3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 15:29:15 -0400
Date: Mon, 25 Jul 2005 23:28:53 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Patrick McHardy <kaber@trash.net>
Cc: James Morris <jmorris@redhat.com>, "David S. Miller" <davem@davemloft.net>,
       Harald Welte <laforge@netfilter.org>,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org
Subject: Re: Netlink connector
Message-ID: <20050725192853.GA30567@2ka.mipt.ru>
References: <20050723125427.GA11177@rama> <20050723091455.GA12015@2ka.mipt.ru> <20050724.191756.105797967.davem@davemloft.net> <Lynx.SEL.4.62.0507250154000.21934@thoron.boston.redhat.com> <20050725070603.GA28023@2ka.mipt.ru> <42E4F800.1010908@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <42E4F800.1010908@trash.net>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 25 Jul 2005 23:28:54 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2005 at 04:32:32PM +0200, Patrick McHardy (kaber@trash.net) wrote:
> Evgeniy Polyakov wrote:
> >On Mon, Jul 25, 2005 at 02:02:10AM -0400, James Morris 
> >(jmorris@redhat.com) wrote:
> >
> >>On Sun, 24 Jul 2005, David S. Miller wrote:
> >>
> >>>From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> >>>Date: Sat, 23 Jul 2005 13:14:55 +0400
> >>>
> >>>
> >>>>Andrew has no objection against connector and it lives in -mm
> >>>
> >>>A patch sitting in -mm has zero significance.
> >
> >That is why I'm asking netdev@ people again...
> 
> If I understand correctly it tries to workaround some netlink
> limitations (limited number of netlink families and multicast groups)
> by sending everything to userspace and demultiplexing it there.
> Same in the other direction, an additional layer on top of netlink
> does basically the same thing netlink already does. This looks like
> a step in the wrong direction to me, netlink should instead be fixed
> to support what is needed.

Not only it.
The main _first_ idea was to simplify userspace mesasge handling as much
as possible.
In first releases I called it ioctl-ng - any module that want ot
communicate with userspace in the way ioctl does, 
requires skb allocation/freeing/handling.
Does RTC driver writer need to know what is the difference between
shared and cloned skb? Should kernel user of such message bus
have to know about skb at all?
With char device I only need to register my callback - with kernel
connector it is the same, but allows to use the whole power of netlink,
especially without nice ioctl features like different pointer size 
in userspace and kernelspace.
And number of free netlink sockets is _very_ small, especially
if allocate new one for simple notifications, which can be easily done
using connector.
No need to allocate skb, no need to know who are those monsters in
header and so on.

And netlink can be extended to support it - netlink is a transport
protocol, it should not care about higher layer message handling,
connector instead will deliver message to the end user in a very
convenient form.

P.S. I've removed netdev@redhat.com - please do not add subscribers-only
private mail lists.

-- 
	Evgeniy Polyakov
