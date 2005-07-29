Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262269AbVG2Awy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbVG2Awy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 20:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVG2Awe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 20:52:34 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:21088 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262063AbVG2Awa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 20:52:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WB3bhsDNzI6WdFadnyzd4Qu6fR5wed02Ikxp6MY83gYYKtb0NPbVC64qWUqoMUgbnbNX2gcKPb5KxfQTl6JnQCVfMlFqH8zouB02clH0rWrWDVa8igFOhQMJtShASN3P4H3cq4+O3GhnywrzVwnmH3OUhCcZRnNWyxa29gD8C6Q=
Message-ID: <5c49b0ed0507281752b9485@mail.gmail.com>
Date: Thu, 28 Jul 2005 17:52:22 -0700
From: Nate Diller <nate.diller@gmail.com>
Reply-To: Nate Diller <nate.diller@gmail.com>
To: Dave Airlie <airlied@linux.ie>
Subject: Re: io scheduler silly question perhaps..
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0507290130000.1030@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0507290130000.1030@skynet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try benchmarking Anticipatory or Deadline against Noop, preferably
with your actual workload.  Noop is probably what you want, since
there is not much use in avoiding large "seeks".  It could be though
that request merging, which the non-noop schedulers all perform, willl
cause Noop to lose.  I haven't tried any I/O scheduler benchmarks with
flash, but perhaps we need a simple "merge only" scheduler for this
sort of thing.

Let me know what the results are.

NATE

On 7/28/05, Dave Airlie <airlied@linux.ie> wrote:
> 
> I have an embedded system which has two read-only flash devices (one a
> PIO ATA flash disk, and one MDMA capable flash)
> 
> As I'm doing no writing in this system and most of my reads are sequential
> (streaming movies or images) would my choice of io scheduler be very
> important?
> 
> Regards,
> Dave.
> 
> -- 
> David Airlie, Software Engineer
> http://www.skynet.ie/~airlied / airlied at skynet.ie
> Linux kernel - DRI, VAX / pam_smb / ILUG
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
