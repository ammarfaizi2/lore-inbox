Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbWARRXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbWARRXd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 12:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWARRXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 12:23:33 -0500
Received: from mx.pathscale.com ([64.160.42.68]:34501 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751391AbWARRXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 12:23:33 -0500
Subject: Re: Why is wmb() a no-op on x86_64?
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Jes Sorensen <jes@sgi.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <yq04q41qxcw.fsf@jaguar.mkp.net>
References: <1137601417.4757.38.camel@serpentine.pathscale.com>
	 <200601181729.36423.ak@suse.de>
	 <1137603169.4757.50.camel@serpentine.pathscale.com>
	 <yq04q41qxcw.fsf@jaguar.mkp.net>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Wed, 18 Jan 2006 09:23:27 -0800
Message-Id: <1137605007.4757.57.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 12:06 -0500, Jes Sorensen wrote:

> A job for mmiowb() perhaps?

That might be suitable.  It's a no-op on most platforms, but it's only
used by a handful of drivers:

        drivers/scsi/qla1280.c
        drivers/sn/ioc4.c
        drivers/net/bnx2.c
        drivers/net/sky2.c
        drivers/net/s2io.c
        drivers/net/tg3.c

If the semantics were to change so that it really did a write barrier, I
doubt any existing users would notice.  In fact, based on the comments
in some drivers, at least some authors think it does already, when it
typically doesn't.

	<b

