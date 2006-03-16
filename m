Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbWCPWR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbWCPWR2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 17:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbWCPWR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 17:17:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35524 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750713AbWCPWR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 17:17:27 -0500
Date: Thu, 16 Mar 2006 14:19:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, janak@us.ibm.com,
       viro@ftp.linux.org.uk, hch@lst.de, mtk-manpages@gmx.net, ak@muc.de,
       paulus@samba.org
Subject: Re: [PATCH] unshare: Cleanup up the sys_unshare interface before we
 are committed.
Message-Id: <20060316141927.50aabbc2.akpm@osdl.org>
In-Reply-To: <m1d5gm6ohm.fsf@ebiederm.dsl.xmission.com>
References: <m1y7za9vy3.fsf@ebiederm.dsl.xmission.com>
	<20060316123341.0f55fd07.akpm@osdl.org>
	<Pine.LNX.4.64.0603161240330.3618@g5.osdl.org>
	<m1d5gm6ohm.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > On Thu, 16 Mar 2006, Andrew Morton wrote:
> >> 
> >> iirc there was some discussion about this and it was explicitly decided to
> >> keep the CLONE flags.
> >> 
> >> Maybe Janak or Linus can comment?
> >
> > My personal opinion is that having a different set of flags is more 
> > confusing and likely to result in problems later than having the same 
> > ones. Regardless, I'm not touching this for 2.6.16 any more, 
> 
> I am actually a lot more concerned with the fact that we don't test
> for invalid bits.  So we have an ABI that will change in the future,
> and that doesn't allow us to have a program that runs on old and new
> kernels.

The risk of breaking things is small - it would require someone to write a
sys_unshare-using app which a) they care about and b) has a particular bug
in it.  But yes, we should check.

> I guess I can resend some version of my patch after 2.6.16 is out and
> break the ABI for the undefined bits then.  Correct programs shouldn't
> care.  But it sure would be nice if they could care.
> 

Your single patch did two different things - there's a lesson here ;)
