Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265784AbUGZUSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265784AbUGZUSo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 16:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265777AbUGZUSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 16:18:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:10918 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265872AbUGZTi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 15:38:29 -0400
Date: Mon, 26 Jul 2004 12:37:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: kladit@t-online.de (Klaus Dittrich)
Cc: linux-kernel@vger.kernel.org, kladit@t-online.de
Subject: Re: dentry cache leak? Re: rsync out of memory 2.6.8-rc2
Message-Id: <20040726123702.222ae654.akpm@osdl.org>
In-Reply-To: <20040726150615.GA1119@xeon2.local.here>
References: <20040726150615.GA1119@xeon2.local.here>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kladit@t-online.de (Klaus Dittrich) wrote:
>
> >Can you narrow the onset of the problem down to any particular kernel
>  >snapshot?
> 
>  Did it and here is the answer.
> 
>  kernel-2.6.7 and bk's up to 2.6.7-bk7 survived a du -s,
>  kernels starting with 2.6.7-bk8 did not.

Dammit, -bk7 to -bk8 is a 1.8M diff.  Relevant changes include the switch
to the rcu callbacks (make them take an rcu_head* rather than a void*) and
the introduction of /proc/sys/vm/vfs_cache_pressure.

So the immediate question is: please check the contents of your
vfs_cache_pressure tunable.  It should be 100.  A setting of zero would
cause this behaviour.

> 
>  Compiler gcc-3.4.1 

It would be useful to try a different compiler version.

There's _something_ different in your setup.  If we can work out what this
factor is, it will lead us to the bug.

