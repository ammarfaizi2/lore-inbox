Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262721AbVCWCqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbVCWCqd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 21:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbVCWCqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 21:46:32 -0500
Received: from fire.osdl.org ([65.172.181.4]:18620 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262718AbVCWCpM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 21:45:12 -0500
Date: Tue, 22 Mar 2005 18:44:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Invalidating dentries
Message-Id: <20050322184452.2408be4b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0503211626180.20464@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0503211626180.20464@yvahk01.tjqt.qr>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
>
> how can I invalidate all buffered/cached dentries so that ls -l /somefolder 
>  will definitely go read the harddisk?

Patch the kernel?

There's no way of doing this apart from unmount/mount, or by forcing a ton
of memory pressure and hoping that the dentries get reclaimed.

A quick way of doing it would be to add a new mount option to the
filesystem and call shrink_dcache_sb() from there.  do `mount -o
remount,shrink_dcache'.

