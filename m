Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVBVTD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVBVTD1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 14:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbVBVTCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 14:02:40 -0500
Received: from rain.plan9.de ([193.108.181.162]:56735 "EHLO rain.plan9.de")
	by vger.kernel.org with ESMTP id S261332AbVBVTB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 14:01:56 -0500
Date: Tue, 22 Feb 2005 20:01:49 +0100
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Alex Adriaanse <alex.adriaanse@gmail.com>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: Odd data corruption problem with LVM/ReiserFS
Message-ID: <20050222190149.GB9590@schmorp.de>
Mail-Followup-To: Andreas Steinmetz <ast@domdv.de>,
	Alex Adriaanse <alex.adriaanse@gmail.com>,
	linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
References: <93ca3067050220212518d94666@mail.gmail.com> <4219C811.5070906@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4219C811.5070906@domdv.de>
X-PGP: "1024D/DA743396 1999-01-26 Marc Alexander Lehmann <schmorp@schmorp.de>
       Key fingerprint = 475A FE9B D1D4 039E 01AC  C217 A1E8 0270 DA74 3396"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2005 at 12:37:53PM +0100, Andreas Steinmetz <ast@domdv.de> wrote:
> >Anyway, what do you guys think could be the problem?  Could it be that
> >the LVM / Device Mapper snapshot feature is solely responsible for
> >this corruption?  (I'm sure there's a reason it's marked
> >Experimental).
> 
> I don't think so - I changed from reiserfs to ext3 without changing the 
> underlying dm/raid5 and this seems to work properly.

I use both reiserfs and ext3 on lvm/dm on raid.

Both filesystems have issues when restoring from backup (i.e. very heavy
write activity).

I did report this to the linux kernel, and got as reply that there are
indeed races *somewhere*, but as of yet there is no fix.

The symptoms are _not_ I/O errors (but until I see logs I wouldn't believe
you that there are real I/O errors), but usually too-high block numbers.

A reboot fixes this for both ext3 and reiserfs (i.e. the error is gone).

You might want to explore this problem and decide for yourself if it's caused
by I/O errors (in which case you have a disk problem) or "just" filesystem
corruption.

-- 
                The choice of a
      -----==-     _GNU_
      ----==-- _       generation     Marc Lehmann
      ---==---(_)__  __ ____  __      pcg@goof.com
      --==---/ / _ \/ // /\ \/ /      http://schmorp.de/
      -=====/_/_//_/\_,_/ /_/\_\      XX11-RIPE
