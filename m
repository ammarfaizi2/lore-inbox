Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267536AbUH0UIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267536AbUH0UIX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 16:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267527AbUH0UIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 16:08:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1716 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267601AbUH0Tgy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 15:36:54 -0400
Date: Fri, 27 Aug 2004 12:36:29 -0700
From: "David S. Miller" <davem@redhat.com>
To: Chris Leech <chris.leech@gmail.com>
Cc: shane@hathawaymix.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] e1000 rx buffer allocation
Message-Id: <20040827123629.4b9c6a55.davem@redhat.com>
In-Reply-To: <41b516cb04082711363a009dbc@mail.gmail.com>
References: <Pine.LNX.4.60.0408261727170.9545@orangutan.jungle>
	<20040826181843.342da7a3.davem@redhat.com>
	<41b516cb04082711363a009dbc@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2004 11:36:36 -0700
Chris Leech <chris.leech@gmail.com> wrote:

> A better approach for improving jumbo frame allocations might be to
> use multiple smaller buffers for each receive, something the PRO/1000
> hardware can do but the e1000 driver has never taken advantage of.
> 
> Dave, you mentioned the possibility of drivers doing that in a
> conversation with Harald about handling fragmented packets
> (http://marc.theaimsgroup.com/?l=linux-netdev&m=109293677816177&w=2) 
> What would be the more correct approach to this?  Putting all receive
> data into page allocations and filling out the frags array, or
> chaining together small skbs using the frag_list?

Yes, you can use multiple buffers for receive packet receive
and the network stack will handle it just fine.  I would recommend
using 256 bytes for the skb->data area and put the rest in page
frags.
