Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbVLCSoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbVLCSoJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 13:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbVLCSoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 13:44:09 -0500
Received: from mail.dvmed.net ([216.237.124.58]:57835 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932127AbVLCSoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 13:44:08 -0500
Message-ID: <4391E764.7050704@pobox.com>
Date: Sat, 03 Dec 2005 13:43:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Golden rule: don't break userland (was Re: RFC: Starting a stable
 kernel series off the 2.6 kernel)
References: <20051203135608.GJ31395@stusta.de> <1133620598.22170.14.camel@laptopd505.fenrus.org> <20051203152339.GK31395@stusta.de>
In-Reply-To: <20051203152339.GK31395@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Adrian Bunk wrote: > IOW, we should e.g. ensure that
	today's udev will still work flawlessly > with kernel 2.6.30 (sic)? > >
	This could work, but it should be officially announced that e.g. a >
	userspace running kernel 2.6.15 must work flawlessly with _any_ future
	> 2.6 kernel. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> IOW, we should e.g. ensure that today's udev will still work flawlessly 
> with kernel 2.6.30 (sic)?
> 
> This could work, but it should be officially announced that e.g. a 
> userspace running kernel 2.6.15 must work flawlessly with _any_ future 
> 2.6 kernel.


Fix the real problem:  publicly shame kernel hackers that change 
userland ABI/API without LOTS of notice, and hopefully an old-userland 
compatibility solution implemented.

We change kernel APIs all the time.  Having made that policy decision, 
we have the freedom to rapidly improve the kernel, and avoid being stuck 
with poor designs of the past.

Userland isn't the same.  IMO sysfs hackers have forgotten this. 
Anytime you change or remove sysfs attributes these days, you have the 
potential to break userland, which breaks one of the grand axioms of 
Linux.  Everybody knows "the rules" when it comes to removing system 
calls, but forgets/ignores them when it comes to ioctls, sysfs 
attributes, and the like.

Thus, I've often felt that heavy sysfs (and procfs) use made it too easy 
to break userland.  Maybe we should change the sysfs API to include some 
sort of interface versioning, or otherwise make it more obvious to the 
programmer that they could be breaking userland compat.

Offhand, once implemented and out in the field, I would say a userland 
interface should live at least 1-2 years after the "we are removing this 
interface" warning is given.

Yes, 1-2 years.  Maybe even that is too small.  We still have old_mmap 
syscall around :)

	Jeff


