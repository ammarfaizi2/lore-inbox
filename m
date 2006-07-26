Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751717AbWGZRVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbWGZRVG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 13:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751721AbWGZRVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 13:21:05 -0400
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:42153 "EHLO
	liaag1ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751722AbWGZRVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 13:21:05 -0400
Date: Wed, 26 Jul 2006 13:15:41 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: automated test? (was Re: Linux 2.6.17.7)
To: Adrian Bunk <bunk@stusta.de>
Cc: Arnaud Patard <apatard@mandriva.com>,
       David Lang <dlang@digitalinsight.com>,
       Andrew de Quincey <adq_dvb@lidskialf.net>, Greg KH <greg@kroah.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-stable <stable@kernel.org>
Message-ID: <200607261318_MC3-1-C623-96BB@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060726142932.GE23701@stusta.de>

On Wed, 26 Jul 2006 16:29:32 +0200, Adrian Bunk wrote:

> The real problem is:
> How do we get some testing coverage of -stable kernels by users to catch 
> issues?
> And compile errors are the least of my worries.

The problem with the current method of releasing patch candidates is
that it's too hard to test them.  I would suggest:

        1.  In addition to posting all the patches separately to L-K,
            post a combined patch.  Have it change the makefile so it
            says 2.6.X.Y-rcZ; that way if an oops gets posted we know
            what the codebase was.  If the patch is too big, put it
            on a website.

        2.  Make the separate patches available on a website in Quilt
            format like Andrew does with -mm.  (Just like (1) above,
            make sure it changes the kernel version.)  This makes it
            easier for testers to fix individual patches.

        3.  Keep posting -rc's until nobody reports problems.

It's easy to generate (1) from (2):

        a.      Untar the quilt patchset into the new directory.
                Make sure the old and new dirs are subdirectories
                of some common directory, are identical and they
                are dist-clean.
        b.      mv broken-out patches
        c.      quilt push -a -q
        d.      cd ..
        e.      diff -uprN -X ignorefiles old new >old.new.patch
                -- ignorefiles contains two lines:
                        .pc
                        patches

-- 
Chuck

