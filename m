Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262606AbVFXIkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbVFXIkr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 04:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVFXIkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 04:40:46 -0400
Received: from [62.206.217.67] ([62.206.217.67]:48095 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S262606AbVFXIje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 04:39:34 -0400
Message-ID: <42BBC6AC.9010704@trash.net>
Date: Fri, 24 Jun 2005 10:39:08 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8) Gecko/20050514 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: rankincj@yahoo.com, chrisw@osdl.org, bdschuym@pandora.be,
       bdschuym@telenet.be, herbert@gondor.apana.org.au,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       ebtables-devel@lists.sourceforge.net, netfilter-devel@manty.net
Subject: Re: 2.6.12: connection tracking broken?
References: <20050622225816.97752.qmail@web52903.mail.yahoo.com>	<42BAF48E.70309@trash.net> <20050623.124951.130237121.davem@davemloft.net>
In-Reply-To: <20050623.124951.130237121.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> I have the patch, can you give me a nice changelog entry
> for it?

Here you go:

In 2.6.12 we started dropping the conntrack reference when a packet
leaves the IP layer. This broke connection tracking on a bridge,
because bridge-netfilter defers calling some NF_IP_* hooks to the bridge
layer for locally generated packets going out a bridge, where the
conntrack reference is no longer available. This patch keeps the
reference in this case as a temporary solution, long term we will
remove the defered hook calling. No attempt is made to drop the
reference in the bridge-code when it is no longer needed, tc actions
could already have sent the packet anywhere.

Regards
Patrick

