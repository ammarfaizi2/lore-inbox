Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269596AbUJLKdC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269596AbUJLKdC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 06:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269600AbUJLKdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 06:33:02 -0400
Received: from mail1.kontent.de ([81.88.34.36]:17038 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S269596AbUJLKc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 06:32:57 -0400
From: Oliver Neukum <oliver@neukum.org>
To: James Bruce <bruce@andrew.cmu.edu>
Subject: Re: [2.6.9-rc4] USB && mass-storage && disconnect broken semantics
Date: Tue, 12 Oct 2004 12:24:44 +0200
User-Agent: KMail/1.6.2
Cc: bert hubert <ahu@ds9a.nl>, Greg KH <greg@kroah.com>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20041011120701.GA824@outpost.ds9a.nl> <416B9436.3010902@andrew.cmu.edu>
In-Reply-To: <416B9436.3010902@andrew.cmu.edu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200410121224.44910.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> With *nix, most data only gets written at unmount, so the only way this 
> can "sanely" work is for mounts you haven't written to.  That case is of 

This is not a law of nature. You can mount sync as well. That, of course,
sucks in terms of performance and wear. A reasonable compromise
would be to do sync on close.
Supermount did this years ago.

> course not currently handled very well, but writing would be damn near 
> impossible to unmount well.  In order to keep the device consistent, the 
> only thing you can do is wait for the user to reinsert the device and 
> then clear your caches.  However they might have modified the storage in 

You cannot. That's giving mlock() to everybody.

[..]
> Automated mounting with special fixed names can already be done, this 
> has little to do with forced dismounting.  Use something like udev for 
> this part.

Exactly.

[..] 
> All I ever expect the kernel to eventually support is forced dismount of 
> devices that haven't been written to.  I think from there its up to

Devices break. You have to cope with devices going away suddenly.
You are not required to ensure data integrity in all cases, but the system
must not suffer. To allow that you must be able to get rid of the mounts
even if users do not cooperate. 

	Regards
		Oliver
