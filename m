Return-Path: <SRS0=T8Kb=DP=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C69C04EBE
	for <io-uring@archiver.kernel.org>; Thu,  8 Oct 2020 14:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8060321927
	for <io-uring@archiver.kernel.org>; Thu,  8 Oct 2020 14:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TaI/iEjk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730726AbgJHO4U (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 8 Oct 2020 10:56:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40845 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730721AbgJHO4U (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 8 Oct 2020 10:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602168979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GRXQSa6ZC+nnaEc4pw80e/cx2CLDkgRRUVhzsvrA1kM=;
        b=TaI/iEjkJ9S8vvjhBft/yenqID+/czLoF7Atjwjs/N07AFW9Uz9Vw8UWVww2OFlf0vjVqi
        nihc/NWSgornBWCP3+tx9eDXHA8qYB4IbloY2ua0xcihOrBOesoCVfJYXusb2bsiIoZGCq
        +OrkP7Yp4KRppGNPkze9e2iEWMVO9Ns=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-TTlEaReGNDirHxMkhKntvA-1; Thu, 08 Oct 2020 10:56:16 -0400
X-MC-Unique: TTlEaReGNDirHxMkhKntvA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19C8F10BBEC3;
        Thu,  8 Oct 2020 14:56:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.132])
        by smtp.corp.redhat.com (Postfix) with SMTP id B186610013C1;
        Thu,  8 Oct 2020 14:56:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  8 Oct 2020 16:56:14 +0200 (CEST)
Date:   Thu, 8 Oct 2020 16:56:11 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de
Subject: Re: [PATCHSET RFC v3 0/6] Add support for TIF_NOTIFY_SIGNAL
Message-ID: <20201008145610.GK9995@redhat.com>
References: <20201005150438.6628-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005150438.6628-1-axboe@kernel.dk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 10/05, Jens Axboe wrote:
>
> Hi,
>
> The goal is this patch series is to decouple TWA_SIGNAL based task_work
> from real signals and signal delivery.

I think TIF_NOTIFY_SIGNAL can have more users. Say, we can move
try_to_freeze() from get_signal() to tracehook_notify_signal(), kill
fake_signal_wake_up(), and remove freezing() from recalc_sigpending().

Probably the same for TIF_PATCH_PENDING, klp_send_signals() can use
set_notify_signal() rather than signal_wake_up().

Oleg.

