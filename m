Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUGFUBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUGFUBR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 16:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUGFUBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 16:01:17 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:2747 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261500AbUGFUBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 16:01:13 -0400
Message-ID: <40EB04C7.4000007@us.ibm.com>
Date: Tue, 06 Jul 2004 13:00:07 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: "David S. Miller" <davem@redhat.com>, bert hubert <ahu@ds9a.nl>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>, netdev@oss.sgi.com,
       alessandro.suardi@oracle.com, phyprabab@yahoo.com,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix tcp_default_win_scale.
References: <32886.63.170.215.71.1088564087.squirrel@www.osdl.org>	<20040629222751.392f0a82.davem@redhat.com>	<20040630152750.2d01ca51@dell_ss3.pdx.osdl.net>	<20040630153049.3ca25b76.davem@redhat.com>	<20040701133738.301b9e46@dell_ss3.pdx.osdl.net>	<20040701140406.62dfbc2a.davem@redhat.com>	<20040702013225.GA24707@conectiva.com.br>	<20040706093503.GA8147@outpost.ds9a.nl> <20040706114741.1bf98bbe@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040706114741.1bf98bbe@dell_ss3.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> Recent TCP changes exposed the problem that there ar lots of really broken firewalls 
> that strip or alter TCP options.

We should not be accepting of this situation, surely. I mean, the firewalls
have to get fixed. Multiple things are breaking here, due to this. What
are the other options they are messing with, and and any idea why?

> When the options are modified TCP gets busted now.  The problem is that when
> we propose window scaling, we expect that the other side receives the same initial
> SYN request that we sent.  If there is corrupting firewalls that strip it then
> the window we send is not correctly scaled; so the other side thinks there is not
> enough space to send.

If the firewall is actually stripping the TCP window scaling option,
then that tells the other end that we can't *receive* scaled windows
either, since the option indicates both, we are sending and capable
of receiving. i.e. The other end will not send us scaled windows.
There is no way we can fix this on the rcv end.

> I propose that the following that will avoid sending window scaling that
> is big enough to break in these cases unless the tcp_rmem has been increased.
> It will keep default configuration from blowing in a corrupt world.

Does this need to be the default behaviour? Just how prevalent is
this??

thanks,
Nivedita

