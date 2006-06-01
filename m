Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964920AbWFARSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbWFARSe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 13:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbWFARSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 13:18:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49027 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964920AbWFARSe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 13:18:34 -0400
Date: Thu, 1 Jun 2006 10:22:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Cc: gregkh@suse.de, mingo@elte.hu, arjan@linux.intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm2
Message-Id: <20060601102234.4f7a9404.akpm@osdl.org>
In-Reply-To: <6bffcb0e0606010851n75b49d83u9f43136b3108886c@mail.gmail.com>
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	<6bffcb0e0606010851n75b49d83u9f43136b3108886c@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2006 17:51:16 +0200
"Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:

> Hi,
> 
> On 01/06/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm2/
> >
> 
> I don't know why, but first bug appears only when avahi-daemon is
> started. Second look like a problem with my camera.
> http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm2/bug_1.jpg

For some reason the lockdep code expected that hardirqs would be enabled.

> http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm2/bug_2.jpg

So it's claiming that we're taking multiple i_mutexes.

I can't immediately see where we took the outermost i_mutex there.  Nor is
it immediately obvious why this is considered to be deadlockable?

(lockdep tells us that a mutex was taken at "mutex_lock+0x8/0xa", which is
fairly useless.  We need to report who the caller of mutex_lock() was).

> Here is config http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm2/mm-config

