Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbUFEVjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbUFEVjl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 17:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbUFEVjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 17:39:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15794 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262045AbUFEVjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 17:39:39 -0400
Date: Sat, 5 Jun 2004 14:37:14 -0700
From: "David S. Miller" <davem@redhat.com>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] compat bug in sys_recvmsg, MSG_CMSG_COMPAT check
 missing
Message-Id: <20040605143714.729744f8.davem@redhat.com>
In-Reply-To: <20040605211701.GD1134@suse.de>
References: <20040605204334.GA1134@suse.de>
	<20040605140153.6c5945a0.davem@redhat.com>
	<20040605211701.GD1134@suse.de>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jun 2004 23:17:01 +0200
Olaf Hering <olh@suse.de> wrote:

>  On Sat, Jun 05, David S. Miller wrote:
> 
> > I can't see a reason, can anyone else?  If there is no reason, the
> > right fix is simply to mask it out at the top level, for both
> > sendmsg and recvmsg.
> 
> I did it first this way, but the result was a long delay until the dhcp
> server replied, the patch sent earlier leads to a fast reply.
> 
>     err = sock_recvmsg(sock, &msg_sys, total_len, flags & ~MSG_CMSG_COMPAT);

See my other email, net/core/scm.c needs this bit set all the
way down into the implementations.
