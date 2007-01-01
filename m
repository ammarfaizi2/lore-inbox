Return-Path: <linux-kernel-owner+w=401wt.eu-S933250AbXAAHru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933250AbXAAHru (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 02:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933249AbXAAHru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 02:47:50 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:22992 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932961AbXAAHrt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 02:47:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m1Um4vgId0qhLcJ9WY09n54vonpbEn4VrbVtGiqF5egElY1WlBMIftOAsuVYSv08vI99QSBM935KX9evqtJJ+yNCBQfdLljVMSDf/oucGQVY+qgrcHaY6s8avawBPhRdtfjk6IXXXN1//OrvDT/lpUkUyesXJ2BYOl1HQTsdwBk=
Message-ID: <80ec54e90612312347w2b906e5eg725a7761110c6897@mail.gmail.com>
Date: Mon, 1 Jan 2007 08:47:48 +0100
From: "=?ISO-8859-1?Q?Daniel_Marjam=E4ki?=" <daniel.marjamaki@gmail.com>
To: "David Miller" <davem@davemloft.net>
Subject: Re: [PATCH] net/core/flow.c: compare data with memcmp
Cc: netdev@vger.kernel.org, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061231.123715.115911390.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <80ec54e90612310837y786fd764oc18bf37c8f0b2b8c@mail.gmail.com>
	 <20061231.123715.115911390.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

So you mean that in this particular case it's faster with a handcoded
comparison than memcmp? Because both key1 and key2 are located at
word-aligned addresses?
That's fascinating.

Best regards,
Daniel

2006/12/31, David Miller <davem@davemloft.net>:
> From: "Daniel_Marjamäki" <daniel.marjamaki@gmail.com>
> Date: Sun, 31 Dec 2006 17:37:05 +0100
>
> > From: Daniel Marjamäki
> > This has been tested by me.
> > Signed-off-by: Daniel Marjamäki <daniel.marjamaki@gmail.com>
>
> Please do not do this.
>
> memcmp() cannot assume the alignment of the source and
> destination buffers and thus will run more slowly than
> that open-coded comparison.
>
> That code was done like that on purpose because it is
> one of the most critical paths in the networking flow
> cache lookup which runs for every IPSEC packet going
> throught the system.
>
