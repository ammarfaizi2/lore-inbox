Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263793AbTLXS4W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 13:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbTLXS4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 13:56:22 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:7602 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S263793AbTLXS4V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 13:56:21 -0500
Date: Wed, 24 Dec 2003 10:56:06 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Jim Lawson <jim+linux-kernel@jimlawson.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0, SiI3112, md raid1 problem: bio too big device (128 > 15)
Message-ID: <20031224185606.GZ6438@matchmail.com>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	Jim Lawson <jim+linux-kernel@jimlawson.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0312232253140.7841@infocalypse.jimlawson.org> <16361.28564.275984.580859@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16361.28564.275984.580859@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 24, 2003 at 09:51:00PM +1100, Neil Brown wrote:
> This is a raid1 bug.
> Some block devices have limits on the sizes of io requests that they
> can handle, and advertise these limits with ->max_sectors and
> ->merge_bvec_fn (and a few others).  Any device MUST be able to accept
> a single page IO at any offset.

So, how can I determine the max io request support by my underlying devices
from userspace?

> When raid1 does a 'resync' it does all IO in 64K requests, ignoring
> the restrictions.
> Getting raid1 resync to handle the restrictions is non-trivial (I have
> code, but it is still buggy).

Do you have patches posted anywhere?

> A simple interim fix is to replace
> 
> #define RESYNC_BLOCK_SIZE (64*1024)
> 
> with
> 
> #define RESYNC_BLOCK_SIZE PAGE_SIZE

Then by all means, let's get this into -mm.

Then once the new resync code is ready it can be merged.
