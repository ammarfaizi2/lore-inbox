Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264286AbUD0TCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbUD0TCZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 15:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264287AbUD0TCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 15:02:15 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:5128 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S264286AbUD0TBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 15:01:47 -0400
Date: Tue, 27 Apr 2004 20:57:29 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Parag Nemade <cranium2003@yahoo.com>
Cc: kernerl mail <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com,
       linux-net@vger.kernel.org,
       netfilter <netfilter-devel@lists.netfilter.org>
Subject: Re: HELP ipt_hook: happy cracking message
Message-ID: <20040427185729.GA29913@alpha.home.local>
References: <20040426151220.85059.qmail@web41403.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040426151220.85059.qmail@web41403.mail.yahoo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 08:12:20AM -0700, Parag Nemade wrote:
> hi,
>         i modified kernel so that it will create
> /proc/net/myproc file entry.
> the function of this entry is to crate a 16 byte char
> string from random no.s
> i used net_srandom and net_random and sys_time for
> that puspose. the problem is that i write program to
> generate string after 120 seconds but it is changing
> contents of myproc file every seconds. what can i do?

may be you're sleeping for 120 instead of 120*HZ, which
means you're really sleeping 1.2s on x86.

>  Also i am getting ipt_hook: happy cracking. message
> again and again why?

iptable_mangle.c comment reads 'root is playing with
raw sockets' above this message. It means that you're
sending too short IP packets (len < 20 bytes) or packets
with the IHL field < 5. It's just a harmless message.

Regards,
Willy

