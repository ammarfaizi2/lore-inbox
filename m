Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264763AbUGZBIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264763AbUGZBIQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 21:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264770AbUGZBIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 21:08:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:58002 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264763AbUGZBIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 21:08:14 -0400
Date: Sun, 25 Jul 2004 18:06:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: kladit@t-online.de (Klaus Dittrich)
Cc: ahu@ds9a.nl, kladit@t-online.de, linux-kernel@vger.kernel.org
Subject: Re: dentry cache leak? Re: rsync out of memory 2.6.8-rc2
Message-Id: <20040725180648.30a6f3f4.akpm@osdl.org>
In-Reply-To: <40FBC4E9.2000504@xeon2.local.here>
References: <20040719091943.GA866@xeon2.local.here>
	<20040719112047.GA14784@outpost.ds9a.nl>
	<20040719113228.GA15295@outpost.ds9a.nl>
	<40FBC4E9.2000504@xeon2.local.here>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kladit@t-online.de (Klaus Dittrich) wrote:
>
> The fs is ext2.cat /proc/sys/fs/dentry-state
>  Output of  cat /proc/sys/fs/dentry-state before and after processes got 
>  killed.
>  891083  888395  45      0       0       0
>  1142933 1085759 45      0       0       0

This bug is probably unique to yourself and a couple of other people.  If
it was hitting everyone, all the machines in the world would be going oom
during the nightly updatedb run.

Can you try a different compiler version?  And try disabling any "unusual"
config options, such as filesystem quotas, extended attributes, etc?

Can you narrow the onset of the problem down to any particular kernel
snapshot?

Try disabling laptop_mode, if it's set.

Carefully review the logs for any oopses: oopsing while holding
shrinker_sem will do this for sure.

