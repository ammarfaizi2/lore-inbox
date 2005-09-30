Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932580AbVI3SpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbVI3SpF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 14:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932587AbVI3SpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 14:45:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39915 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932580AbVI3SpD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 14:45:03 -0400
Date: Fri, 30 Sep 2005 11:44:33 -0700
From: Chris Wright <chrisw@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Harald Welte <laforge@gnumonks.org>, Sergey Vlasov <vsu@altlinux.ru>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       security@linux.kernel.org, vendor-sec@lst.de
Subject: Re: [linux-usb-devel] Re: [Security] [vendor-sec] [BUG/PATCH/RFC] Oops while completing async USB via usbdevio
Message-ID: <20050930184433.GF16352@shell0.pdx.osdl.net>
References: <20050925151330.GL731@sunbeam.de.gnumonks.org> <Pine.LNX.4.58.0509270746200.3308@g5.osdl.org> <20050927160029.GA20466@master.mivlgu.local> <Pine.LNX.4.58.0509270904140.3308@g5.osdl.org> <20050927165206.GB20466@master.mivlgu.local> <Pine.LNX.4.58.0509270959380.3308@g5.osdl.org> <20050930104749.GN4168@sunbeam.de.gnumonks.org> <Pine.LNX.4.64.0509300752530.3378@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0509300752530.3378@g5.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds (torvalds@osdl.org) wrote:
> Here's a totally untested patch. It's guaranteed not to do the "right 
> thing", simply because it doesn't _use_ the uid/euid information. But it's 
> in the right kind of direction.
> 
> If you change the "kill_proc_info()" into a "kill_proc_info_as_uid()" 
> call, and add that to kernel/signal.c (which is basically kill_proc_info() 
> except it uses the passed-in uid/euid for the "check_kill_permission()" 
> tests instead), it should be correct.
> 
> As-is, it won't work, because it will use a _random_ uid (whatever is the 
> currently running process) for the kill permission. So this really is just 
> a "use this as a template" kind of patch, DO NOT APPLY!

Sorry, I missed the thread up to this, but this looks fundamentally
broken.  The kill_proc_info_as_uid() idea is not sufficient because more
than uid/euid are needed for permission check.  There's capabilities and
security labels.  Is there a reason not to do normal async here?

thanks,
-chris
