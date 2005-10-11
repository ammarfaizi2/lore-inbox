Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbVJKXqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbVJKXqK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 19:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbVJKXqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 19:46:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7301 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751175AbVJKXqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 19:46:09 -0400
Date: Tue, 11 Oct 2005 16:44:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: Harald Welte <laforge@gnumonks.org>, Chris Wright <chrisw@osdl.org>,
       Sergey Vlasov <vsu@altlinux.ru>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, security@linux.kernel.org,
       vendor-sec@lst.de
Subject: Re: [vendor-sec] Re: [BUG/PATCH/RFC] Oops while completing async
 USB via usbdevio
In-Reply-To: <20051011231054.GA16315@kroah.com>
Message-ID: <Pine.LNX.4.64.0510111639500.14597@g5.osdl.org>
References: <Pine.LNX.4.58.0509270959380.3308@g5.osdl.org>
 <20050930104749.GN4168@sunbeam.de.gnumonks.org> <Pine.LNX.4.64.0509300752530.3378@g5.osdl.org>
 <20050930184433.GF16352@shell0.pdx.osdl.net> <Pine.LNX.4.64.0509301225190.3378@g5.osdl.org>
 <20050930220808.GE4168@sunbeam.de.gnumonks.org> <Pine.LNX.4.64.0509301514190.3378@g5.osdl.org>
 <20051010174429.GH5627@rama> <20051010180745.GT5856@shell0.pdx.osdl.net>
 <20051011094550.GI4290@rama> <20051011231054.GA16315@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 11 Oct 2005, Greg KH wrote:
> 
> Ugh, but it looks like Linus already committed your previous patch, with
> some changes by him.  Care to send a delta from what is currently in his
> tree (2.6.14-rc4 has it) and this patch?

I _think_ I fixed the disconnect thing too, although I think Harald's 
naming for the disconnect structure was cleaner, so I wouldn't mind having 
a (tested) patch on top of mine..

To some degree it would actually be nice to totally abstract that 
"pid+uid+euid" thing out as a structure of its own, and have the signal 
handling code fill it up (helper inline function in <linux/sched.h> or 
something), and have the users just use what to them is a totally opaque 
"signal sender token".

That would allow us to improve or change the validation of the thing 
later.

But for 2.6.14, the most important thing would be to verify that the oops 
cannot happen, and that you can't send signals to setuid programs by doing 
an "open(usb) + fork(keep it open in the child) + exec(suid in the 
parent)"

		Linus
