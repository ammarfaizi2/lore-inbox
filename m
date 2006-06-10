Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbWFJCmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWFJCmp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 22:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbWFJCmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 22:42:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26515 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964883AbWFJCmp (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 22:42:45 -0400
Date: Fri, 9 Jun 2006 19:42:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: rohitseth@google.com
Cc: Linux-mm@kvack.org, Linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Adding a counter in vma to indicate the number of
 physical pages backing it
Message-Id: <20060609194236.4b997b9a.akpm@osdl.org>
In-Reply-To: <1149903235.31417.84.camel@galaxy.corp.google.com>
References: <1149903235.31417.84.camel@galaxy.corp.google.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Jun 2006 18:33:55 -0700
Rohit Seth <rohitseth@google.com> wrote:

> Below is a patch that adds number of physical pages that each vma is
> using in a process.  Exporting this information to user space
> using /proc/<pid>/maps interface.

Ouch, that's an awful lot of open-coded incs and decs.  Isn't there some
more centralised place we can do this?

What locking protects vma.nphys (can we call this nr_present or something?)

Will this patch do the right thing with weird vmas such as the gate vma and
mmaps of device memory, etc?

