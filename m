Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751730AbWAKVFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbWAKVFz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 16:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737AbWAKVFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 16:05:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35794 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751729AbWAKVFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 16:05:55 -0500
Date: Wed, 11 Jan 2006 13:05:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: andrea@suse.de, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: smp race fix between invalidate_inode_pages* and do_no_page
Message-Id: <20060111130533.6f23685b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0601111949070.6448@goblin.wat.veritas.com>
References: <20051213193735.GE3092@opteron.random>
	<20051213130227.2efac51e.akpm@osdl.org>
	<20051213211441.GH3092@opteron.random>
	<20051216135147.GV5270@opteron.random>
	<20060110062425.GA15897@opteron.random>
	<43C484BF.2030602@yahoo.com.au>
	<20060111082359.GV15897@opteron.random>
	<20060111005134.3306b69a.akpm@osdl.org>
	<20060111090225.GY15897@opteron.random>
	<20060111010638.0eb0f783.akpm@osdl.org>
	<20060111091327.GZ15897@opteron.random>
	<Pine.LNX.4.61.0601111949070.6448@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
>  But I do not know what guarantees invalidate_inode_pages2 is supposed
>  to give.  As soon as you emerge from iipages2, its work could be undone:

yup.  It cannot become a hard guarantee unless we add some new really big
locks.

So it can be fooled by silly or poorly-designed apps.  What we're aiming
for here is predictable behaviour for sanely-implemented applications and
refusal to oops or to expose insecure data for poorly-designed ones or
exploits.
