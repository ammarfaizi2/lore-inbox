Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751586AbWEaDDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbWEaDDM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 23:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbWEaDDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 23:03:12 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:6627 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751586AbWEaDDL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 23:03:11 -0400
Message-ID: <447D063A.9000401@in.ibm.com>
Date: Wed, 31 May 2006 08:28:02 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Googlebot/2.1 (+http://www.google.com/bot.html) 
MIME-Version: 1.0
To: David Chinner <dgc@sgi.com>
Cc: Jan Blunck <jblunck@suse.de>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Per-superblock unused dentry LRU lists V3
References: <20060526023536.GN8069029@melbourne.sgi.com> <4de7f8a60605300753j3b1e257u3849b72e7bc4d100@mail.gmail.com> <20060530150438.GB4377@hasse.suse.de> <20060531004022.GM8069029@melbourne.sgi.com>
In-Reply-To: <20060531004022.GM8069029@melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Chinner wrote:
> On Tue, May 30, 2006 at 05:04:38PM +0200, Jan Blunck wrote:
>>> David Chinner <dgc@sgi.com> wrote:
>>> -
>>> void shrink_dcache_sb(struct super_block * sb)
>>> {
> ....
>>> +       __shrink_dcache_sb(sb, &sb->s_dentry_lru_nr, 0);
>>> }
>> This doesn't prune all the dentries on the unused list. The parents of the
>> pruned dentries are added to the unused list. Therefore just shrinking
>> sb->s_dentry_lru_nr dentries isn't enough.
> 
> Yes, you are right, Jan. I'm surprised I didn't see problems due to this.
> The original patch got this right by shrinking in this case until the list
> was empty. I'll wrap this one in a while loop...
> 
> Cheers,
> 
> Dave.

Good catch,

I suspect the reason why the problem never showed up is because select_parent()
would take care of ensuring that the parent entries move to LRU list (this is
the case of regular umounts, which do not call shrink_dcache_sb() directly).

Maybe even the dentry_unused list should be per-superblock now.

-- 
        Regards,
	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
