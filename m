Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751893AbWKBSVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbWKBSVK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 13:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbWKBSVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 13:21:09 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:45994 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751766AbWKBSVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 13:21:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rXor26gjmrJQ18Uw4q91a9cJ29tPEceYd9IasvOsV3OF2Hdb2YK5IxtSjSkpIiq8BJg1sumoJ1y22o151akYwbYhKuJP4kzmUrJf0QcGm53f6Ls30nIiwrleeZ64800vEgcyvb6OZi6ibDFqWR+ODiL471JijSLWePhr8zE6nZg=
Message-ID: <aec7e5c30611021020j79906c8t99a133f2588de736@mail.gmail.com>
Date: Fri, 3 Nov 2006 03:20:58 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Andi Kleen" <ak@muc.de>
Subject: Re: [PATCH] x86_64: setup saved_max_pfn correctly (kdump)
Cc: "Magnus Damm" <magnus@valinux.co.jp>, linux-kernel@vger.kernel.org,
       "Mel Gorman" <mel@csn.ul.ie>, "Vivek Goyal" <vgoyal@in.ibm.com>,
       fastboot@lists.osdl.org
In-Reply-To: <20061102174016.GA52800@muc.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061102131934.24684.93195.sendpatchset@localhost>
	 <20061102174016.GA52800@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Nov 2006 18:40:16 +0100, Andi Kleen <ak@muc.de> wrote:
> On Thu, Nov 02, 2006 at 10:19:34PM +0900, Magnus Damm wrote:
> > x86_64: setup saved_max_pfn correctly
> >
> > 2.6.19-rc4 has broken CONFIG_CRASH_DUMP support on x86_64. It is impossible
> > to read out the kernel contents from /proc/vmcore because saved_max_pfn is set
> > to zero instead of the max_pfn value before the user map is setup.
>
> Do you know what patch has broken it?

Not really. I can find out if you want, but it has to wait until the
middle of next week - I'm out of the office at the moment. If I have
to guess then I point in Mel's direction. =)

> Or did just nobody test crash dump at all since -rc* started?

I think the problem is what to test. The entire chain of crash dump
tools is in an "interesting" state right now because the code is
pretty easy to break and it is under constant development - the
relocatable kernel code and my and Simon's kexec port for xen are two
good examples. And that the code is spread out over two kernels that
may not be of the same version together with a more or less
unmaintained userspace tool does not help...

I hope that someone else than me booted a crash kernel, but it looks
like noone really tested copying a crash image on x86_64. I didn't
until now. =) It's not that surprising though - there are only a few
kexec/kdump developers out there and there are several architectures
plus focus on features. Bound to break IMO.

Thanks,

/ magnus
