Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbUKSCPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbUKSCPJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 21:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbUKSBx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 20:53:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26752 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262849AbUKRSkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:40:52 -0500
Date: Thu, 18 Nov 2004 13:40:35 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ross Kendall Axe <ross.axe@blueyonder.co.uk>, <netdev@oss.sgi.com>,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] linux 2.9.10-rc1: Fix oops in unix_dgram_sendmsg when
 using SELinux and SOCK_SEQPACKET
In-Reply-To: <1100796518.6019.11.camel@localhost.localdomain>
Message-ID: <Xine.LNX.4.44.0411181328460.5555-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2004, Alan Cox wrote:

> On Iau, 2004-11-18 at 08:27, James Morris wrote:
> > 2) Ensure that unix_dgram_sendmsg() fails for SOCK_SEQPACKET sockets which
> > are not connected, otherwise someone could bypass LSM by sending on an
> > unconnected socket.
> 
> What about half closed and other connected states ? This patch seems
> inadequate for things like X.25

The patch only affects the Unix code and does not change existing 
semantics for other connected states.

One thing that looks broken (unrelated to the patch I posted) is that
unix_dgram_sendmsg() already does not check sk->sk_shutdown &
SEND_SHUTDOWN for SOCK_SEQPACKET.


- James
-- 
James Morris
<jmorris@redhat.com>


