Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbVINUfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbVINUfW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 16:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbVINUfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 16:35:21 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:37602 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S964813AbVINUfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 16:35:19 -0400
Subject: Re: [2.6.14-rc1] sym scsi boot hang
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Anton Blanchard <anton@samba.org>, Dipankar Sarma <dipankar@in.ibm.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0509141052410.5064-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0509141052410.5064-100000@iolanthe.rowland.org>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 16:35:13 -0400
Message-Id: <1126730113.4825.12.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-14 at 11:49 -0400, Alan Stern wrote:
> (James, I see a possible problem with scsi_insert_special_req.  It adds to
> the queue a request with REQ_DONTPREP set.  How can such a request, with
> no associated scsi_cmnd, ever work?  Also, won't scsi_end_request and 
> __scsi_release_request end up putting the same scsi_command twice?)

It's a historical anomaly which will hopefully die when we finally
manage to get sg and st converted to the generic request infrastructure.
Then scsi_request can be killed and this along with it.

What used to happen (as the comment implies) is that drivers would
allocate a single request and then reuse it for multiple independent
commands.  Since they weren't too picky about cleaning it up after each
use, we had to reset the DONTPREP flag to ensure each new invocation was
actually correctly prepared.

James


