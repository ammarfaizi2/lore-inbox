Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWFOAyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWFOAyE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 20:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWFOAyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 20:54:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10191 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750743AbWFOAyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 20:54:02 -0400
Date: Wed, 14 Jun 2006 17:53:08 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: rmk+lkml@arm.linux.org.uk, gregkh@suse.de, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       zaitcev@redhat.com
Subject: Re: Serial-Core: USB-Serial port current issues.
Message-Id: <20060614175308.877cf6a0.zaitcev@redhat.com>
In-Reply-To: <20060614173824.60d1bc2e@doriath.conectiva>
References: <20060613192829.3f4b7c34@home.brethil>
	<20060614152809.GA17432@flint.arm.linux.org.uk>
	<20060614173824.60d1bc2e@doriath.conectiva>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2006 17:38:24 -0300, "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br> wrote:

>  I think BUG_ON(in_interrupt()) does the job. I'll try it here, and
> if it doesn't trigger I'll submit a patch to Andrew only for
> testing porpuses (ie, not for mainline).

Luiz, you can't be serious! You have to do a review and write call paths
on a piece of paper or however you prefer to do it. Your testing is
extremely limited as we know, you don't even have a null-modem cable.
So if the patch does not trip in your testing it tells you absolutely
nothing. But even in context of AKPM's tree you can't rely on run-time
checks to pick this sort of things.

And putting a BUG in there is irresponsible too. It's such a critical
subsystem. Drop bytes or return zero modem lines, but do not bug out.

-- Pete
