Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269212AbUIAAVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269212AbUIAAVS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 20:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269218AbUIAAKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 20:10:20 -0400
Received: from relay01.kbs.net.au ([203.220.32.149]:31444 "EHLO
	relay01.kbs.net.au") by vger.kernel.org with ESMTP id S269284AbUHaXoM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 19:44:12 -0400
Subject: Re: [2.6 patch]  kill __always_inline
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andrew Morton <akpm@osdl.org>
Cc: bunk@fs.tum.de, ak@muc.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040831163914.4c7c543c.akpm@osdl.org>
References: <20040831221348.GW3466@fs.tum.de>
	 <20040831153649.7f8a1197.akpm@osdl.org> <20040831225244.GY3466@fs.tum.de>
	 <1093993946.8943.33.camel@laptop.cunninghams>
	 <20040831163914.4c7c543c.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1093995674.8943.38.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 01 Sep 2004 09:41:15 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2004-09-01 at 09:39, Andrew Morton wrote:
> IIRC, the compiler was generating out-of-line versions of functions in
> every compilation unit whcih included the header file.  When we the
> developers just wanted `inline' to mean `inline, dammit'.
> 
> If that broke swsusp in some manner then the relevant swsusp functions
> should be marked always_inline, because they have some special needs.

Yes, that's exactly right. Suspend relies upon inline always inlining,
and as I work around I added...

#undef inline
#define inline __inline__ __attribute__(always_inline))

while this discussion was going on. I should switch this to
always_inline now that it's merged.

> > That is to say, doesn't the definition of always_inline vary
> > with the compiler version?
> 
> If the compiler supports attribute((always_inline)) then the kernel build
> system will use that.  If the compiler doesn't support
> attribute((always_inline)) then we just emit `inline' from cpp and hope
> that it works out.

Thanks.

Nigel
-- 
Nigel Cunningham
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. But true tolerance can cope with others
being intolerant.

