Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261446AbSKKV4q>; Mon, 11 Nov 2002 16:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261448AbSKKV4q>; Mon, 11 Nov 2002 16:56:46 -0500
Received: from louise.pinerecords.com ([212.71.160.16]:1542 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S261446AbSKKV4l>; Mon, 11 Nov 2002 16:56:41 -0500
Date: Mon, 11 Nov 2002 23:02:46 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to export a symbol so that I can use it in a module
Message-ID: <20021111220246.GH285@louise.pinerecords.com>
References: <002c01c289cc$e6468470$3640a8c0@boemboem>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002c01c289cc$e6468470$3640a8c0@boemboem>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've added a function "create_tcp_port_number" to net/core/utils.c
> like this:
> 
> int create_tcp_port_number(void)
> {
> /* blah blah */
> }
> EXPORT_SYMBOL(create_tcp_port_number);
> 
> in include/linux/net.h I added:
> extern int create_tcp_port_number(void);
> 
> So, now in net/ipv6/tcp_ipv6.c I used this 'create_tcp_port_number'
> function. I'm compiling the kernel with ipv6 as a module. And that's
> where I get the problem. In the last stage, the makefile does a
> depmod and then I get:
> depmod: *** Unresolved symbols in /lib/modules/2.4.19/kernel/net/ipv6/ipv6.o
> depmod:         create_tcp_port_number
> 
> I'm really out of ideas what can be the cause of this. It must be
> something trivial, but I cannot find the solution. Anyone who can
> help me?

Make sure you're including <linux/module.h> into utils.c and that
utils.o is among export-objs in the makefile.

--
Tomas Szepe <szepe@pinerecords.com>
