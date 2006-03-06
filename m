Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWCFPj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWCFPj5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 10:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWCFPj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 10:39:56 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:35197 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750741AbWCFPj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 10:39:56 -0500
Date: Mon, 6 Mar 2006 16:39:50 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Bastian Blank <bastian@waldi.eu.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, heiko.carstens@de.ibm.com,
       schwidefsky@de.ibm.com
Subject: Re: + s390-add-modalias-to-uevent-for-ccw-devices.patch added to
 -mm tree
Message-ID: <20060306163950.5eb027e6@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20060306135017.GA18874@wavehammer.waldi.eu.org>
References: <200603060714.k267E6gN021778@shell0.pdx.osdl.net>
	<20060306110416.1e14933f@gondolin.boeblingen.de.ibm.com>
	<20060306135017.GA18874@wavehammer.waldi.eu.org>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.13; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2006 14:50:17 +0100
Bastian Blank <bastian@waldi.eu.org> wrote:

> And it does not work as expected. The uevent includes "MODALIAS=" but
> the rest got lost in the buffer as it used a wrong offset. The attached
> patch makes that really working.

> @@ -120,8 +120,8 @@ ccw_uevent (struct device *dev, char **e
>  	buffer += length;
>  
>  	envp[i++] = buffer;
> -	length += scnprintf(buffer, buffer_size - length, "MODALIAS=");
> -	length += modalias_print(cdev, buffer + length, buffer_size - length);
> +	length += tmp_length = scnprintf(buffer, buffer_size - length, "MODALIAS=");
> +	length += modalias_print(cdev, buffer + tmp_length, buffer_size - length);
>  	if ((buffer_size - length <= 0) || (i >= num_envp))
>  		return -ENOMEM;

You're right. I don't like the tmp_length too much, but can't think of
anything better.

Cornelia
