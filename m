Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262037AbVATNih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbVATNih (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 08:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVATNih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 08:38:37 -0500
Received: from ns1.coraid.com ([65.14.39.133]:9313 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S262037AbVATNie (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 08:38:34 -0500
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AOE: fix up the block device registration so that it
 actually works now.
References: <20050119000935.GA22454@kroah.com> <87llap5x69.fsf@coraid.com>
	<20050119215620.GF4151@kroah.com>
From: Ed L Cashin <ecashin@coraid.com>
Date: Thu, 20 Jan 2005 08:35:06 -0500
Message-ID: <87sm4wkyut.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> On Wed, Jan 19, 2005 at 09:08:14AM -0500, Ed L Cashin wrote:
>> > diff -Nru a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
>> > --- a/drivers/block/aoe/aoeblk.c	2005-01-18 16:06:57 -08:00
>> > +++ b/drivers/block/aoe/aoeblk.c	2005-01-18 16:06:57 -08:00
>> > @@ -249,6 +249,7 @@
>> >  aoeblk_exit(void)
>> >  {
>> >  	kmem_cache_destroy(buf_pool_cache);
>> > +	unregister_blkdev(AOE_MAJOR, DEVICE_NAME);
>> >  }
>> 
>> The unregister_blkdev should already be in aoemain.c:aoe_exit.
>
> Why?  You do a register_blockdev() in this file, so if something fails,
> you should also unregister here.  

No, the register_blkdev that you see in aoeblk.c is the artifact of a
snafu I made in patch submission.  I submitted a small patch yesterday
(ID below) that corrects the snafu and makes block-2.6 the same as the
driver I have.

  Message-ID: <87mzv5m9pl.fsf@coraid.com>

In the current aoe driver, register_blkdev is only in
aoemain.c:aoe_init, and that register_blkdev is the last step in the
initialization sequence.  If register_blkdev fails, then I don't
unregister_blkdev, because presumably I shouldn't undo something that
wasn't done.

> The big problem is you were trying to
> register the same major twice :(

That's because two snippets of my recent fixes got orphaned (my fault)
instead of getting included in the submitted patches, so instead of my
patches moving register_blkdev it got duplicated.  The patch I sent
yesterday corrects the problem and brings block-2.6 back into
accordance with what I've got.  Sorry for the confusion.

-- 
  Ed L Cashin <ecashin@coraid.com>

