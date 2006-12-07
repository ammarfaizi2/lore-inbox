Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163376AbWLGVPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163376AbWLGVPO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 16:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163377AbWLGVPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 16:15:13 -0500
Received: from hancock.steeleye.com ([71.30.118.248]:46341 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1163376AbWLGVPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 16:15:12 -0500
Subject: Re: Infinite retries reading the partition table
From: James Bottomley <James.Bottomley@SteelEye.com>
To: ltuikov@yahoo.com
Cc: Andrew Morton <akpm@osdl.org>, mdr@sgi.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <367656.23632.qm@web31810.mail.mud.yahoo.com>
References: <367656.23632.qm@web31810.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Thu, 07 Dec 2006 15:15:03 -0600
Message-Id: <1165526103.4698.50.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-07 at 11:14 -0800, Luben Tuikov wrote:
> It is.  If good_bytes=0 then nothing is up to date and uptodate should
> be set to 0.

That's not a correct assumption.  Zero transfer commands, like TEST UNIT
READY are perfectly happy to complete successfully with good_bytes == 0.

> Look at my comment before the function call:
>    /* A number of bytes were successfully read. ...
> 
> I repeat again: it doesn't make sense to call scsi_end_request
> with uptodate=1 and good_bytes=0, since _no bytes are uptodate_.

We can certainly debate that, but it's not appropriate to do it as part
of an unrelated patch.

James


