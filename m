Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266864AbUITRlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266864AbUITRlp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 13:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266878AbUITRlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 13:41:45 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:3592 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S266864AbUITRln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 13:41:43 -0400
Date: Mon, 20 Sep 2004 12:41:30 -0500
From: Terence Ripperda <tripperda@nvidia.com>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm1
Message-ID: <20040920174130.GA2142@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
References: <20040916024020.0c88586d.akpm@osdl.org> <200409161345.56131.norberto+linux-kernel@bensa.ath.cx> <1095354962.2698.22.camel@laptop.fenrus.com> <200409161428.10717.norberto+linux-kernel@bensa.ath.cx> <20040916173022.GA6793@devserv.devel.redhat.com> <200409171929.i8HJTq92024659@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409171929.i8HJTq92024659@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.6.7 
X-OriginalArrivalTime: 20 Sep 2004 17:41:33.0223 (UTC) FILETIME=[11B4CB70:01C49F39]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 03:29:51PM -0400, Valdis.Kletnieks@vt.edu wrote:
> I admit not knowing the memory manager or the NVidia well enough to know what
> they *should* be doing instead.....

this is some ugly code. we're doing a lookup on a physical address to
see if this is memory we previously allocated and returning a kernel
pointer to the page.

the particular snippet in question (that uses MAXMEM) is an ugly attempt
to verify the address is a real physical address, before using __va()
on something like an i/o region. A better approach than comparing
MAXMEM would probably be to convert the address to a mapnr and compare
to max_mapnr.

I'll clean up this code and post a patch in the next couple of days.
in the meantime, the current patches out there should be good.

Thanks,
Terence

