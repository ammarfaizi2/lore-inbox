Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313644AbSDJTca>; Wed, 10 Apr 2002 15:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313649AbSDJTc3>; Wed, 10 Apr 2002 15:32:29 -0400
Received: from ns.suse.de ([213.95.15.193]:51726 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313644AbSDJTc2>;
	Wed, 10 Apr 2002 15:32:28 -0400
To: Hirokazu Takahashi <taka@valinux.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
In-Reply-To: <20020410.190550.83626375.taka@valinux.co.jp.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 10 Apr 2002 21:32:22 +0200
Message-ID: <p73662zpcxl.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hirokazu Takahashi <taka@valinux.co.jp> writes:

> But I wonder about sendpage. I guess HW IP checksum for outgoing
> pages might be miscalculated as VFS can update them anytime.
> New feature like COW pagecache should be added to VM and they 
> should be duplicated in this case.

For hw checksums it should not be a problem. NICs usually load
the packet into their packet fifo and compute the checksum on the fly
and then patch it into the header in the fifo before sending it out. A
NIC that would do slow PCI bus mastering twice just to compute the checksum
would be very dumb and I doubt they exist (if yes I bet it would be
faster to do software checksumming on them). When the NIC only
accesses the memory once there is no race window.

-Andi
