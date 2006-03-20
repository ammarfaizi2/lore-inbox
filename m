Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbWCTQlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWCTQlB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbWCTQlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:41:01 -0500
Received: from pproxy.gmail.com ([64.233.166.182]:30435 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964843AbWCTQk7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 11:40:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=JuQncCS+TUJKYv820CTeJefITNUBBOlY8ziLh6CvmB+I2LslR+uyOlBwKMAYMMvVSeLxoPe+anFAmuLZFI/4AKeVrVJzWXSbNgAhTPlzzbfWguzh9yW2qIjnhb+s1gid3LXeSHu67SD4qxY6KVHnWQ7AfR8NAHwc2LzpG7fYAkg=
Message-ID: <441EDB0B.3050805@gmail.com>
Date: Tue, 21 Mar 2006 01:40:43 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Mail/News 1.5 (X11/20060228)
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Dave Miller <davem@redhat.com>, axboe@suse.de, bzolnier@gmail.com,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org, mattjreimer@gmail.com,
       rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug
References: <11371658562541-git-send-email-htejun@gmail.com>	 <1137167419.3365.5.camel@mulgrave>	 <20060113182035.GC25849@flint.arm.linux.org.uk>	 <1137177324.3365.67.camel@mulgrave>	 <20060113190613.GD25849@flint.arm.linux.org.uk>	 <20060222082732.GA24320@htj.dyndns.org>	 <1142871172.3283.17.camel@mulgrave.il.steeleye.com>	 <441ED79B.4000009@gmail.com> <1142872412.3283.24.camel@mulgrave.il.steeleye.com>
In-Reply-To: <1142872412.3283.24.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Tue, 2006-03-21 at 01:26 +0900, Tejun Heo wrote:
>> Okay by me, although I think we also need to fix flush_dcache_page()
>> such that it doesn't abruptly enable irq after itself. That's just
>> broken. I'll make some kmap wrappers such that callers don't have to try
>> too hard to get synchronization correct.
> 
> That would involve fixing all of the flush_dcache_mmap_lock/unlock()
> wrappers to take an extra flags variable (which would be unused on null
> implementations) ... it can be done, but it's a lot of work; I think,
> since all the current users aren't in atomic context, that we shouldn't
> bother unless anyone can see a real need to call it from atomic context.
> 

Hmmm... if fixing is too much work, how about adding WARN_ON() or one of
its friends if we enter flush_dcache_page() from atomic context?

-- 
tejun
