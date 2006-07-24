Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbWGXQd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbWGXQd3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 12:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWGXQd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 12:33:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:2954 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751405AbWGXQd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 12:33:28 -0400
Subject: Re: CFQ will be the new default IO scheduler - why?
From: Arjan van de Ven <arjan@infradead.org>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <200607241857.43399.a1426z@gawab.com>
References: <200607241857.43399.a1426z@gawab.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 24 Jul 2006 18:33:26 +0200
Message-Id: <1153758806.3043.55.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Should there be a default scheduler per filesystem?  As some filesystems
> > may perform better/worse with one over another?
> 
> It's currently perDevice, and should probably be extended to perMount.

Hi,

per mount is going to be "not funny". I assume the situation you are
aiming for is the "3 partitions on a disk, each wants its own elevator".
The way the kernel currently works is that IO requests the filesystem
does are first flattened into an IO for the entire device (eg the
partition mapping is done) and THEN the IO scheduler gets involved to
schedule the IO on a per disk basis.
The 2.4 kernel did this the other way around, and it was really a bad
idea (no fairness, less optimal scheduling all around due to less
visibility into what the disk is really doing, several hardware
properties such as TCQ depth that affect scheduling IOs are truely per
disk not per partition etc etc)

So I don't think it's likely that per mount is really an option right
now..

Greetings,
   Arjan van de Ven

--
if you want to mail me at work, send mail to arjan (at) linux.intel.com

