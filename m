Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTKILja (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 06:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbTKILja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 06:39:30 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:56810 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262386AbTKILj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 06:39:29 -0500
Date: Sun, 9 Nov 2003 12:39:28 +0100
From: Jens Axboe <axboe@suse.de>
To: Guillaume Chazarain <guichaz@yahoo.fr>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cfq + io priorities
Message-ID: <20031109113928.GN2831@suse.de>
References: <SRLGXA875SP047EDQLEC055ZHDZX2V.3fae1da3@monpc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SRLGXA875SP047EDQLEC055ZHDZX2V.3fae1da3@monpc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 09 2003, Guillaume Chazarain wrote:
> > A process has an assigned io nice level, anywhere from 0 to 20. Both of
> 
> OK, I ask THE question : why not using the normal nice level, via
> current->static_prio ?
> This way, cdrecord would be RT even in IO, and nice -19 updatedb would have
> a minimal impact on the system.

I don't want to tie io prioritites to cpu priorities, that's a design
decision.

> > these end values are "special" - 0 means the process is only allowed to
> > do io if the disk is idle, and 20 means the process io is considered
> 
> So a process with ioprio == 0 can be forever starved. As it's not

Yes

> done this way for nice -19 tasks (unlike FreeBSD), wouldn't it be
> safer to give a very long deadline to ioprio == 0 requests ?

ioprio == 0 means idle IO. It follows from that that you can risk
infinite starvation if other io is happening. Otherwise it would not be
idle io :-)

CFQ doesn't assign request deadlines. That would be another way of
handling starvation.

> Thanks for making something I have been dreaming of for a long time :)

Me too :)

-- 
Jens Axboe

