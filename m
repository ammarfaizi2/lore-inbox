Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUG0LSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUG0LSf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 07:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264261AbUG0LSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 07:18:35 -0400
Received: from [195.23.16.24] ([195.23.16.24]:37350 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S264098AbUG0LSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 07:18:33 -0400
Subject: Re: Inode question
From: Paulo Marques <pmarques@grupopie.com>
Reply-To: pmarques@grupopie.com
To: sankarshana rao <san_wipro@yahoo.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20040727012807.96145.qmail@web50901.mail.yahoo.com>
References: <20040727012807.96145.qmail@web50901.mail.yahoo.com>
Content-Type: text/plain
Organization: Grupo PIE
Message-Id: <1090927110.11604.7.camel@pmarqueslinux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 27 Jul 2004 12:18:30 +0100
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.26.0.10; VDF: 6.26.0.44; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-27 at 02:28, sankarshana rao wrote:
> Thx for the inputs..
> I am trying this thing on Mips processor and creating
> 500 folders itself takes about 1.6 seconds. That's why
> I was wondering if using inodes would make it any
> faster..
> pls guide...

I really think the name lookup is not your bottleneck.

I did some more tests to check where the time to create a dir came from
and, as expected, it depends a lot on the filesystem.

Using ext3, creating 1000 dirs on my machine (P4 2.8GHz) takes about 100
ms. Using tmpfs, takes only 6 ms. Even a machine 20 times slower would
take at most 60ms to do the 500 lookups.

Both tests have to do the same lookup on the dentry cache and check for
duplicate names, etc. 

So the real difference is the time *the filesystem* takes to create a
dir.

You're probably using JFFS2 or something like that, which is almost 
synchronous (I don't know for sure if it is really synchronous), and
writes the updates to flash on every dir creation.

I hope this helps,

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"

