Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280863AbRKGRI1>; Wed, 7 Nov 2001 12:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280864AbRKGRIS>; Wed, 7 Nov 2001 12:08:18 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:10511 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S280863AbRKGRIC>; Wed, 7 Nov 2001 12:08:02 -0500
Date: Wed, 7 Nov 2001 00:31:31 +0000
From: Stephen Tweedie <sct@redhat.com>
To: "Steven N. Hirsch" <shirsch@adelphia.net>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: ext3-0.9.15 against linux-2.4.14
Message-ID: <20011107003131.D7290@redhat.com>
In-Reply-To: <3BE7AB6C.97749631@zip.com.au> <Pine.LNX.4.33.0111061305540.8366-100000@atx.fast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0111061305540.8366-100000@atx.fast.net>; from shirsch@adelphia.net on Tue, Nov 06, 2001 at 01:09:42PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 06, 2001 at 01:09:42PM -0500, Steven N. Hirsch wrote:

> >   This is an incredibly obscure and hard-to-hit situation.  The testcase
> >   which used to trigger it can no longer do so.  So if anyone sees the
> >   message "try_to_swap_out: page has buffers!", please shout out.
 
> I have been getting thousands of these when the system was under heavy 
> load, but didn't realize it was from the ext3 code!  I'm using Linus's 
> 2.4.14-pre7 + ext3 patch from Neil Brown's site (the latter is identified 
> as "ZeroNineFourteen".)  Would you like me to upgrade kernel and patch?

Andrew, the code

	if (page->buffers) {
		/*
		 * Anonymous buffercache page left behind by
		 * truncate.
		 */
		printk(__FUNCTION__ ": page has buffers!\n");
		goto preserve;
	}

is going to end up preserving the pte forever and shouting to syslog
every time the VM walks over the pte in question.  I'd be just as
happy dropping these ptes on the floor when we find them, as they are
clearly of no use to anybody at this point.

Cheers,
 Stephen
