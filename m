Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751691AbWGZPB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbWGZPB2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 11:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbWGZPB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 11:01:28 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:42428 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751688AbWGZPB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 11:01:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fJXaeb5P8FohruTNhtMAsNW5RJNVq8BngbGfUQ5gr+dA1P68j/UYOAMIFivUc0hM85txXSEy93ZmAyjUDldZCAXFV2FK0KFW4R/xd/jFxr11eoySPza/64cNhOLaQW0I+PBfKvwGMcsOLzdV+kXmIzcI5Rai8d/LqgAxGwa4fkk=
Message-ID: <6bffcb0e0607260801s73cdee9avd207984712011c80@mail.gmail.com>
Date: Wed, 26 Jul 2006 17:01:26 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: torvalds@osdl.org
Subject: Re: [2.6.18-rc2-gabb5a5cc BUG] Lukewarm IQ detected in hotplug locking
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0607260151i6065457g6acf9f4d9b2a6d50@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6bffcb0e0607251657w47697883n74bab2255fd44ece@mail.gmail.com>
	 <20060725181415.483838f5.pj@sgi.com>
	 <6bffcb0e0607260151i6065457g6acf9f4d9b2a6d50@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> Here is the bad commit
>
> aa95387774039096c11803c04011f1aa42d85758 is first bad commit
> commit aa95387774039096c11803c04011f1aa42d85758
> Author: Linus Torvalds <torvalds@macmini.osdl.org>
> Date:   Sun Jul 23 12:12:16 2006 -0700
>
>     cpu hotplug: simplify and hopefully fix locking
>
>     The CPU hotplug locking was quite messy, with a recursive lock to
>     handle the fact that both the actual up/down sequence wanted to
>     protect itself from being re-entered, but the callbacks that it
>     called also tended to want to protect themselves from CPU events.
>
>     This splits the lock into two (one to serialize the whole hotplug
>     sequence, the other to protect against the CPU present bitmaps
>     changing). The latter still allows recursive usage because some
>     subsystems (ondemand policy for cpufreq at least) had already gotten
>     too used to the lax locking, but the locking mistakes are hopefully
>     now less fundamental, and we now warn about recursive lock usage
>     when we see it, in the hope that it can be fixed.
>
>     Signed-off-by: Linus Torvalds <torvalds@osdl.org>
>
> :040000 040000 9189d56fe28f6823287e9d1e79976e68074da5db
> 266b4ea87d2ac441bc02ad2c
> 4ba2c4f332c7c0ce M      include
> :040000 040000 3dfe69afef86aef8e6472d6d543ba965833e201b
> bfb64b2824c1e23f0629e976
> 2526fd11b789d51e M      kernel

Sorry for the noise.

The bug is fixed in latest git tree.

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
