Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbVK3K64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbVK3K64 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 05:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbVK3K64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 05:58:56 -0500
Received: from nproxy.gmail.com ([64.233.182.193]:29145 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751139AbVK3K6z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 05:58:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o5Kjb/lWoiI6O2EBnxvGzuPwbyFkj0udnWb4ncY07uXPE7x938Dmbemg3UZ/N7kY55btIcKxqUfhbQof58AC+9aqVuaynMBLwUI/chFyyxIvSDcbpPOJLbqZSyI2KtslVYoWe0bCZw6NqpQpx7cKqKruen+4h8uCqE7J8peqccU=
Message-ID: <58cb370e0511300258w21b21e7bp3fca5a38b68be3ad@mail.gmail.com>
Date: Wed, 30 Nov 2005 11:58:51 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH linux-2.6-block:post-2.6.15 09/11] blk: implement ide_driver_t->protocol_changed callback
Cc: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051124162449.28818B0D@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051124162449.209CADD5@htj.dyndns.org>
	 <20051124162449.28818B0D@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/05, Tejun Heo <htejun@gmail.com> wrote:
> 09_blk_ide-add-protocol_changed.patch
>
>         This patch implements protocol_changed callback for IDE HL
>         drivers.  The callback is called whenever transfer protocol
>         changes (DMA / multisector PIO / PIO).  The callback is
>         sometimes with context and sometimes without, sometimes with
>         queuelock, sometimes not.  So, actual callbacks should be
>         written carefully.
>
>         To hook dma setting changes, this function implements
>         ide_dma_on() and ide_dma_off_quietly() which notifies protocl
>         change and calls low level driver callback.  __ide_dma_off()
>         is renamed to ide_dma_off() for consistency.  All dma on/off
>         operations must be done by using these wrapper functions.
>
> Signed-off-by: Tejun Heo <htejun@gmail.com>

NACK

Please fix the real problem instead
(changing of DMA and multicount PIO settings is racy).

Bartlomiej
