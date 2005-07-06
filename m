Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbVGFWFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVGFWFa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 18:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbVGFWF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 18:05:27 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:13845 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261565AbVGFWCj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 18:02:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ERfGB09HWrDwb2GZ1JgSPkrqtaswPQohTLCuT87OwMahSyzVVcjffSUoHZj7116e/S/3FLrD0RUIBFupF6V/OFYF5f9f30poyi4+w1k5ogqt4+vADYoK9+O5s6AdFLhXqmzq+NUq3bgAoW5UBGnoqf0lJTA3ZFtFPqmPCsF1XJw=
Message-ID: <170fa0d2050706150255ec7019@mail.gmail.com>
Date: Wed, 6 Jul 2005 16:02:35 -0600
From: Mike Snitzer <snitzer@gmail.com>
Reply-To: Mike Snitzer <snitzer@gmail.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [patch] kernel sysfs events layer
Cc: Robert Love <rml@novell.com>, Greg KH <greg@kroah.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040906020601.GA3199@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1093988576.4815.43.camel@betsy.boston.ximian.com>
	 <1093989513.4815.45.camel@betsy.boston.ximian.com>
	 <20040831150645.4aa8fd27.akpm@osdl.org>
	 <1093989924.4815.56.camel@betsy.boston.ximian.com>
	 <20040902083407.GC3191@kroah.com>
	 <1094142321.2284.12.camel@betsy.boston.ximian.com>
	 <20040904005433.GA18229@kroah.com>
	 <1094353088.2591.19.camel@localhost> <20040905121814.GA1855@vrfy.org>
	 <20040906020601.GA3199@vrfy.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So this is a blast from the past but I'd like to understand why
kobject_uevent and kbject_uevent_atomic  are EXPORT_SYMBOL_GPL rather
than EXPORT_SYMBOL.  During the evoloution from a separate kevents
over netlink (rml, kay, arjan) then folding it in to kobject with
hotplug (kay, greg kh, etc) it went from GPL to not, as listed below
in one of kay's early patches, back to EXPORT_SYMBOL_GPL as it stands
today.  At one point Andrew Morton asked Robert Love why the GPL-only
export on the orginal kevent code and Robert said he'd check with
Arjan.. didn't see the answer.

In any case, how is it that all kernel code _should_ be sending events
to userspace?  GPL the kernel code in question and use kobject_uevent?
;)  It'd be nice if non-GPL kernel code could send events through this
interface too.

please advise, thanks.
Mike

On 9/5/04, Kay Sievers <kay.sievers@vrfy.org> wrote:

> diff -Nru a/kernel/kobject_uevent.c b/kernel/kobject_uevent.c
> --- /dev/null   Wed Dec 31 16:00:00 196900
> +++ b/kernel/kobject_uevent.c   2004-09-06 03:47:59 +02:00
<snip>
> +
> +int kobject_uevent(const char *signal, struct kobject *kobj,
> +                  struct attribute *attr)
> +{
> +       return do_kobject_uevent(signal, kobj, attr, GFP_KERNEL);
> +}
> +
> +EXPORT_SYMBOL(kobject_uevent);
> +
> +int kobject_uevent_atomic(const char *signal, struct kobject *kobj,
> +                         struct attribute *attr)
> +{
> +       return do_kobject_uevent(signal, kobj, attr, GFP_ATOMIC);
> +}
> +
> +EXPORT_SYMBOL(kobject_uevent_atomic);
> +
