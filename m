Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbTD2W5T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 18:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbTD2W5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 18:57:19 -0400
Received: from muss.CIS.McMaster.CA ([130.113.64.9]:11483 "EHLO
	cgpsrv1.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S261879AbTD2W5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 18:57:17 -0400
From: Gabriel Devenyi <devenyga@mcmaster.ca>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [PATCH] KernelJanitor: Convert remaining error returns to return -E Linux 2.5.68
Date: Tue, 29 Apr 2003 23:08:30 +0000
User-Agent: KMail/1.5.1
References: <200304292215.20590.devenyga@mcmaster.ca> <20030429153244.19c32b3c.rddunlap@osdl.org>
In-Reply-To: <20030429153244.19c32b3c.rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304292308.30947.devenyga@mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the suggestions, I'm kinda new at this and just following the TODO 
which unfortuately says "sed s/return EWHATEVER/return -EWHATEVER/". I'll 
work on checking the things you suggested. As for your other questions, the 
kernel did build but I didn't attempt to boot it, I'll be sure to do so in 
the future. Thanks for the encouragement.

P.S. Anyone who works on KernelJanitor, kj.pl is suggesting some of the things 
I'm changing which aparently I shouldn't.

Building the Future,
Gabriel Devenyi
devenyga@mcmaster.ca

On April 29, 2003 10:32 pm, you wrote:
> On Tue, 29 Apr 2003 22:15:20 +0000 Gabriel Devenyi <devenyga@mcmaster.ca> 
wrote:
> | This patch applies to 2.5.68. It converts all the remaining error returns
> | to the new return -E form, this is in the KernelJanitor TODO list.
> |
> | http://muss.mcmaster.ca/~devenyga/patch-linux-2.5.68-return-errors.patch
> |
> | Please CC me with any discussion since I do not subscribe to lkml
> | --
>
> I'd have to say that it really depends on whether the caller can
> handle negative return values.  Did you check/audit the callers too?
>
> If it's a well-defined Unix/Linux error code (like s/ENOMEM/-ENOMEM/),
> this should be made to work (at least in most cases).
>
> And don't change ones that use ERR_PTR, like this:
>
> -		return ERR_PTR(-ENOMEM);
> +		return -ENOMEM;
>
>
> Local variable returns of positive/negative are probably not correct...
> without auditing the callers, it's hard to say.  E.g.:
>
> -	return ErrFlag;
> +	return -ErrFlag;
>
> (same type of change in DAC960 driver)
>
>
> I'm a bit suspicious of:
>
> -	return EOF;
> +	return -EOF;
>
> and
>
> -		return E05;
> +		return -E05;
>
> It's not just a global search & replace...
>
>
> One more thing... did you build and boot that modified kernel?
> If so, did it build with the same number or fewer warnings than the
> unmodified version?
>
> --
> ~Randy

-- 
