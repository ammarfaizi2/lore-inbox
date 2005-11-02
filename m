Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbVKBG1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbVKBG1H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 01:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVKBG1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 01:27:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45989 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932346AbVKBG1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 01:27:06 -0500
Date: Wed, 2 Nov 2005 16:26:53 +1100
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, dthompson@lnxi.com
Subject: Re: PATCH: EDAC - clean up atomic stuff
Message-Id: <20051102162653.4f0b8054.akpm@osdl.org>
In-Reply-To: <m18xw88thu.fsf@ebiederm.dsl.xmission.com>
References: <1129902050.26367.50.camel@localhost.localdomain>
	<m164rhbnyk.fsf@ebiederm.dsl.xmission.com>
	<1130772628.9145.35.camel@localhost.localdomain>
	<m1oe55abm4.fsf@ebiederm.dsl.xmission.com>
	<20051031120254.4579dc9a.akpm@osdl.org>
	<m18xw88thu.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
> Hmm.  Looking at the patch it is most definitely being called from
>  process context.

Well if we retain KM_BOUNCE_READ then we'll need local_irq_save().  If
edac_mc_scrub_block() will alwyas be called from process context then we
can use KM_USER0 and leave interrupts enabled.

Alan, can you confirm please?

