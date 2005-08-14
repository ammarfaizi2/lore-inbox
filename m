Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbVHNOBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbVHNOBF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 10:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932530AbVHNOBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 10:01:05 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:36808 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932529AbVHNOBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 10:01:04 -0400
Subject: Re: IDE CD problems in 2.6.13rc6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Con Kolivas <kernel@kolivas.org>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200508141030.00382.kernel@kolivas.org>
References: <20050813232957.GE3172@redhat.com>
	 <200508141026.10734.kernel@kolivas.org>
	 <200508141030.00382.kernel@kolivas.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 14 Aug 2005 14:53:02 +0100
Message-Id: <1124027582.14138.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-08-14 at 10:30 +1000, Con Kolivas wrote:
> > presumably related, on 2.6.13-rc6. Putting in a cd and trying to read it
> > will cause huge delays and then error out with:
> >
> > ide-cd: cmd 0x28 timed out

(Thats READ_10)

> > hdc: DMA timeout retry
> > hdc: timeout waiting for DMA
> > hdc: status timeout: status=0xd0 { Busy }
> > ide: failed opcode was: unknown
> > hdc: drive not ready for command
> > hdc: ATAPI reset complete

So we asked the drive to do a read and it stayed busy - possibly from
some previous command. In a lot of cases you see the command *after* the
one that broke it. The reset then recovered the drive.


> Even though it apparently works fine I do get these instead though:
> hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> hdc: drive_cmd: error=0x04 { AbortedCommand }
> ide: failed opcode was: 0xec

Thats somewhere between bizarre and fascinating.

