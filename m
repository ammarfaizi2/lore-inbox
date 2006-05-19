Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWESMfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWESMfv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 08:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWESMfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 08:35:51 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:56986 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S932304AbWESMfv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 08:35:51 -0400
Message-ID: <446DBB31.6010101@bull.net>
Date: Fri, 19 May 2006 14:33:53 +0200
From: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en, fr, hu
MIME-Version: 1.0
To: Jan Kara <jack@suse.cz>
Cc: sct@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Change ll_rw_block() calls in JBD
References: <446C2F89.5020300@bull.net> <20060518134533.GA20159@atrey.karlin.mff.cuni.cz> <446C8EB1.3090905@bull.net> <20060519013023.GA11424@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20060519013023.GA11424@atrey.karlin.mff.cuni.cz>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 19/05/2006 14:37:12,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 19/05/2006 14:39:01,
	Serialize complete at 19/05/2006 14:39:01
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara wrote:

>>>+			if (!buffer_jbd(bh) || jh->b_jlist != BJ_SyncData) {
>>
>>Who (else) can take away the journal head, remove our "jh" from the
>>synch. data list?
> 
>   For two of the above comments: Under memory pressure data buffers can
> be written out earlier and then released by __journal_try_to_free_buffer()
> as they are not dirty any more. The above checks protect us against this.

Assume "bh" has been set free in the mean time.
Assume it is now used for another transaction (maybe for another file system).

The first part of the test should verify not only if "bh" is used for _any_
journal head but if it is exactly for our current one:

	if (buffer_jbd(bh) != jh || ...

Thanks,

Zoltan


