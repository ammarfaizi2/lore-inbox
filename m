Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbUKOMLB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbUKOMLB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 07:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbUKOMLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 07:11:01 -0500
Received: from mailfe05.swip.net ([212.247.154.129]:61103 "EHLO
	mailfe05.swip.net") by vger.kernel.org with ESMTP id S261578AbUKOMK5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 07:10:57 -0500
X-T2-Posting-ID: 2Ngqim/wGkXHuU4sHkFYGQ==
Subject: Re: x86: only single-step into signal handlers if the tracer
From: Alexander Nyberg <alexn@dsv.su.se>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
In-Reply-To: <20041114184456.6bfd07d3.akpm@osdl.org>
References: <200411150203.iAF23Trb024677@hera.kernel.org>
	 <41981266.2070707@pobox.com>  <20041114184456.6bfd07d3.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 15 Nov 2004 13:10:49 +0100
Message-Id: <1100520649.657.9.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This reminds me of a problem I am seeing under recent -bk kernels.
> > 
> > Mozilla (FC2) will freeze (no screen redraws, etc.).  'ps xf' shows 
> > mozilla sleeping.  If I strace the process, Mozilla will un-freeze and 
> > continue as expected.
> > 
> 
> Presumably the futex thing:
> 

This patch seems to fix it for me, recently various programs have got
stuck in pthread_condition_wait (this on x86-64).

When that happened I did gdb --pid and then 'continue' which made it
wake up.

