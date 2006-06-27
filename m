Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932765AbWF0KZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932765AbWF0KZF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 06:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932884AbWF0KZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 06:25:04 -0400
Received: from aa002msr.fastwebnet.it ([85.18.95.65]:19598 "EHLO
	aa002msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932765AbWF0KZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 06:25:02 -0400
Date: Tue, 27 Jun 2006 12:24:57 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ck@vds.kolivas.org
Subject: Re: 2.6.17-ck1: fcache problem...
Message-ID: <20060627122457.2cabc4d7@localhost>
In-Reply-To: <20060627095443.GQ22071@suse.de>
References: <20060625093534.1700e8b6@localhost>
	<20060625102837.GC20702@suse.de>
	<20060625152325.605faf1f@localhost>
	<20060625174358.GA21513@suse.de>
	<20060627112105.0b15bfa1@localhost>
	<20060627095443.GQ22071@suse.de>
X-Mailer: Sylpheed-Claws 2.3.0 (GTK+ 2.8.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2006 11:54:44 +0200
Jens Axboe <axboe@suse.de> wrote:

> > So the problem is that "fcache_close_dev()" have zero chances to run ;)
> 
> Hmm, you seem to be using an older fcache version. I'll test this and
> post an updated patch if it doesn't work with the newer version.

I'm using the one that comes with "2.6.17-ck1" as the subject suggest :)

Anyway I've just seen this in your git tree:


@@ -2222,6 +2283,7 @@ static int ext3_remount (struct super_bl

[CUT]

        ext3_init_journal_params(sb, sbi->s_journal);

+       if (fcache_devnum) {
+               ext3_close_fcache(sb);
+               ext3_open_fcache(sb, fcache_devnum);
+       }


So I suppose that it's already fixed.

:)

-- 
	Paolo Ornati
	Linux 2.6.17-ck1 on x86_64
