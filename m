Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbUCaOIo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 09:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbUCaOIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 09:08:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17896 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261976AbUCaOIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 09:08:41 -0500
Subject: Re: [PATCH] barrier patch set
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Chris Mason <mason@suse.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <4069F2FC.90003@pobox.com>
References: <20040319153554.GC2933@suse.de>
	 <200403201723.11906.bzolnier@elka.pw.edu.pl>
	 <1079800362.11062.280.camel@watt.suse.com>
	 <200403201805.26211.bzolnier@elka.pw.edu.pl>
	 <1080662685.1978.25.camel@sisko.scot.redhat.com>
	 <1080674384.3548.36.camel@watt.suse.com>
	 <1080683417.1978.53.camel@sisko.scot.redhat.com> <4069F2FC.90003@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1080742105.1991.40.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 31 Mar 2004 15:08:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2004-03-30 at 23:21, Jeff Garzik wrote:

> For IDE, O_DIRECT and O_SYNC can use special "FUA" commands, which don't 
> return until the data is on the platter.

fsync() is still really nasty, because that can require that we wait on
IO that was submitted by the VM before we knew that there was a
synchronous IO wait coming.  SCSI also has an FUA bit that can make a
difference if you've got writeback caching enabled.  (And FUA on read
can bypass drive writethrough caches, too, for media verification.)

--Stephen

