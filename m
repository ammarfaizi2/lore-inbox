Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268482AbUI2OPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268482AbUI2OPB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 10:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268457AbUI2OMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 10:12:53 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:27338 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S268447AbUI2OMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 10:12:07 -0400
Subject: Re: Core scsi layer crashes in 2.6.8.1
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <1096401785.13936.5.camel@localhost.localdomain>
References: <1096401785.13936.5.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 29 Sep 2004 10:11:59 -0400
Message-Id: <1096467125.2028.11.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-28 at 16:03, Alan Cox wrote:
> Second problem is with the scsi handling logic for errors. If you rmmod
> a scsi driver while it is error handling you get a chain of errors
> starting with
> 
> 	Illegal transition Cancel->Offline
> 	Badness is scsi_device_set_state
> 	path:
> 	scsi_device_set_state
> 	scsi_unjam_host
> 	scsi_error_handler
> 

These state transition warnings are currently expected in this code
(they're basically verbose warnings).

What was the oops?

I have a theory that we should be taking a device reference before
waking up the error handler, otherwise host removal can race with error
handling.

James


