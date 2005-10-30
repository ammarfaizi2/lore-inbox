Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbVJ3VSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbVJ3VSW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 16:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbVJ3VSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 16:18:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:14466 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932073AbVJ3VSV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 16:18:21 -0500
From: Neil Brown <neilb@suse.de>
To: Daniele Orlandi <daniele@orlandi.com>
Date: Mon, 31 Oct 2005 08:18:12 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17253.14484.653996.225212@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: An idea on devfs vs. udev
In-Reply-To: message from Daniele Orlandi on Sunday October 30
References: <200510301907.11860.daniele@orlandi.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday October 30, daniele@orlandi.com wrote:
> 
> So, why cannot we substitute the "dev" file within /sys with the actual device 
> file?

I'd just like to say that I am 100% in favour of this idea.

The argument against it seems to be something that I have never
managed to understand about "policy not belonging in the kernel".
Now I agree that the kernel should avoid implementing policy, but I
fail to see how that relates to the current issue.

In fact, the way I see it, the current practice clearly violates the
"avoid policy" policy.

The kernel needs to export major/minor information through the
file system.  The "obvious" mechanism for doing this is through a
device special file.
But instead, a text file with %d:%d is used.  Why?  I presume to stop
people from just opening /sys/.../dev.  Stopping people from doing
such a thing is clearly implementing a "Thou shall not" policy.

But then to make matters worse, there is this "sample.sh" file.  UGH!
It's a bit of shell code exported by the kernel.
   #!/bin/sh
   mknod /dev/hda  b 3 0

This contortion would be totally unnecessary if 'dev' were an honest
device special file.  Then instead of 
   sh $sysfspath/sample.sh
you could
   cp -R $sysfspath/dev /dev/`basename $sysfspath`

Notes:
  - obviously a different name would have to be chosen for back
    compatibility (rdev?).
  - I would *not* be in favour of then allowing chown/chmod.  These 
    special files should stay root/root/0600.

NeilBrown



