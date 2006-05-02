Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbWEBBfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWEBBfY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 21:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWEBBfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 21:35:24 -0400
Received: from pproxy.gmail.com ([64.233.166.181]:20687 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932344AbWEBBfY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 21:35:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ePOJ5bmNh5if1Y4RIKPV7Ii/IwzUhFPJluBLBBQ14SkOyoujFvOE7AWR5O1HzdPwWTncv/JGS1NxKMGAipVwtQ5MbM7dHfYlTbWaGJwGpodBTAK8eJKHrsBqsNXVlWYWP6XPa6TVCffu1CUdrCmM68dIkZs6ltDDSB9yOkf6buk=
Message-ID: <aec7e5c30605011835g3a0a671br2b327909e2d6443c@mail.gmail.com>
Date: Tue, 2 May 2006 10:35:18 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: vgoyal@in.ibm.com
Subject: Re: [Fastboot] [PATCH] kexec: Avoid overwriting the current pgd (i386)
Cc: "Magnus Damm" <magnus@valinux.co.jp>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, ebiederm@xmission.com
In-Reply-To: <20060501143512.GA7129@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060501095041.16897.49541.sendpatchset@cherry.local>
	 <20060501143512.GA7129@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/06, Vivek Goyal <vgoyal@in.ibm.com> wrote:
> On Mon, May 01, 2006 at 06:49:16PM +0900, Magnus Damm wrote:
> > kexec: Avoid overwriting the current pgd (i386)
> >
> > This patch upgrades the i386-specific kexec code to avoid overwriting the
> > current pgd. Overwriting the current pgd is bad when CONFIG_CRASH_DUMP is used
> > to start a secondary kernel that dumps the memory of the previous kernel.
> >
> > The code introduces a new set of page tables called "page_table_a". These
> > tables are used to provide an executable identity mapping without overwriting
> > the current pgd.
>
> True, current pgd is overwritten but that effects only user space mappings
> and currently "crash" supports only backtracing kernel space code. But at
> the same time probably it is not a bad idea to maintain a separate page
> table and switch to that instead of overwriting the existing pgd. This
> shall help if in future user space backtracing is also supported.

I agree, but I also think that overwriting user space mappings is bad
from the trace perspective too, especially if you look at kernel data.
I would say that user space page tables are just another kernel data
structure, and overwriting them may result in things like inconsistent
page->mapcount values.

Thanks for the comments,

/ magnus
