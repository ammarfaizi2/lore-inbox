Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263870AbTLFSd1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 13:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265227AbTLFSd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 13:33:27 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:24963
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263870AbTLFSd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 13:33:26 -0500
Date: Sat, 6 Dec 2003 13:32:23 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Michael J. Cohen" <mjc@325i.org>
cc: gijoe@poczta.onet.pl, linux-kernel@vger.kernel.org
Subject: RE: OOPS - ide-scsi bug - SCSI BUS number increasing
In-Reply-To: <S265224AbTLFSHu/20031206180750Z+1571@vger.kernel.org>
Message-ID: <Pine.LNX.4.58.0312061329100.10548@montezuma.fsmlabs.com>
References: <S265224AbTLFSHu/20031206180750Z+1571@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Dec 2003, Michael J. Cohen wrote:

> There is a bug in ide-scsi module (kernel version 2.6.0-test10 with enabled
> preemptible kernel) - this bug causes SCSI BUS number to be increased by one
>
> everytime ide-scsi module is reloaded  (modprobe -r ide-scsi then
> do modprobe ide-scsi) - it is easy to spot that with cdrecord -scanbus.
> This bug doesn't appear to exist in 2.4 kernel series, I've not tested this
> with 2.5 series though, this is not cdrtools fault since I tried both
> versions
> (2.00 and 2.00.3) with the same result.When ide-scsi is compiled into the
> kernel, obviously the SCSI BUS number doesn't increase since there is no
> possibility to reload it during the same kernel session.

This happens with all SCSI drivers, check;

scsi_host_alloc() {
	...
	shost->host_no = scsi_host_next_hn++; /* XXX(hch): still racy */
	...
}

So it's fine.
