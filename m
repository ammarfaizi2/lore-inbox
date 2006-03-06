Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751924AbWCFH0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbWCFH0H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 02:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbWCFH0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 02:26:07 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:33915 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751924AbWCFH0G convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 02:26:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=doCmOMsPlpo4xozwAv4teRu8p+MK+u+ViTnncn0XfJJHF3mxCd56p6ADAZJzqdSwenrjllBcXU+oFGjxptFIBPJmFqs70+B3DoNxKCd3rEZuIKZrXFuc9zL8ktV1UIbNwg+RxRblDEf+eWev1/VQhoMvsl1MGLCMmliPZeIG3nM=
Message-ID: <661de9470603052326i5f4a6a7q79bc370d180737b1@mail.gmail.com>
Date: Mon, 6 Mar 2006 12:56:03 +0530
From: "Balbir Singh" <bsingharora@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: 9pfs double kfree
Cc: davej@redhat.com, linux-kernel@vger.kernel.org, ericvh@gmail.com,
       rminnich@lanl.gov
In-Reply-To: <20060305.230711.06026976.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060306070456.GA16478@redhat.com>
	 <20060305.230711.06026976.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/06, David S. Miller <davem@davemloft.net> wrote:
> From: Dave Jones <davej@redhat.com>
> Date: Mon, 6 Mar 2006 02:04:58 -0500
>
> > (I wish we had a kfree variant that NULL'd the target when it was free'd)
>
> Excellent idea.
> -

Slab debugging should catch double frees, but it will not attract your
attention till you see your dmesg log. kfree() will ignore NULL
pointer, from the comments in kfree

/**
  * kfree - free previously allocated memory
  * @objp: pointer returned by kmalloc.
 *
  * If @objp is NULL, no operation is performed.
<snip>

May we could have such a variant under CONFIG_DEBUG_SLAB if we needed
and also change the variant kfree to BUG_ON() a NULL pointer.

Balbir
