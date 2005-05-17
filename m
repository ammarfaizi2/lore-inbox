Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbVEQRPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbVEQRPH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 13:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVEQRGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 13:06:20 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:15004 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261854AbVEQRCd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 13:02:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=L/bfPIrFmUhNRZpNSqPdTZG3bbXXULwAefgBhuX3uDjh6086budfTLodgiH3MZ9MNly5FPbxbLg4fsBshqndmHRne3tmqMAknpRLZeRNMl+HNljRS897mTkO6+A/hW49DU3L9uys5RUl+xIrnqQPRL9JBeSOoSFSKhuXZYA+x7I=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: teigland@redhat.com, pcaulfie@redhat.com
Subject: Re: patch dlm-device-interface.patch added to -mm tree
Date: Tue, 17 May 2005 21:06:32 +0400
User-Agent: KMail/1.7.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200505170740.j4H7e4Qw021556@shell0.pdx.osdl.net>
In-Reply-To: <200505170740.j4H7e4Qw021556@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505172106.32385.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 May 2005 11:39, akpm@osdl.org wrote:
> This is a separate module from the dlm.  It exports the dlm api to user space
> through a misc device.  Applications use a library (libdlm) which communicates
> with the kernel through this device.

> --- /dev/null
> +++ 25-akpm/drivers/dlm/device.c

> +static struct lock_info *get_lockinfo(uint32_t lockid)
> +{
> +	struct lock_info *li;
> +
> +	read_lock(&lockinfo_lock);
> +	li = idr_find(&lockinfo_idr, lockid);
> +	read_lock(&lockinfo_lock);
	^^^^^^^^^
> +
> +	return li;
> +}

read_unlock ?

> +int __init dlm_device_init(void)
> +{

> +		printk(KERN_ERR "dlm: misc_register failed for control device");

device\n
