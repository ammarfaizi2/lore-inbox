Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030452AbWGZIvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030452AbWGZIvI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 04:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030449AbWGZIvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 04:51:08 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:43256 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030452AbWGZIvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 04:51:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f1yZ9rJ/4YDnFM/xg426x/M6BjIzkAfvbscqB/Nyyx7gfjIHgr1KgHCXS80ImQ1wSN0Al23lrfgAdkarDPlXfGttb2APmGccLlvD/pPUojGl4MGpImM/N5JAtyewNaq4II7w0NBoWMLoi3rn4qPOaIOZ2i1nw+nAzyiTdr+wI0Q=
Message-ID: <6bffcb0e0607260151i6065457g6acf9f4d9b2a6d50@mail.gmail.com>
Date: Wed, 26 Jul 2006 10:51:05 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [2.6.18-rc2-gabb5a5cc BUG] Lukewarm IQ detected in hotplug locking
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060725181415.483838f5.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6bffcb0e0607251657w47697883n74bab2255fd44ece@mail.gmail.com>
	 <20060725181415.483838f5.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/06, Paul Jackson <pj@sgi.com> wrote:
> Michal - you addressed this to me.  This isn't my area.

I was wrong, sorry.

> Hopefully someone else can handle this.  Good luck.

Here is the bad commit

aa95387774039096c11803c04011f1aa42d85758 is first bad commit
commit aa95387774039096c11803c04011f1aa42d85758
Author: Linus Torvalds <torvalds@macmini.osdl.org>
Date:   Sun Jul 23 12:12:16 2006 -0700

    cpu hotplug: simplify and hopefully fix locking

    The CPU hotplug locking was quite messy, with a recursive lock to
    handle the fact that both the actual up/down sequence wanted to
    protect itself from being re-entered, but the callbacks that it
    called also tended to want to protect themselves from CPU events.

    This splits the lock into two (one to serialize the whole hotplug
    sequence, the other to protect against the CPU present bitmaps
    changing). The latter still allows recursive usage because some
    subsystems (ondemand policy for cpufreq at least) had already gotten
    too used to the lax locking, but the locking mistakes are hopefully
    now less fundamental, and we now warn about recursive lock usage
    when we see it, in the hope that it can be fixed.

    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

:040000 040000 9189d56fe28f6823287e9d1e79976e68074da5db
266b4ea87d2ac441bc02ad2c
4ba2c4f332c7c0ce M      include
:040000 040000 3dfe69afef86aef8e6472d6d543ba965833e201b
bfb64b2824c1e23f0629e976
2526fd11b789d51e M      kernel

>
> --
>                   I won't rest till it's the best ...
>                   Programmer, Linux Scalability
>                   Paul Jackson <pj@sgi.com> 1.925.600.0401
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
