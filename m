Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbVCKTGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVCKTGm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 14:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVCKTGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 14:06:13 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:28033
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261322AbVCKSzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 13:55:06 -0500
Date: Fri, 11 Mar 2005 10:51:36 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Patrick McHardy <kaber@trash.net>
Cc: dtor_core@ameritech.net, netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org
Subject: Re: Last night Linus bk - netfilter busted?
Message-Id: <20050311105136.2a5e4ddc.davem@davemloft.net>
In-Reply-To: <4231A498.4020101@trash.net>
References: <200503110223.34461.dtor_core@ameritech.net>
	<4231A498.4020101@trash.net>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2005 15:00:56 +0100
Patrick McHardy <kaber@trash.net> wrote:

> Works fine here. You could try if reverting one of these two patches
> helps (second one only if its a SMP box).
> 
> ChangeSet@1.2010, 2005-03-09 20:28:17-08:00, bdschuym@pandora.be
>    [NETFILTER]: Reduce call chain length in netfilter (take 2)

It's this change, I know it is, because Linus sees the same problem
on his workstation.

You wouldn't happen to be seeing this problem on a PPC box would
you?  Since Linus's machine is a PPC machine too, that would support
my theory that this could be a compiler issue on that platform.

Damn, wait, Patrick, I think I know what's happening.  The iptables
IPT_* verdicts are dependant upon the NF_* values, and they don't
cope with Bart's changes I bet.  Can you figure out what the exact
error would be?  This kind of issue would explain the looping inside
of ipt_do_table(), wouldn't it?
