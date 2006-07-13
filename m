Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWGMP6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWGMP6y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 11:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWGMP6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 11:58:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:40675 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932196AbWGMP6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 11:58:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=sKdjNQeLsVErpDJa8LyoGBJvZh0JPtpXcpQr9u2Y63+4Xm7IjhnilqBiYSGb2J2wuwu6TijyGYf2N36phde0xUfUUykXkMgj1q51feQnmMs9X4AJzv0CjJCWDhDGz/7ULqhaZnHAyu3o9/W6AeBEZ9zudGcYo9kIw4xtxq3ZdcI=
Message-ID: <84144f020607130858l60792ac0t5f9cdabf1902339c@mail.gmail.com>
Date: Thu, 13 Jul 2006 18:58:52 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [patch] lockdep: annotate mm/slab.c
Cc: "Andrew Morton" <akpm@osdl.org>, sekharan@us.ibm.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, nagar@watson.ibm.com, balbir@in.ibm.com,
       arjan@infradead.org
In-Reply-To: <20060713124603.GB18936@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1152763195.11343.16.camel@linuxchandra>
	 <20060713071221.GA31349@elte.hu>
	 <20060713002803.cd206d91.akpm@osdl.org> <20060713072635.GA907@elte.hu>
	 <20060713004445.cf7d1d96.akpm@osdl.org>
	 <20060713124603.GB18936@elte.hu>
X-Google-Sender-Auth: a7c8bb2564db44e3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/06, Ingo Molnar <mingo@elte.hu> wrote:
> mm/slab.c uses nested locking when dealing with 'off-slab'
> caches, in that case it allocates the slab header from the
> (on-slab) kmalloc caches. Teach the lock validator about
> this by putting all on-slab caches into a separate class.

What's "nested lock" btw? If I understood from the other patch, you're
talking about ac->lock. Surely you can't take the same lock twice but
it's perfectly legal to take lock as long as the ac instance is
different...
