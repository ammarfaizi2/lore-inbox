Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932528AbVIMX3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbVIMX3Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 19:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbVIMX3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 19:29:16 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:59362 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932529AbVIMX3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 19:29:15 -0400
Date: Tue, 13 Sep 2005 16:28:51 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       penberg@cs.helsinki.fi, jirislaby@gmail.com, lion.vollnhals@web.de
Subject: Re: [PATCH] use kzalloc instead of malloc+memset
Message-Id: <20050913162851.7467b52d.pj@sgi.com>
In-Reply-To: <20050912234200.10b2abe7.akpm@osdl.org>
References: <200509130010.38483.lion.vollnhals@web.de>
	<43260817.7070907@gmail.com>
	<84144f0205091221431827b126@mail.gmail.com>
	<200509130033.11109.dtor_core@ameritech.net>
	<20050912234200.10b2abe7.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> It hurts readability.  Quick question: is this code correct?
> 
> 	dev = kmalloc(sizeof(struct net_device), GFP_KERNEL);

And it hurts maintainability.  If someone changes 'dev' so
that it is no longer of type 'struct net_device', then they
risk missing this allocation, and introducing what could be
a nasty memory corruption kernel bug.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
