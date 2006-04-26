Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWDZR7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWDZR7f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 13:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWDZR7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 13:59:35 -0400
Received: from nproxy.gmail.com ([64.233.182.190]:14428 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932269AbWDZR7f convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 13:59:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YVL6vitiRV+DIGyo6eaxdGzVbBypmxu20btPyg16lnd6YE0ttPuf1C/rTEPVgMmEknbm7dSoPpFWEEHLh3vES/1TFQX+3J+r1Gxp4qAz5adE+m2O8vRaWXF2BMNSE5it1mSbeFRBKIpjImEcgyjoGrwzQPZl5oldjGDlsPzNGlk=
Message-ID: <4de7f8a60604261059x7606d3ebl5efb26798293658@mail.gmail.com>
Date: Wed, 26 Apr 2006 19:59:33 +0200
From: "Jan Blunck" <jblunck@gmail.com>
Reply-To: j.blunck@tu-harburg.de
To: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Subject: Re: [patch 13/13] s390: dasd device identifiers.
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, horst.hummel@de.ibm.com
In-Reply-To: <20060424150620.GN15613@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060424150620.GN15613@skybase>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/06, Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> +/*
> + * Register the given device unique identifier into devmap struct.
> + */
> +int
> +dasd_set_uid(struct ccw_device *cdev, struct dasd_uid *uid)
> +{
> +       struct dasd_devmap *devmap;
> +
> +       devmap = dasd_find_busid(cdev->dev.bus_id);
> +       if (IS_ERR(devmap))
> +               return PTR_ERR(devmap);
> +       spin_lock(&dasd_devmap_lock);
> +       devmap->uid = *uid;
> +       spin_unlock(&dasd_devmap_lock);
> +       return 0;
> +}
> +

EXPORT_SYMBOL(dasd_set_uid) is missing.
