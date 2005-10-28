Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751605AbVJ1IGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbVJ1IGU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 04:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbVJ1IGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 04:06:20 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:16889 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751615AbVJ1IGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 04:06:19 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: 2.6.14 assorted warnings
Date: Fri, 28 Oct 2005 10:07:41 +0200
User-Agent: KMail/1.7.2
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
References: <5455.1130484079@kao2.melbourne.sgi.com> <20051028073049.GA27389@redhat.com>
In-Reply-To: <20051028073049.GA27389@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200510281007.42758.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Freedag 28 Oktober 2005 09:30, Dave Jones wrote:
> gcc is dumb, it doesn't realise that the variable will be filled by another
> function if its passed thus..
> 
>         unsigned long foo
>         bar(&foo)
>         if (foo==1)
>                 ...
> 
> With bar() filling in content of foo.
> I believe there's at least once instance of this in gcc bugzilla.
> 
The case is more complicated here. gcc before 4.0 always assumed that
bar(&foo); initializes foo. gcc-4.0 now looks into bar if it is inlining
that and tries to find out if that really initializes foo in every
case.

In the example, bvec_alloc_bs does not initialize &idx when nr is not
between 1 and BIO_MAX_PAGES, so gcc is telling the truth here.

	Arnd <><
