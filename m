Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUFSTFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUFSTFW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 15:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbUFSTFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 15:05:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:1252 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263117AbUFSTFQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 15:05:16 -0400
Date: Sat, 19 Jun 2004 12:04:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: dipankar@in.ibm.com
Cc: mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reduce rcu_head size [2/2]
Message-Id: <20040619120414.57d985f1.akpm@osdl.org>
In-Reply-To: <20040616054746.GC3658@in.ibm.com>
References: <20040616054604.GA3658@in.ibm.com>
	<20040616054713.GB3658@in.ibm.com>
	<20040616054746.GC3658@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma <dipankar@in.ibm.com> wrote:
>
>  This patch changes the call_rcu() API and avoids passing an
>  argument to the callback function as suggested by Rusty. 

This breaks the bridge driver:


static void destroy_nbp(struct rcu_head *head)

int br_add_if(struct net_bridge *br, struct net_device *dev)
{
	struct net_bridge_port *p;

	...
		destroy_nbp(p);


