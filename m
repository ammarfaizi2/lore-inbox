Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264363AbUBRKyp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 05:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264364AbUBRKyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 05:54:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:11203 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264363AbUBRKyn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 05:54:43 -0500
Date: Wed, 18 Feb 2004 02:55:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm1
Message-Id: <20040218025549.4e7c56a1.akpm@osdl.org>
In-Reply-To: <p73wu6k653f.fsf@verdi.suse.de>
References: <20040217232130.61667965.akpm@osdl.org.suse.lists.linux.kernel>
	<p73wu6k653f.fsf@verdi.suse.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3-mm1/
> > 
> > - Added the dm-crypt driver: a crypto layer for device-mapper.
> > 
> >   People need to test and use this please.  There is documentation at
> >   http://www.saout.de/misc/dm-crypt/.
> > 
> >   We should get this tested and merged up.  We can then remove the nasty
> >   bio remapping code from the loop driver.  This will remove the current
> >   ordering guarantees which the loop driver provides for journalled
> >   filesystems.  ie: ext3 on cryptoloop will no longer be crash-proof.
> > 
> >   After that we should remove cryptoloop altogether.
> > 
> >   It's a bit late but cyptoloop hasn't been there for long anyway and it
> >   doesn't even work right with highmem systems (that part is fixed in -mm).
> 
> Is it guaranteed that this thing will be disk format compatible to cryptoloop? 
> (mainly in IVs and crypto algorithms)

Allegedly.  Of course, doing this will simply retain crypto-loop's security
weaknesses.

> While 2.3 and 2.4 have broken the on disk format of crypto loop several
> times (each time to a new "improved and ultimately perfect format")
> I don't think that's acceptable for a mature OS anymore.

Well I guess people are free to do that sort of thing with out-of-kernel
patches.

One question which needs to be adressed is whether dm-crypt adequately
addresses crypto-loop's security weaknesses, and if so, how one should set
it up to do so.

