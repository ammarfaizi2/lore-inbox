Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbVA3RXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVA3RXo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 12:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVA3RXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 12:23:44 -0500
Received: from [62.206.217.67] ([62.206.217.67]:3225 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261739AbVA3RXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 12:23:42 -0500
Message-ID: <41FD17FE.6050007@trash.net>
Date: Sun, 30 Jan 2005 18:23:10 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050106 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: "David S. Miller" <davem@davemloft.net>, Robert.Olsson@data.slu.se,
       akpm@osdl.org, torvalds@osdl.org, alexn@dsv.su.se, kas@fi.muni.cz,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Memory leak in 2.6.11-rc1?
References: <20050124114853.A16971@flint.arm.linux.org.uk> <20050125193207.B30094@flint.arm.linux.org.uk> <20050127082809.A20510@flint.arm.linux.org.uk> <20050127004732.5d8e3f62.akpm@osdl.org> <16888.58622.376497.380197@robur.slu.se> <20050127164918.C3036@flint.arm.linux.org.uk> <20050127123326.2eafab35.davem@davemloft.net> <20050128001701.D22695@flint.arm.linux.org.uk> <20050127163444.1bfb673b.davem@davemloft.net> <20050128085858.B9486@flint.arm.linux.org.uk> <20050130132343.A25000@flint.arm.linux.org.uk>
In-Reply-To: <20050130132343.A25000@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>I don't know if the code is using fragment lists in ip_fragment(), but
>on reading the code a question comes to mind: if we have a list of
>fragments, does each fragment skb have a valid (and refcounted) dst
>pointer before ip_fragment() does it's job?  If yes, then isn't the
>first ip_copy_metadata() in ip_fragment() going to overwrite this
>pointer without dropping the refcount?
>
Nice spotting. If conntrack isn't loaded defragmentation happens after
routing, so this is likely the cause.

Regards
Patrick

