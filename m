Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbWH3TZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWH3TZH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 15:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWH3TZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 15:25:07 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:44582 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751366AbWH3TZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 15:25:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NNkEd8UfOawFYjO1AmUlLbE/mzYDkMLuoB0zNc1Zo7x/0yLDSRNQJf3RAdisKc9acgppz4lcQrKw7BClJm5D/PXmlLYf58NskZ3BiTYWSa+phperbILQQknlFSymK8Cv5Hk3oMDm2/5MFM13sWSqJQsjAbBmz7gPGpB5bBMKWQ8=
Message-ID: <18d709710608301225x7407b216o74420d0b4034a484@mail.gmail.com>
Date: Wed, 30 Aug 2006 16:25:03 -0300
From: "Julio Auto" <mindvortex@gmail.com>
To: "David Wagner" <daw-usenet@taverner.cs.berkeley.edu>
Subject: Re: [S390] cio: kernel stack overflow.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <ed4nih$gb0$2@taverner.cs.berkeley.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060830124047.GA22276@skybase>
	 <ed4nih$gb0$2@taverner.cs.berkeley.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, about your previous e-mail: you're correct, the members
not explicitly initialized behave like when  a _static_ object is not
explicitly initialized (ie., zero'ing it), instead of behaving like an
_automatic_ object not being explicitly initialized (which was the
kind of behavior I was expecting). This is part of the C99
specification, indeed.

See section 6.7.8, constraints no. 10 and 19, for more info.

On 8/30/06, David Wagner <daw@cs.berkeley.edu> wrote:
> I don't see any obvious place that zeroes out cdev->id.
> In particular, it looks like cdev->id.match_flags and .driver_info
> are never cleared (i.e., they retain whatever old garbage they had
> before).  More importantly, if anyone ever adds any more fields to
> struct ccw_device_id, then they will also be retain old garbage values,
> which is a maintenance pitfall.  Is this right, or did I miss something
> again?

Nicely pointed out, I hadn't thought about this possible maintenance
issue. Looks like a nice place for a memset() to reside.

Cheers,

    Julio Auto
