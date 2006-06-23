Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752043AbWFWUmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbWFWUmn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 16:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752042AbWFWUmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 16:42:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63408 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752043AbWFWUmm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 16:42:42 -0400
Date: Fri, 23 Jun 2006 13:42:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Cc: mingo@elte.hu, arjan@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1
Message-Id: <20060623134234.14ae4cbe.akpm@osdl.org>
In-Reply-To: <6bffcb0e0606230533g7fd1dac5m16c62d035b4e9896@mail.gmail.com>
References: <20060621034857.35cfe36f.akpm@osdl.org>
	<6bffcb0e0606230533g7fd1dac5m16c62d035b4e9896@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 14:33:27 +0200
"Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:

> Hi,
> 
> On 21/06/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm1/
> >
> 
> Firefox 2 - a new testing tool for bug hunters.

Thanks.

> Jun 23 11:03:48 ltg01-fedora kernel: =======================================
> Jun 23 11:03:48 ltg01-fedora kernel: [ INFO: out of order unlock detected. ]
> Jun 23 11:03:48 ltg01-fedora kernel: ---------------------------------------

This test is a bit of a nuisance.

> Jun 23 11:03:48 ltg01-fedora kernel: The code is fine but needs lock
> validator annotation.
> Jun 23 11:03:48 ltg01-fedora kernel: firefox-bin/25734 is trying to
> release lock (tasklist_lock) at:
> Jun 23 11:03:48 ltg01-fedora kernel:  [<c017b02c>] flush_old_exec+0x12f/0xa5f
> Jun 23 11:03:48 ltg01-fedora kernel: but the next lock to release is:
> Jun 23 11:03:48 ltg01-fedora kernel:  (&sighand->siglock){++..}, at:
> [<c017afab>] flush_old_exec+0xae/0xa5f
> Jun 23 11:03:48 ltg01-fedora kernel:
> Jun 23 11:03:48 ltg01-fedora kernel: other info that might help us debug this:
> Jun 23 11:03:48 ltg01-fedora kernel: 2 locks held by firefox-bin/25734:
> Jun 23 11:03:48 ltg01-fedora kernel:  #0:  (tasklist_lock){..??}, at:
> [<c017afa4>] flush_old_exec+0xa7/0xa5f
> Jun 23 11:03:48 ltg01-fedora kernel:  #1:  (&sighand->siglock){++..},
> at: [<c017afab>] flush_old_exec+0xae/0xa5f

This is de_thread().  It's deliberate.

