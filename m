Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265706AbUG1WVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265706AbUG1WVd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 18:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265521AbUG1WVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 18:21:33 -0400
Received: from mail5.tpgi.com.au ([203.12.160.101]:39398 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S265706AbUG1WV2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 18:21:28 -0400
Subject: Re: [PATCH] Add missing refrigerator support.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040728142534.3ed84b99.akpm@osdl.org>
References: <1090999347.8316.15.camel@laptop.cunninghams>
	 <20040728142534.3ed84b99.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1091052885.8867.5.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 29 Jul 2004 08:14:45 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-07-29 at 07:25, Andrew Morton wrote:
> Nigel Cunningham <ncunningham@linuxmail.org> wrote:
> >
> > +				if (current->flags & PF_FREEZE) {
> > +					refrigerator(PF_FREEZE);
> > +					continue;
> > +				}
> 
> This seems excessively verbose.  Why not do:
> 
> 	if (try_to_freeze())
> 		continue;
> 
> 
> /*
>  * Comment goes here
>  */
> static inline int try_to_freeze(void)
> {
> 	/* I think the compiler propagates likeliness to the inline's caller */
> 	if (unlikely(current->flags & PF_FREEZE)) {
> 		refrigerator(PF_FREEZE);
> 		return 1;
> 	}
> 	return 0;
> }

Probably because I haven't seen that macro before. Looks good. I'll make
use of it and add it to suspend2 too, so that whenever we get the merge
done, it doesn't disappear.

Regards.

Nigel

