Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWJVKlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWJVKlk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 06:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWJVKlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 06:41:40 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:49076
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S932167AbWJVKlk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 06:41:40 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: NULL pointer dereference in sysfs_readdir
Date: Sun, 22 Oct 2006 12:40:41 +0200
User-Agent: KMail/1.9.5
References: <4539DDC5.80207@s5r6.in-berlin.de> <200610212325.18976.mb@bu3sch.de> <453B352A.5050700@s5r6.in-berlin.de>
In-Reply-To: <453B352A.5050700@s5r6.in-berlin.de>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       Dave Jones <davej@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610221240.42061.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 October 2006 11:08, Stefan Richter wrote:
> > Yeah, I found that offset, too, but:
> > 
> > There is only one usage of s_dentry
> > if (next->s_dentry)
> > 
> > But _before_ that there already comes
> > if (!next->s_element)
> > 
> > So, if "next" was NULL, it would already oops there.
> 
> What if "next" became NULL afterwards?

Hm, yeah. Makes kind of sense.

> I know it's unlikely (but so is 
> the whole bug, given that we have just one reporter despite the bug's
> age), but is it impossible? IOW does sysfs_readdir have any indirect
> mutex protection?

I think it's protected by the BKL, but I dunno if that's sufficient here.

-- 
Greetings Michael.
