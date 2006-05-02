Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbWEBHVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbWEBHVX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 03:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbWEBHVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 03:21:23 -0400
Received: from pproxy.gmail.com ([64.233.166.176]:29464 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932485AbWEBHVW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 03:21:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RCGvT8VWHl5JM5BPQbA31T4wqXr15r/BZPLkO/3PwFHv6aHj47qrmE3JEzZrWslGfGIm1V6siILkvwQc/6MiimEhD4GI1ltbu+LEU02ZVU/YUcH29XmZVWQOXTqkPqzcEqv6KxKoj6VttkFN0zjXGOnWlCLVus5BeRi9Z3pvk0w=
Message-ID: <aec7e5c30605020021v3c3225eftfddfd2226b2cdf0c@mail.gmail.com>
Date: Tue, 2 May 2006 16:21:22 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: [PATCH] kexec: Avoid overwriting the current pgd (x86_64)
Cc: "Magnus Damm" <magnus@valinux.co.jp>, ebiederm@xmission.com,
       linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
In-Reply-To: <p73ejzc7wm0.fsf@bragg.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060501095407.16902.78809.sendpatchset@cherry.local>
	 <p73ejzc7wm0.fsf@bragg.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[re-added fastboot list]

On 02 May 2006 08:45:59 +0200, Andi Kleen <ak@suse.de> wrote:
> Magnus Damm <magnus@valinux.co.jp> writes:
>
> > --===============82697867595349228==
> >
> > kexec: Avoid overwriting the current pgd (x86_64)
> >
> > This patch upgrades the x86_64-specific kexec code to avoid overwriting the
> > current pgd. Overwriting the current pgd is bad when CONFIG_CRASH_DUMP is used
> > to start a secondary kernel that dumps the memory of the previous kernel.
>
> Why is it bad?

Because in the kdump case (CONFIG_CRASH_DUMP) we store the memory
contents of the crashed kernel somewhere to later on be able to
analyze it. And it makes sense to avoid overwriting things because we
want to analyze the _original_ state when the kernel crashed, not some
half-overwritten state.

Thanks,

/ magnus
