Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263052AbTHVFZO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 01:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbTHVFZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 01:25:14 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:3282 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S263052AbTHVFZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 01:25:08 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Mike Fedyk <mfedyk@matchmail.com>
Date: Fri, 22 Aug 2003 15:24:46 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16197.43294.828878.586018@gargle.gargle.HOWL>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: md: bug in file raid5.c, line 540 was: Re: Linux 2.4.22-rc1
In-Reply-To: message from Mike Fedyk on Tuesday August 19
References: <Pine.LNX.4.44.0308051543130.12501-100000@logos.cnet>
	<20030819202629.GA4083@matchmail.com>
	<20030819210913.GC4083@matchmail.com>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday August 19, mfedyk@matchmail.com wrote:
> On Tue, Aug 19, 2003 at 01:26:29PM -0700, Mike Fedyk wrote:
> > Details in dmesg output...
> > 
> 
> This didn't make it to the list because it was too big.
> 
> compressing dmesg output, and here's an excerpt:
> 
> At this point md0 had:
> 
> md0 : active raid5 hda3[3] hdg3[1] hde3[0]
>       319388032 blocks level 5, 64k chunk, algorithm 0 [3/3] [UU_]
> 
> Aug 18 18:29:29 srv-lr2600 kernel: md: trying to hot-add hda3 to md0 ... 
> Aug 18 18:29:42 srv-lr2600 kernel: md: trying to hot-add hde3 to md0 ... 
> Aug 18 18:29:44 srv-lr2600 kernel: md: trying to hot-add hdg3 to md0 ... 
> Aug 18 18:36:25 srv-lr2600 kernel: md: trying to remove hda3 from md0 ... 
> 
> I thought I did a fail before the remove...
> 
> Aug 18 18:36:25 srv-lr2600 kernel: md: cannot remove active disk hda3 from md0 ... 
> Aug 18 18:36:34 srv-lr2600 kernel: md: bug in file raid5.c, line 540
> Aug 18 18:36:34 srv-lr2600 kernel: 
> 
> But why am I getting a bug message?

This bug could happen if you try to fail a device that is not active.
i.e. you do
    "mdadm -f /dev/md0 /dev/hda3"
 or "raidsetfaulty /dev/md0 /dev/hda3" 
when /dev/hda3 is an idle spare or a failed drive that has been
replaced by a spare.
The BUG call can just be removed from that line.

NeilBRown
