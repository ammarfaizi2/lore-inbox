Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWBLINM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWBLINM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 03:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWBLINM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 03:13:12 -0500
Received: from smtpout.mac.com ([17.250.248.71]:23769 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932325AbWBLINM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 03:13:12 -0500
In-Reply-To: <20060212075037.GA11550@mellanox.co.il>
References: <1139689341370-68b63fa9b8e76d91@cisco.com> <20060211140209.57af1b16.akpm@osdl.org> <ada8xsh49ll.fsf@cisco.com> <20060212075037.GA11550@mellanox.co.il>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BF4A90F5-149D-4627-A350-48CC4D214C28@mac.com>
Cc: Roland Dreier <rdreier@cisco.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [openib-general] Re: [git patch review 1/4] IPoIB: Don't start send-only joins while multicast thread is stopped
Date: Sun, 12 Feb 2006 03:13:02 -0500
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 12, 2006, at 02:50, Michael S. Tsirkin wrote:
> Basically, its as Andrew said: the lock around clear_bit is there  
> to ensure that ipoib_mcast_send isnt running already when we stop  
> the thread.  Thats why test_bit has to be inside the lock, too.

Looks like you guys could use nonatomic versions to improve bus  
efficiency slightly, but they appear to be relying on the fact that  
when the function calling set_bit() returns, the multicast thread  
will be guaranteed to be finished and never run again.  The set_bit()  
can only happen when the thread is not doing work (due to the lock),  
and since the thread firsts checks the bit before doing any work, it  
provides more guarantees than just the atomics would.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/E/U d- s++: a18 C++++>$ ULBX*++++(+++)>$ P++++(+++)>$ L++++ 
(+++)>$ !E- W+++(++) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+ PGP 
+ t+(+++) 5 X R? !tv-(--) b++++(++) DI+(++) D+++ G e>++++$ h*(+)>++$ r 
%(--)  !y?-(--)
------END GEEK CODE BLOCK------



