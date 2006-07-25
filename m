Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWGYJj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWGYJj2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 05:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWGYJj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 05:39:28 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:53186 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S932248AbWGYJj1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 05:39:27 -0400
Subject: [PATCH 0/2] blk request timeout handler: mv scsi timer code to
	block layer
From: Mike Christie <michaelc@cs.wisc.edu>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, axboe@suse.de
Content-Type: text/plain
Date: Tue, 25 Jul 2006 05:39:37 -0400
Message-Id: <1153820377.4166.22.camel@max>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the request based multipath I thought I would need to run some code
when a command times out. I did not want to duplicate the scsi code, so
I did the following patches which move the scsi timer code to the block
layer then convert scsi.

I have tested the scsi_error.c and normal paths with iscsi. And, I have
tested the normal IO paths with libata. Since libata uses the strategy
handler it needs to be tested a lot more. Some of the drivers that were
touching the timeout_per_command field need to be compile tested still
too. I converted them, but I think some still need a "#include
blkdev.h".

The patches only move the scsi timer code to the block layer and hook it
in so others can use it. I have not started on the abort, reset and
quiesce code since it is not really needed for multipath. I wanted to
see if the timer code move was ok on its own without the rest of the
scsi eh move because I do not want to manage the patches out of tree
with the other request multipath patches. I also wanted to check if the
scsi timer code was ok in general. Maybe scsi got it wrong and needed to
be rewritten :)

Both patches were made over 2.6.18-rc2.

