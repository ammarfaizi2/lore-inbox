Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbTJHVbp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 17:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbTJHVbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 17:31:45 -0400
Received: from rth.ninka.net ([216.101.162.244]:6049 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261777AbTJHVbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 17:31:44 -0400
Date: Wed, 8 Oct 2003 14:31:21 -0700
From: "David S. Miller" <davem@redhat.com>
To: Marko Rauhamaa <marko@pacujo.net>
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, hadi@cyberus.ca,
       Robert.Olsson@data.slu.se
Subject: Re: NAPI Race?
Message-Id: <20031008143121.1efdd19d.davem@redhat.com>
In-Reply-To: <m3ekxnzaxg.fsf@lumo.pacujo.net>
References: <200310081957.XAA01425@yakov.inr.ac.ru>
	<m3ekxnzaxg.fsf@lumo.pacujo.net>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08 Oct 2003 14:17:31 -0700
Marko Rauhamaa <marko@pacujo.net> wrote:

> But do_softirq() explicitly refuses to run
> the same softirq right away.

Check current 2.6.x sources, it does loop a certain number of times
even for the same softirq type.

> Well, it almost does. You can blast a NAPI driver with a packet flood,
> and the system is happy and responsive -- no interrupts are generated,
> and packets are polled by ksoftirqd. However, you can find a packet rate
> that will cause the CPU to spend virtually all of its time in NAPI.

This situation can be created with non-NAPI drivers too.

Alexey is trying to explain to you what the true cause of the
problem is, and it's not NAPI, it's softirq starvation.
