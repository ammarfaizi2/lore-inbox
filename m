Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbVD0Fe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbVD0Fe2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 01:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVD0Fe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 01:34:27 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:29862 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261558AbVD0FeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 01:34:23 -0400
Subject: Re: [PATCH scsi-misc-2.6 01/04] scsi: make scsi_send_eh_cmnd use
	its own timer instead of scmd->eh_timeout
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Tejun Heo <htejun@gmail.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <426EF781.6040403@gmail.com>
References: <20050419143100.E231523D@htj.dyndns.org>
	 <20050419143100.0F9A8C3B@htj.dyndns.org>
	 <1114381342.4786.17.camel@mulgrave>  <426C2FC3.4090105@gmail.com>
	 <1114452544.5000.11.camel@mulgrave>  <426EF781.6040403@gmail.com>
Content-Type: text/plain
Date: Tue, 26 Apr 2005 22:34:19 -0700
Message-Id: <1114580059.5039.6.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-27 at 11:22 +0900, Tejun Heo wrote:
>  * A command is passed to lldd and starts execution
>  * It times out.
>  * eh runs
>  * abort isn't implemented or fails
>  * eh issues eh cmd (TUL, STU...)
>  * The command miraculously & stupidly completes just now.

This should be impossible.  The error handler API requirement is that
the driver relinquish a command once it returns success from any error
handling callback ... and if it never returns success, we simply offline
the device and never use it again.  This is the principle behind the
command reuse: we only try an additional command *after* error handling
succeeds, so the error handler now owns the command absolutely.

>  * The lldd succeeds to delete timer and normal completion path runs.
>  * We're fucked up now.

James


