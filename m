Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266279AbUARISf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 03:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266285AbUARISd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 03:18:33 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:20392 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S266279AbUARISZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 03:18:25 -0500
Message-ID: <400A4147.4090405@colorfullife.com>
Date: Sun, 18 Jan 2004 09:18:15 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Andrew Morton <akpm@osdl.org>, dwmw2@infradead.org,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] kill sleep_on
References: <40098251.2040009@colorfullife.com>	 <1074367701.9965.2.camel@imladris.demon.co.uk>	 <20040117201000.GL21151@parcelfarce.linux.theplanet.co.uk>	 <1074383111.9965.4.camel@imladris.demon.co.uk>	 <20040117224139.5585fb9c.akpm@osdl.org>	 <1074409074.1569.12.camel@nidelv.trondhjem.org>	 <20040117233618.094c9d22.akpm@osdl.org> <400A396B.4090207@colorfullife.com> <1074412980.1574.40.camel@nidelv.trondhjem.org>
In-Reply-To: <1074412980.1574.40.camel@nidelv.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

>I'm not sure that taking inode->i_sem would be much of an improvement.
>Both th BKL and the inode semaphore seem superfluous to me in this
>situation.
>
I think the purpose of i_sem or lock_kernel is to protect the file 
pointer. Most local filesystems use i_sem, it's noticably faster - 
global vs. per-object locking.
Btw, generic_mapping_read should also lock it's accesses to f_pos: right 
now it reads and writes f_pos without any locking...

--
    Manfred

