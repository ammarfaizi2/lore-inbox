Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751543AbWGYJu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbWGYJu6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 05:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbWGYJu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 05:50:56 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:55490 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S1751541AbWGYJuz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 05:50:55 -0400
Message-ID: <44C5E98B.4040903@cs.wisc.edu>
Date: Tue, 25 Jul 2006 05:51:07 -0400
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: [PATCH 0/2] blk request timeout handler
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if this is a duplicate, I had some trouble with my mailer in the
middle if sending the patches.

The following patches move the scsi command timeout code from the scsi
layer to the block layer. I originally did them so request based
multipath could reuse the code, but the code can be used by anyone so I
thought I should send it seperately.

I have tested the normal and error paths with iscsi and am in the middle
of testing the libata error paths. The latter needs more care since it
is the only strategy handler user. I have also converted all the
timeout_per_command users but some of the LLDs still need a "#include
blkdev.h".

So the patches are not ready for mergingm but I wanted to get feedback
on the scsi timer code and if it was accpetable or was it not so nice?
And I wanted to see if these patches were ok alone or if all the scsi eh
needed to be moved at the same time. These patches do not move the
quiesce, abort or reset code.
