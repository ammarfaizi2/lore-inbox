Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbVI0UIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbVI0UIE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 16:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbVI0UIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 16:08:04 -0400
Received: from [81.2.110.250] ([81.2.110.250]:37845 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750950AbVI0UID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 16:08:03 -0400
Subject: Re: PID reuse safety for userspace apps (Re: [linux-usb-devel] Re:
	[Security] [vendor-sec] [BUG/PATCH/RFC] Oops while completing async USB via
	usbdevio)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Solar Designer <solar@openwall.com>
Cc: Sergey Vlasov <vsu@altlinux.ru>, Linus Torvalds <torvalds@osdl.org>,
       vendor-sec@lst.de, linux-kernel@vger.kernel.org,
       security@linux.kernel.org
In-Reply-To: <20050927172048.GA3423@openwall.com>
References: <20050925151330.GL731@sunbeam.de.gnumonks.org>
	 <Pine.LNX.4.58.0509270746200.3308@g5.osdl.org>
	 <20050927160029.GA20466@master.mivlgu.local>
	 <Pine.LNX.4.58.0509270904140.3308@g5.osdl.org>
	 <20050927165206.GB20466@master.mivlgu.local>
	 <20050927172048.GA3423@openwall.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 27 Sep 2005 21:34:11 +0100
Message-Id: <1127853252.10674.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-09-27 at 21:20 +0400, Solar Designer wrote:
> The idea is to introduce a kernel call (it can be a prctl(2) setting,
> although my pseudo-code "defines" an entire syscall for simplicity)
> which would "lock" the invoking process' view of a given PID (while
> letting the PID get reused - so there's no added risk of DoS).  The
> original posting and subsequent thread can be seen here:


You can solve it just as well in kernel space without application
changes. Given a refcounted structure something like

	struct pidref {
		atomic_t ref;
		struct pidref *next, *prev;
		pid_t pid;
	};

and a hash you can take a pid reference whenever you hang onto a pid in
kernel space and check what should be a tiny if not empty hash in the
normal cases whenever you allocate a pid.

Alan

