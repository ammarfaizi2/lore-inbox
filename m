Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267815AbUJCMKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267815AbUJCMKy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 08:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267850AbUJCMKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 08:10:54 -0400
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:9733 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S267815AbUJCMKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 08:10:52 -0400
Date: Sun, 3 Oct 2004 14:11:40 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: mmap() on cdrom files fails since 2.6.9-rc2-bk2
Message-Id: <20041003141140.319039de.khali@linux-fr.org>
In-Reply-To: <20041003111458.GA15390@elte.hu>
References: <2Jw9b-52b-13@gated-at.bofh.it>
	<20040929222619.5da3f207.khali@linux-fr.org>
	<20041001184431.4e0c6ba5.akpm@osdl.org>
	<20041002090125.302fff71.khali@linux-fr.org>
	<20041003111458.GA15390@elte.hu>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

> > old_mmap(NULL, 42, PROT_READ, MAP_SHARED, 3, 0) = -1 EPERM
> > (Operation not permitted)
> 
> could you try the patch below? mmap() done from !pt_gnu_stack binaries
> on noexec mounted filesystems indeed could fail due to the extra
> PROT_EXEC bit.

Indeed, all files on which mmap was failing were located on noexec'd
devices (although for the cdrom the noexec is not explicitely stated in
my /etc/fstab file). Your patch fixes my problem, mmap on these devices
is working again. Thanks!

Now I'm only curious as to why the problem only affected me. Since it
looks like noexec is implied on cdrom devices, the problem should have
affected everyone. Or are the "!pt_gnu_stack binaries" something rare? I
admit I have no idea what it refers to.

Thanks again.

-- 
Jean Delvare
http://khali.linux-fr.org/
