Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269400AbUICPWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269400AbUICPWK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 11:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269496AbUICPRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 11:17:50 -0400
Received: from the-village.bc.nu ([81.2.110.252]:14996 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269075AbUICPMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 11:12:39 -0400
Subject: Re: Crashed Drive, libata wedges when trying to recover data
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Brad Campbell <brad@wasp.net.au>
Cc: Greg Stark <gsstark@mit.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <413868CE.7070303@wasp.net.au>
References: <87oekpvzot.fsf@stark.xeocode.com>
	 <4136E277.6000408@wasp.net.au> <87u0ugt0ml.fsf@stark.xeocode.com>
	 <413868CE.7070303@wasp.net.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094220595.7923.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 03 Sep 2004 15:09:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-03 at 13:51, Brad Campbell wrote:
> Yep.. About 30 seconds per sector is the timeout whereas with 2.6.6 it would never do anything after 
> the first timeout. Yes it's slow, yes it could probably be sped up but it is certainly indicative of 
> a dodgy disk.
> 
> Use something like http://www.kalysto.org/utilities/dd_rhelp/index.en.html and you might have better 
> results.
> 
> Jeff, do we really have to wait 30 seconds for a timeout? If the drive hits an unreadble spot I 
> would have thought it would come back to us with a read error rather than timing out the command.

The drive will retry for a few seconds then fail. The failure now
generates a SCSI medium error to the core scsi layer and it does like to
issue a few retries. The default retry count for scsi is probably too
high for SATA given the drive retries.

