Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbULASHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbULASHz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 13:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbULASHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 13:07:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:15306 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261404AbULASHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 13:07:50 -0500
Date: Wed, 1 Dec 2004 10:07:49 -0800
From: Chris Wright <chrisw@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] inotify: a replacement for dnotify
Message-ID: <20041201100748.L14339@build.pdx.osdl.net>
References: <1101854070.4493.52.camel@betsy.boston.ximian.com> <20041130150345.K14339@build.pdx.osdl.net> <Pine.LNX.4.53.0412010937500.17975@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.53.0412010937500.17975@yvahk01.tjqt.qr>; from jengelh@linux01.gwdg.de on Wed, Dec 01, 2004 at 09:38:17AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jan Engelhardt (jengelh@linux01.gwdg.de) wrote:
> >> +	user = find_user(current->user->uid);
> >> +	if (!user)
> >> +		return -ENOMEM;
> >
> >Can just be:
> >
> >	get_uid(current->user);
> 
> What about current->euid?

Not relevant.  There's only one user_struct per task_struct.  The change
is to simply grab a ref on it and go rather than doing a full look up
in the uid hash as a method to get a refcount on it.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
