Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271217AbTGWS6B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 14:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271222AbTGWS5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 14:57:06 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61076 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S271217AbTGWS4O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 14:56:14 -0400
Date: Wed, 23 Jul 2003 12:09:01 -0700
From: "David S. Miller" <davem@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [bernie@develer.com: Kernel 2.6 size increase]
Message-Id: <20030723120901.57746fd8.davem@redhat.com>
In-Reply-To: <20030723200658.A27856@infradead.org>
References: <20030723195355.A27597@infradead.org>
	<20030723195504.A27656@infradead.org>
	<20030723115858.75068294.davem@redhat.com>
	<20030723200658.A27856@infradead.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003 20:06:58 +0100
Christoph Hellwig <hch@infradead.org> wrote:

> I know you absolutely disliked Andi's patch to make the xfrm subsystem
> optional so we might need find other ways to make the code smaller
> on those systems that need it.

I'm willing to reconsider it.

So basically we'd have a CONFIG_NET_XFRM, and things like
AH/ESP/IPCOMP/AH6/ESP6/IPCOMP6 would say "select NET_XFRM"
in the Kconfig where they are selected.

Then when CONFIG_NET_XFRM is not set all the xfrm interfaces
called from non-ipsec non-xfrm source files get NOP versions.

Is this exactly what Andi's patch did?  Just send it on
so we can integrate this.

We actually lost a lot of code in other areas of the networking, for
example Andrew Morton and I made many bogus function inlines
undone because they made the code too large.
