Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274879AbTGaV1l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 17:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274880AbTGaV1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 17:27:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:13721 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274879AbTGaV1Q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 17:27:16 -0400
Date: Thu, 31 Jul 2003 14:15:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: mru@users.sourceforge.net (=?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disk performance degradation
Message-Id: <20030731141517.0ceccc77.akpm@osdl.org>
In-Reply-To: <yw1xy8yf3xgz.fsf@users.sourceforge.net>
References: <20030729182138.76ff2d96.lista1@telia.com>
	<3F26A5E2.4070701@aros.net>
	<Pine.LNX.4.56.0307301658030.30842@router.windsormachine.com>
	<yw1xy8yf3xgz.fsf@users.sourceforge.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mru@users.sourceforge.net (Måns Rullgård) wrote:
>
> Mike Dresser <mdresser_l@windsormachine.com> writes:
> 
> > Probably for reasons like that.  For some reason, I can't set my ICH4
> > based controller(ASUS P4B533) and Quantum Fireball AS40.0 to more than
> > 255.  Kernel is 2.4.21
> 
> It appears that in 2.[56] kernels the unit for readahead is bytes,
> rather than sectors, as used in 2.4 kernels.

The ioctl which is used by

	blockdev --setra

is still in 512-byte units.

There are other backdoors such as IDE-private /proc files which can be used
to set readahead.  I'm not sure what units they use, and I don't know what
mechanism hdparm is using to diddle readahead.

Whatever it is, I suggest you ignore it and use /sbin/blockdev; it works
for all disk types.

