Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbUFEVEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUFEVEW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 17:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbUFEVEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 17:04:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58535 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261987AbUFEVEU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 17:04:20 -0400
Date: Sat, 5 Jun 2004 14:01:53 -0700
From: "David S. Miller" <davem@redhat.com>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] compat bug in sys_recvmsg, MSG_CMSG_COMPAT check
 missing
Message-Id: <20040605140153.6c5945a0.davem@redhat.com>
In-Reply-To: <20040605204334.GA1134@suse.de>
References: <20040605204334.GA1134@suse.de>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jun 2004 22:43:34 +0200
Olaf Hering <olh@suse.de> wrote:

> packet_recvmsg() gets the flags from the compat_sys_socketcall(), but it
> does not check for the active MSG_CMSG_COMPAT bit. As a result, it
> returns -EINVAL and makes the user rather unhappy

Not just packet_recvmsg() (frankly, I'm stumped how tcpdump is working
on my sparc64 boxes due to this bug!), every other sendmsg/recvmsg
implementation has a test like this verifying the msg_flags for bogons.

Let's ask a better question, why do we need to pass this thing down
into the implementations anyways?

I can't see a reason, can anyone else?  If there is no reason, the
right fix is simply to mask it out at the top level, for both
sendmsg and recvmsg.
