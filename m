Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264604AbRFSSMV>; Tue, 19 Jun 2001 14:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264674AbRFSSML>; Tue, 19 Jun 2001 14:12:11 -0400
Received: from [209.191.64.160] ([209.191.64.160]:26121 "HELO linuxninja.org")
	by vger.kernel.org with SMTP id <S264604AbRFSSL5>;
	Tue, 19 Jun 2001 14:11:57 -0400
From: tpepper@vato.org
Date: Tue, 19 Jun 2001 11:11:36 -0700
To: linux-kernel@vger.kernel.org
Subject: b_dev vs. b_rdev confusion
Message-ID: <20010619111136.A25405@cb.vato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are probably dumb questions but I haven't been able to find
definitive answers...

Is there a set rule on when/where one should use a buffer head's b_dev
and when/where one should use b_rdev?

I'm been tracing through the kernel source quite a bit and it seems like
above ll_rw_blk.c's submit_bh() b_dev is being used.  Below there as the
request heads off into whichever block device b_rdev is used.  Is this
true?  Things read like the b_dev/b_rdev distinction was introduced to
facilitate block drivers intercepting and redirecting requests (lvm,
raid, multipathing, &tc.) and I'm trying to figure out if there's a
clean delineation of which is used where and if I can safely twiddle
b_rdev and pass the buffer head on without copying it.  (Are these what are
somtimes called "stacking drivers" here?)

All of the md code looks like it copies the buffer head, setting
b_dev=b_rdev="real device" in the new bh and leaving b_dev==b_rdev="logical
device" in the original bh.  I'm assuming they do this for a reason, but
it would be nice from a performance standpoint to just touch b_rdev and
b_end_io and be done.  Is there something I'm missing which necessitates the
copy?

And how do the inode->i_dev, i_rdev and i_bdev fit into this?  When are those
set and does anything get confused by i_rdev moving?

Thanks in advance for any suggestions/info...

Tim
