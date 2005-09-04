Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbVIDVoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbVIDVoO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 17:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbVIDVoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 17:44:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59330 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932084AbVIDVoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 17:44:13 -0400
Date: Sun, 4 Sep 2005 14:42:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, hyoshiok@miraclelinux.com,
       mm-commits@vger.kernel.org
Subject: Re: x86-cache-pollution-aware-__copy_from_user_ll.patch added to
 -mm tree
Message-Id: <20050904144218.7fe25102.akpm@osdl.org>
In-Reply-To: <20050904202333.GA4715@redhat.com>
References: <200509042017.j84KHekQ032373@shell0.pdx.osdl.net>
	<20050904202333.GA4715@redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> On Sun, Sep 04, 2005 at 01:16:00PM -0700, Andrew Morton wrote:
>   >  unsigned long __copy_to_user_ll(void __user *to, const void *from, unsigned long n)
>   >  {
>   >  	BUG_ON((long) n < 0);
> 
>  Ehh? It's unsigned. This will never be true.

It's cast to long, so it'll trap if we try to copy >=2G.

It seems a strange thing to check though.   Do we really need it?
