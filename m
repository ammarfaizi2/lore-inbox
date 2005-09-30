Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbVI3WQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbVI3WQw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 18:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbVI3WQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 18:16:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:173 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932293AbVI3WQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 18:16:51 -0400
Date: Fri, 30 Sep 2005 15:16:28 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Harald Welte <laforge@gnumonks.org>
cc: Chris Wright <chrisw@osdl.org>, Sergey Vlasov <vsu@altlinux.ru>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       security@linux.kernel.org, vendor-sec@lst.de
Subject: Re: [linux-usb-devel] Re: [Security] [vendor-sec] [BUG/PATCH/RFC]
 Oops while completing async USB via usbdevio
In-Reply-To: <20050930220808.GE4168@sunbeam.de.gnumonks.org>
Message-ID: <Pine.LNX.4.64.0509301514190.3378@g5.osdl.org>
References: <20050925151330.GL731@sunbeam.de.gnumonks.org>
 <Pine.LNX.4.58.0509270746200.3308@g5.osdl.org> <20050927160029.GA20466@master.mivlgu.local>
 <Pine.LNX.4.58.0509270904140.3308@g5.osdl.org> <20050927165206.GB20466@master.mivlgu.local>
 <Pine.LNX.4.58.0509270959380.3308@g5.osdl.org> <20050930104749.GN4168@sunbeam.de.gnumonks.org>
 <Pine.LNX.4.64.0509300752530.3378@g5.osdl.org> <20050930184433.GF16352@shell0.pdx.osdl.net>
 <Pine.LNX.4.64.0509301225190.3378@g5.osdl.org> <20050930220808.GE4168@sunbeam.de.gnumonks.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 1 Oct 2005, Harald Welte wrote:
> 
> please find the patch below.  It compiles, but I didn't yet have the
> time to verify it makes the bug disappear and the async urb delivery is
> still working.

No, you can't re-use "check_kill_permissions()" like this, even though I 
do understand the appeal.

The generic kill permissions check things like the current session, and 
whether the caller has extra permissions, neither of which is sensible in 
the context of "group_send_sig_info_as_uid()". So you do need to write out 
the uid/euid checks separately, and have a different function for this 
thing.

		Linus
