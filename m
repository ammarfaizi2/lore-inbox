Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262484AbUJ0Pg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbUJ0Pg5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 11:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbUJ0Pg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 11:36:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5354 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262484AbUJ0Pf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 11:35:56 -0400
Date: Wed, 27 Oct 2004 16:29:00 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: jfannin1@columbus.rr.com
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       Mathieu Segaud <matt@minas-morgul.org>, agk@redhat.com,
       christophe@saout.de, linux-kernel@vger.kernel.org, bzolnier@gmail.com
Subject: Re: 2.6.9-mm1: LVM stopped working (dio-handle-eof.patch)
Message-ID: <20041027152900.GU16193@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	jfannin1@columbus.rr.com, Jens Axboe <axboe@suse.de>,
	Andrew Morton <akpm@osdl.org>,
	Mathieu Segaud <matt@minas-morgul.org>, christophe@saout.de,
	linux-kernel@vger.kernel.org, bzolnier@gmail.com
References: <1098731002.14877.3.camel@leto.cs.pocnet.net> <20041026123651.GA2987@zion.rivenstone.net> <20041026135955.GA9937@agk.surrey.redhat.com> <20041026213703.GA6174@rivenstone.net> <20041026151559.041088f1.akpm@osdl.org> <87hdogvku7.fsf@barad-dur.crans.org> <20041026222650.596eddd8.akpm@osdl.org> <20041027054741.GB15910@suse.de> <20041027064146.GG15910@suse.de> <20041027150333.GA2353@samarkand.rivenstone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041027150333.GA2353@samarkand.rivenstone.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 11:03:35AM -0400, Joseph Fannin wrote:
>     I made this change to 2.6.9-mm1 and it didn't.  vgchange still
> seems to be trying to read 2048 bytes, rather than 4096 (I may not
> know what I'm talking about, or even what I'm looking at, though).

LVM2 uses the (soft) device block size for both alignment and size.
If no blocksize is defined, it uses pagesize.

Even when it only needs to change a few consecutive bytes, it still 
has to read a complete aligned block, make the change, then write it 
back.

Alasdair
-- 
agk@redhat.com
