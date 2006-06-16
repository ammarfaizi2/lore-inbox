Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbWFPGCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWFPGCp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 02:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbWFPGCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 02:02:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:5311 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751051AbWFPGCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 02:02:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b1MEBMWsy2j8Nak7iuITEZF57JPLJRSlLHTs5xt06/hZ8C0KM6Ds1UBioegswEo7XWWcKm5MvQP5xdbo08f+pfFpeqlogdeButkx2XXhZLbzMCz40K5jha3VGLEeIl1jf6qnHo8xmarJ2NMao69dzU1e32prSQjg2iUgFMKrsxg=
Message-ID: <bda6d13a0606152302v6598ce84sf4c7066705c3284f@mail.gmail.com>
Date: Thu, 15 Jun 2006 23:02:43 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: klibc
In-Reply-To: <e6d15e$j4l$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060604135011.decdc7c9.akpm@osdl.org>
	 <bda6d13a0606091528h4e85265du8651818c73827b7d@mail.gmail.com>
	 <e6ctsb$hij$1@terminus.zytor.com>
	 <bda6d13a0606091613h3334facbrcb86dbb2de01b412@mail.gmail.com>
	 <e6d15e$j4l$1@terminus.zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've come to the conclusion that there is no good way to return to the
initramfs at all
after init moves to the real root device. What I have found is that the only way
is for another process to keep a cwd or open file handle on the initramfs which
plays very badly with killall.

Anybody got a way to make a user process other than init involunerable
to kill -9? <g>

It would be dirt-simple if I could mount --rbind / /root/initrd where
/ is the initramfs and /root is a mounted filesystem, but that creates
cycles and so breaks other things.

Oh, and mount / followed by ls / returns the contents of the initramfs. Weird.
umount -l / has the exteremely bizarre effect of leaving the process stranded in
/ unless it currently has pwd or open directory handle elsewhere.

Anybody want a patch that dumps the executor of umount / in the
initramfs, then does
a lazy unmount? That, however, carries risks of its own so might not
be the best move.
