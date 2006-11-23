Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756378AbWKWT3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756378AbWKWT3d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 14:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756380AbWKWT3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 14:29:33 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:21901 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1756361AbWKWT3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 14:29:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M1xWY7gbdudBJqoBjpVWOXlsJVNTgcQA/oN/6jMi77b4IaX92JnDUbNLXp6NveARgUIta/gKiY6FSANwNRc3e0tMGBC3KH9NaoYeHm3nkJTEigrksmkZa3fD+r+hwYomamaGaebmvKuCsWuMFObClEp/c4iy9LWxau9FGy2Sqlc=
Message-ID: <acd2a5930611231129v3515022al931bec5b04ce27f@mail.gmail.com>
Date: Thu, 23 Nov 2006 22:29:30 +0300
From: "Vitaly Wool" <vitalywool@gmail.com>
To: "Vitaly Wool" <vitalywool@gmail.com>, drzeus-mmc@drzeus.cx,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix random SD/MMC card recognition failures on ARM Versatile
In-Reply-To: <20061123160335.GB8984@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061123184606.bb203ae6.vitalywool@gmail.com>
	 <20061123160335.GB8984@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/06, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> Doubtful.  mmci_stop_data() already does this, which will be called
> immediately prior to mmci_request_end().  So you're doubling up the
> writes to registers again.

There's the case (mmci_cmd_irq) where mmc_stop_data is not called
prior to mmci_request_end(), so it's not that simple.

> Since this is not the first occurance that you've had to do this with
> your board (the other being the SIC) I suggest that your board is
> faulty in some way, causing writes to registers to be occasionally
> dropped.

I can't 100% guarantee that it's not the case, but the problem has
been reproduced by at least 2 people on 2 different boards and on 2
different sides of the Atlantic. So I'd suspect there's either a SW
problem or a HW revision problem, at least.

Vitaly
