Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264142AbTLYA1e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 19:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264144AbTLYA1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 19:27:34 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:47022 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S264142AbTLYA1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 19:27:33 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Mike Fedyk <mfedyk@matchmail.com>
Date: Thu, 25 Dec 2003 11:27:19 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16362.12007.546335.478903@notabene.cse.unsw.edu.au>
Cc: Jim Lawson <jim+linux-kernel@jimlawson.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0, SiI3112, md raid1 problem: bio too big device (128 > 15)
In-Reply-To: message from Mike Fedyk on Wednesday December 24
References: <Pine.LNX.4.58.0312232253140.7841@infocalypse.jimlawson.org>
	<16361.28564.275984.580859@notabene.cse.unsw.edu.au>
	<20031224185606.GZ6438@matchmail.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday December 24, mfedyk@matchmail.com wrote:
> On Wed, Dec 24, 2003 at 09:51:00PM +1100, Neil Brown wrote:
> > This is a raid1 bug.
> > Some block devices have limits on the sizes of io requests that they
> > can handle, and advertise these limits with ->max_sectors and
> > ->merge_bvec_fn (and a few others).  Any device MUST be able to accept
> > a single page IO at any offset.
> 
> So, how can I determine the max io request support by my underlying devices
> from userspace?
> 
Not that I am aware of.

> > When raid1 does a 'resync' it does all IO in 64K requests, ignoring
> > the restrictions.
> > Getting raid1 resync to handle the restrictions is non-trivial (I have
> > code, but it is still buggy).
> 
> Do you have patches posted anywhere?
> 
Not as yet, and as I am on leave, I'm not likely to do much for a
while.

> > A simple interim fix is to replace
> > 
> > #define RESYNC_BLOCK_SIZE (64*1024)
> > 
> > with
> > 
> > #define RESYNC_BLOCK_SIZE PAGE_SIZE
> 
> Then by all means, let's get this into -mm.

Andrew Morton has it so it should be in the next -mm or -pre or
whatever he will call things.

NeilBrown
