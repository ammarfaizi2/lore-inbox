Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266727AbUG0XnC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266727AbUG0XnC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 19:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266732AbUG0XnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 19:43:02 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:28385 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S266727AbUG0Xmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 19:42:53 -0400
Message-ID: <4106E873.4060907@t-online.de>
Date: Wed, 28 Jul 2004 01:42:43 +0200
From: franz_pletz@t-online.de (Franz Pletz)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040703 Thunderbird/0.7.1 Mnenhy/0.6.0.103
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [BUG] fs/jbd/checkpoint.c:427: "blocknr != 0"
References: <41024AA1.5080401@t-online.de> <20040727161128.5939f8c0.akpm@osdl.org>
In-Reply-To: <20040727161128.5939f8c0.akpm@osdl.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: TnNDliZ1reR4h1xb4kTliKyyIiT7x6w77mIW9Wuj6K05e342q7FnYG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> I assume you have a wrecked journal, which is triggering this assert:
> 
> 	} else {
> 		first_tid = journal->j_transaction_sequence;
> 		blocknr = journal->j_head;
> 	}
> 	spin_unlock(&journal->j_list_lock);
> 	J_ASSERT(blocknr != 0);
> 
> 	/* If the oldest pinned transaction is at the tail of the log
>            already then there's not much we can do right now. */
> 
> e2fsck should have fixed this up when doing its journal replay.
> 
> You could probably get your data back by temporarily removing the journal:
> 
> 	tune2fs -O ^has_journal /dev/hda1
> 	e2fsck -f /dev/hda1
> 	tune2fs -j /dev/hda1
> 	e2fsck -f /dev/hda1

That solved the problem. Thank you very much.

I've read the tune2fs manpage in order to rebuild the journal in some 
way. But as I didn't want to destroy my data, I didn't dare to do 
something unless I am really sure what I'm doing.

I can't track that error down to a specific issue because the machine 
didn't lock up or something similar. I just shut it down and got that 
message when booting it the other day.


Franz
