Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264717AbUGFXUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264717AbUGFXUU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 19:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbUGFXUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 19:20:04 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:12349 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S264717AbUGFXTb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 19:19:31 -0400
Subject: Re: [PATCH] fix tcp_default_win_scale.
From: Redeeman <lkml@metanurb.dk>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, bert hubert <ahu@ds9a.nl>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>, netdev@oss.sgi.com,
       alessandro.suardi@oracle.com, phyprabab@yahoo.com,
       linux-net@vger.kernel.org,
       LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20040706114741.1bf98bbe@dell_ss3.pdx.osdl.net>
References: <32886.63.170.215.71.1088564087.squirrel@www.osdl.org>
	 <20040629222751.392f0a82.davem@redhat.com>
	 <20040630152750.2d01ca51@dell_ss3.pdx.osdl.net>
	 <20040630153049.3ca25b76.davem@redhat.com>
	 <20040701133738.301b9e46@dell_ss3.pdx.osdl.net>
	 <20040701140406.62dfbc2a.davem@redhat.com>
	 <20040702013225.GA24707@conectiva.com.br>
	 <20040706093503.GA8147@outpost.ds9a.nl>
	 <20040706114741.1bf98bbe@dell_ss3.pdx.osdl.net>
Content-Type: text/plain
Date: Wed, 07 Jul 2004 01:19:25 +0200
Message-Id: <1089155965.15544.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-06 at 11:47 -0700, Stephen Hemminger wrote:
> Recent TCP changes exposed the problem that there ar lots of really broken firewalls 
> that strip or alter TCP options.
> When the options are modified TCP gets busted now.  The problem is that when
> we propose window scaling, we expect that the other side receives the same initial
> SYN request that we sent.  If there is corrupting firewalls that strip it then
> the window we send is not correctly scaled; so the other side thinks there is not
> enough space to send.
> 
> I propose that the following that will avoid sending window scaling that
> is big enough to break in these cases unless the tcp_rmem has been increased.
> It will keep default configuration from blowing in a corrupt world.
so this should fix the issues? can you also tell me why this suddenly happend? that would make me a real happy man

> Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

