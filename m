Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262925AbVAFRed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbVAFRed (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 12:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262929AbVAFRec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 12:34:32 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:36795 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262925AbVAFReZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 12:34:25 -0500
Subject: Re: [2.6.10-bk7] Oops: ide_dma_timeout_retry
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Simon Kirby <sim@netnation.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050105233359.GA2327@netnation.com>
References: <20050105233359.GA2327@netnation.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105023683.24896.213.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 06 Jan 2005 16:30:14 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-01-05 at 23:33, Simon Kirby wrote:
> I added the usual test for NULL, printk, goto out, and the machine
> continues without visibly exploding when this case occurs.  Is the
> correct fix or is it expected that rq should never be NULL?

The initial UncorrectableError is the drive erroring the request due to
real failure of the drive to get the data. There are some races in the
base code when that occurs

rq should never be NULL at that point because after all there has to be
a request which has timed out. If the timeout isn't being cleared on the
error path that would make sense of the trace or if the timeout occurred
at the same time as the error completed it would have raced.

It could also be due to the fact base 2.6.10 will corrupt requests on
errors sometimes (which SGI now fixed)

Alan

