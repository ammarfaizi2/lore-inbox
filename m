Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267446AbUH2J0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267446AbUH2J0R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 05:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267455AbUH2J0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 05:26:17 -0400
Received: from wasp.net.au ([203.190.192.17]:11665 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S267446AbUH2J0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 05:26:14 -0400
Message-ID: <4131A15A.7090201@wasp.net.au>
Date: Sun, 29 Aug 2004 13:26:50 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.7+ (X11/20040730)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Libata VIA woes continue. Worked around - *wrong*
References: <412F3DEA.2070307@wasp.net.au> <41318680.8080102@wasp.net.au> <41318C87.9010806@pobox.com> <4131910B.6020000@wasp.net.au> <41319C1F.6030207@pobox.com>
In-Reply-To: <41319C1F.6030207@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> * look at the changes from 2.6.5 -> 2.6.6 and see which change breaks 
> things.  You can get a list of each change like this:
> 
>     bk changes -rv2.6.5..v2.6.6
> 
> then you can revert each patch in order, or bsearch.  Here's an example 
> of reverting each libata patch in order:
> 
> bk clone http://linux.bkbits.net/linux-2.5 vanilla-2.6
> bk clone -ql -rv2.6.6 vanilla-2.6 brad-test-2.6.6
> cd brad-test-2.6.6
> bk -r co -Sq
> bk changes -rv2.6.5.. > /tmp/changes-list.txt
> less /tmp/changes-list.txt    # scan for a libata-related change
> bk cset -x1.1587.39.2        # applies reverse of cset 1.1587.39.2
> make                # create test
>                 # ... test fails
> bk cset -x1.1587.39.1        # applies reverse of cset 1.1587.39.1
>                 # _on top of_ previous reverted patch
> -

Ooooohh. I have been looking for a "Dummies guide to regression testing with BK" and not been able
to find one. I have cc'd this to linux-kernel purely for the purpose of more googleable archives for
future reference for BK newbies like me.

Cheers Jeff!

I'll start hammering on this tonight.

(It's actually between 2.6.6 and 2.6.7-rc1 that the breakage occurs, I had just been running 2.6.5
until I recently got a dodgy hard disk which showed up flaws in the libata error handling, thus I
tried to move to 2.6.8.1 to debug that and found it broke some of my drives in other ways. I have
already cloned the relevant trees, I just could not figure out how to break it down to cset granularity)

Regards,
Brad

