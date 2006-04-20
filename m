Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWDTQrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWDTQrx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 12:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWDTQrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 12:47:53 -0400
Received: from cantor2.suse.de ([195.135.220.15]:23519 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751095AbWDTQrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 12:47:52 -0400
Date: Thu, 20 Apr 2006 09:43:29 -0700
From: Tony Jones <tonyj@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       chrisw@sous-sol.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 10/11] security: AppArmor - Add flags to d_path
Message-ID: <20060420164329.GA30219@suse.de>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <20060419175026.29149.23661.sendpatchset@ermintrude.int.wirex.com> <20060419221248.GB26694@infradead.org> <20060420053604.GA15332@suse.de> <1145521570.3023.8.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145521570.3023.8.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 10:26:09AM +0200, Arjan van de Ven wrote:
> 
> > You are correct on calling BS in that I was wrong to refer to it as the
> > "system root".  When a task chroots relative to it's current namespace, we
> > are interested in the path back to the root of that namespace, rather than
> > to the chroot.  I believe the patch as stands achieves this, albeit with
> > some changing of comments.
> 
> it actually doesn't; you assume there is such a path which is not a
> given. For example if your mount got lazy umounted (like hal probably
> does) then it's a floating mount not one tied to any tree going to the
> root of any namespace.

So, running with your "lazy unmounted" example for a bit.

The patch I proposed changes how d_path behaves when the task has chrooted 
relative to it's namespace.   So in your scenario what would calling d_path
on a dentry report (for !chrooted and chrooted) without this patch ?

I can't tell if you are claiming there is a fundamental problem calling d_path
*period* in this scenario. If so, I'd appreciate a little more concrete detail 
in the way of an actual example, this is a bit hand-wavy.

Or that you are just saying another version of "pathames are crap" which I'm 
not sure if appropos to this patch itself.

If it's the former, I'll happily go off and write some code to test your
assertion and it's ramifications if I can better understand what the actual
assertion is :-)

Thanks

Tony
