Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWBPBO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWBPBO4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 20:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWBPBO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 20:14:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45283 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932213AbWBPBOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 20:14:55 -0500
Date: Wed, 15 Feb 2006 17:13:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: cmm@us.ibm.com
Cc: helge.hafting@aitel.hist.no, linux-kernel@vger.kernel.org
Subject: Re: fsck: i_blocks is xxx should be yyy on ext3
Message-Id: <20060215171343.6b540516.akpm@osdl.org>
In-Reply-To: <1140050679.20936.14.camel@dyn9047017067.beaverton.ibm.com>
References: <43EA079A.4010108@aitel.hist.no>
	<20060208225359.426573cf.akpm@osdl.org>
	<1140050679.20936.14.camel@dyn9047017067.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
> On Wed, 2006-02-08 at 22:53 -0800, Andrew Morton wrote:
> > Helge Hafting <helge.hafting@aitel.hist.no> wrote:
> > >
> > >  Today I rebooted into 2.6.16-rc2-mm1.  Fsck checked a "clean" ext3 fs,
> > >  because it was many mounts since the last time.
> > > 
> > >  I have seen that many times, but this time I got a lot of
> > >  "i_blocks is xxx, should be yyy fix?"
> > > 
> > >  In all cases, the blocks were fixed to a lower number.
> > 
> > Yes, thanks.  It's due to the ext3_getblocks() patches in -mm.  I can't
> > think of any actual harm which it'll cause.
> > 
> > To reproduce:
> > 
> > mkfs
> > mount
> > dbench 32
> > <wait 20 seconds>
> > killall dbench
> > umount
> > fsck
> > -
> 
> Sorry about the late response.  I failed to reproduce the problem with
> above instructions. I am running 2.6.16-rc2-mm1 kernel, played dbench
> 32 ,64 and 128, and tried both 8 cpu and 1 cpu, still no luck at last.

It happens - I tried it just then.  It only failed one time in five
attempts, and that with just a single inode.


> I am using e2fsck version 1.35 though. What versions you are using?
> 

e2fsprogs-1.34-1

e2fsck -fn /dev/hda5
