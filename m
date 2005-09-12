Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbVILAgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbVILAgl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 20:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbVILAgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 20:36:41 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:23266 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S1751106AbVILAgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 20:36:40 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: jesper.juhl@gmail.com
Date: Mon, 12 Sep 2005 10:36:31 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17188.52623.351989.468493@cse.unsw.edu.au>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>, linux-kernel@vger.kernel.org
Subject: Re: read-from-all-disks support for RAID1?
In-Reply-To: message from Jesper Juhl on Monday September 12
References: <20050910123902.GA9461@xi.wantstofly.org>
	<17188.49961.268818.355923@cse.unsw.edu.au>
	<9a87484905091117222d318f4@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday September 12, jesper.juhl@gmail.com wrote:
> > No, I don't think so.  The overhead would be substantial, so people
> > would be very unlikely to use it.
> 
> There are situations where data integrity is far more important than speed.
> On AIX I usually use the Mirror Write Consistency and Write Verify
> options on my mirrored volumes that store data where integrity is more
> important than speed.
> I guess something like those options would also satisfy Lennert's
> needs, but I don't know if it's currently possible with the Linux LVM
> or elsewhere.
> 
> You can read a bit about the MWC and WV options in AIX at :
> http://publib.boulder.ibm.com/infocenter/pseries/index.jsp?topic=/com.ibm.aix.doc/aixbman/prftungd/diskperf2.htm

Thanks for the link.

If I understand the (fairly brief) descriptions correctly:
 Passive mirror-write-constancy has always been part of md/raid1
 Active mirror-write-constancy is equivalent to the new
   bitmap-write-intent support.
 WV  means read-after-write which we don't do, but might be useful.

 However, I'm not 100% certain that WV would really be useful.  Modern
 drives will almost certainly return a read-after-write request out of
 the drive's cache rather than going to the media.  We would need some
 way to tell the drive to ignore the cache for this read.  I suspect
 this is possible, but might not be trivial...
 
NeilBrown

 
