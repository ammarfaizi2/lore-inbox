Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266940AbTAPANh>; Wed, 15 Jan 2003 19:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266944AbTAPANh>; Wed, 15 Jan 2003 19:13:37 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:10791 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id <S266940AbTAPANe>; Wed, 15 Jan 2003 19:13:34 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix up RTM_SETLINK handling
References: <52smvukic3.fsf@topspin.com>
	<20030115.160716.23576593.davem@redhat.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 15 Jan 2003 16:22:22 -0800
In-Reply-To: <20030115.160716.23576593.davem@redhat.com>
Message-ID: <52of6ihrk1.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 16 Jan 2003 00:22:04.0656 (UTC) FILETIME=[4BEBF700:01C2BCF5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Roland> To call the netdev notifier chain I had to make
    Roland> netdev_chain not be static.  I added the declaration to
    Roland> <linux/netdevice.h> but I am open to other ways to give
    Roland> rtnetlink.c access to netdev_chain.
   
    David> Ummm, what is the problem with using
    David> register_netdevice_notifier()?  It is precisely there so
    David> that netdev_chain need not be exported.

do_setlink() needs to do the opposite of registering a notifier --
it's changing an interface's address, so it needs to call the
netdev_chain with NETDEV_CHANGEADDR (just like the handler for
SIOCSIFHWADDR does).

If you prefer, I could add a call_netdevice_notifiers() to dev.c and
leave netdev_chain static.  Just let me know and I'll make a new
patch.

Thanks,
  Roland
