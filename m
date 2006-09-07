Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbWIGIiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWIGIiA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 04:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWIGIiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 04:38:00 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:47652 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750899AbWIGIh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 04:37:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rCgZjyop++hpN/S7HQKz+DBxlmgCJycsyFHN6TPpauK/TEz+7o5W2qRgPV1ih8fsNyicJ5XrKoxGzUYkFRLy4JkYHFilG9Rw1jaHcRTFdpfWcsdgsvfARx2IlEG9Gg9WXPUyhZD24gDU2HvCsETq+aecP13oV24F8kcomciDp04=
Message-ID: <b0943d9e0609070137g5384b6dcp1ecff948661cd98@mail.gmail.com>
Date: Thu, 7 Sep 2006 09:37:58 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCH 2.6.18-rc6 00/10] Kernel memory leak detector 0.10
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0609070135i314f2740if067eeab342f29a2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060906223536.21550.55411.stgit@localhost.localdomain>
	 <6bffcb0e0609061710t3519e42dl6138cadd5ff0d3fb@mail.gmail.com>
	 <b0943d9e0609070104v1b747f79v3b10238954f389cd@mail.gmail.com>
	 <6bffcb0e0609070135i314f2740if067eeab342f29a2@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> On 07/09/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > On 07/09/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > > I get a kernel panic
> > > http://www.stardust.webpages.pl/files/o_bugs/kmemleak-0.10/panic.jpg
> > >
> > > http://www.stardust.webpages.pl/files/o_bugs/kmemleak-0.10/kml-config
> >
> > Well, you set CONFIG_DEBUG_MEMLEAK_HASH_BITS to 32, this means that
> > kmemleak needs to allocate (sizeof(void*) * 2^32) which is 16GB of
> > RAM. I think a maximum of 20 should be enough (I got acceptable
> > results with 16 hash bits, the default value, and it seemed to do
> > better with 18).
>
> CONFIG_DEBUG_MEMLEAK=y
> CONFIG_DEBUG_MEMLEAK_HASH_BITS=8
> CONFIG_DEBUG_MEMLEAK_TRACE_LENGTH=12
> CONFIG_DEBUG_MEMLEAK_PREINIT_OBJECTS=512
> # CONFIG_DEBUG_MEMLEAK_SECONDARY_ALIASES is not set
> # CONFIG_DEBUG_MEMLEAK_TASK_STACKS is not set
> # CONFIG_DEBUG_MEMLEAK_ORPHAN_FREEING is not set
> CONFIG_DEBUG_MEMLEAK_REPORTS_NR=100
> # CONFIG_DEBUG_KEEP_INIT is not set
> # CONFIG_DEBUG_MEMLEAK_TEST is not set
>
> I still get a panic

Is it in the same place? What does the panic text say?

BTW, you should probably enable SECONDARY_ALIASES and TASK_STACKS
above to reduce the number of false positives.

-- 
Catalin
