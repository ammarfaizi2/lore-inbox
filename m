Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277534AbRJESLc>; Fri, 5 Oct 2001 14:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277535AbRJESLW>; Fri, 5 Oct 2001 14:11:22 -0400
Received: from suntan.tandem.com ([192.216.221.8]:51681 "EHLO
	suntan.tandem.com") by vger.kernel.org with ESMTP
	id <S277534AbRJESLH>; Fri, 5 Oct 2001 14:11:07 -0400
Message-ID: <3BBDF5B8.A6B649A3@compaq.com>
Date: Fri, 05 Oct 2001 11:02:32 -0700
From: John Byrne <john.l.byrne@compaq.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; UnixWare 5 i386)
MIME-Version: 1.0
To: Christoph Hellwig <hch@ns.caldera.de>
CC: linux-kernel@vger.kernel.org
Subject: Change in add_gendisk() in 2.4.11-preXXX
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Cristoph,

Looking in the Changelog for 2.4.11-pre, I find that you are given
credit for the change to add_gendisk() which should prevent the
/proc/paritions loop; which is good. However, I was tracing the bug
myself and come to the conclusion the culprit in my case was the "sd"
driver. One of our systems has two different SCSI HBAs and this resulted
in two calls to sd_finish() which results in the sd_gendisk structures
being added twice and, hence, the loop. So, I am a little concerned that
your change is covering up the problem so well, that the actual issue
may not be addressed. Unfortunately, I don't understand the ins and outs
of the SCSI and blkdev layers to suggest a fix for "sd".

So, my question to you or anyone is, is anyone looking further at the
causes of the problem right now?

John Byrne
