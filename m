Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265342AbTFMKpE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 06:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265346AbTFMKpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 06:45:04 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:56145 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S265342AbTFMKo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 06:44:58 -0400
Date: Fri, 13 Jun 2003 03:58:45 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: cryptoapi 2.5->2.4 backport
Message-ID: <20030613035845.A27655@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any problem with just changing crypto/cipher.c:

    enum km_type crypto_km_types[] = {
            KM_USER0,
            KM_USER1,
            KM_SOFTIRQ0,
            KM_SOFTIRQ1,
    };

to

    enum km_type crypto_km_types[] = {
            KM_USER0,
            KM_USER1,
            KM_USER0,
            KM_USER1,
    };

?

(or the equivalent change in crypto/internal.h)

static inline enum km_type crypto_kmap_type(int out)
{
        return crypto_km_types[(in_softirq() ? 2 : 0) + out];
}

static inline void *crypto_kmap(struct page *page, int out)
{
        return kmap_atomic(page, crypto_kmap_type(out));
}

thanks
/fc
