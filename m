Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbVH3SNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbVH3SNR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 14:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbVH3SNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 14:13:17 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:10095 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932250AbVH3SNR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 14:13:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L3FdLoOKPY6RUoroDyj6k69fR6ZEYbiMi0QbgUT/OekSPeui+xMQUEQh7U4qkUvV8hNOyGCzrcDdPjqpq8kdxKoJYAiAW9b5GSkQ1ALXkPzFEoMZ+38gA7q9S4YacBapTsk/DnRIvFmhfmBeZeagoz7DKQKkD+K20/m99EQpjhU=
Message-ID: <25381867050830111345e27945@mail.gmail.com>
Date: Tue, 30 Aug 2005 14:13:13 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
To: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] IPMI: driver model and sysfs support
Cc: Martin Drab <drab@kepler.fjfi.cvut.cz>,
       openipmi-developer@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43145D95.8060006@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2538186705083003561f5f97e0@mail.gmail.com>
	 <43145D95.8060006@acm.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/05, Corey Minyard <minyard@acm.org> wrote:
> This is very good.  I believe the structure is correct, but I'm not a
> sysfs expert.
> 
> There are a few things we need to deal with, though.
> 
> * There are some significant changes to versioning in the
>   driver that are in the mm tree right now (you can pull them from
> 
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc6/2.6.13-rc6-mm2/broken-out)

Gah, ok :), I'll try to apply with the -mm changes.

> * There are some coding style problems.  You have places like:
>   +static void ipmi_bmc_unregister(struct ipmi_si_device *si,
>   + struct ipmi_bmc_device *bmc){
>   The '{' for functions and structures needs to be on it's own line.
>   Also, several:
>   + if(bmc->guid_present){
>   that need spaces after the 'if' and before the '{'.
>   The patch also adds some trailing spaces to empty lines, the
>   following is a telltale sign:
>   -
>   +
>   There was also one place where you added unneeded braces to
>   a single statement and another where you deleted the empty line
>   between two functions.
>   These are all standard kernel coding style rules.

Yes, I should have caught those, thanks.

> * I'd prefer to store the product id, device id, and manufacturer id
>   decoded.  This makes it easier to handle (no need to use "memcmp"
>   to compare) and print.  The printing of the product id, for instance,
>   will be rather unnatural in product_id_show().

I was under the impression that they were just OEM strings, and not
necessarily ASCII strings? I'll have a look at the specs again.

> * guids are not printable strings (see guid_show()).

guid_show, sounds useful!

Thanks,
Yani
