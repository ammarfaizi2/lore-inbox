Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbVL3PQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbVL3PQE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 10:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbVL3PQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 10:16:04 -0500
Received: from [81.2.110.250] ([81.2.110.250]:32682 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932204AbVL3PQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 10:16:03 -0500
Subject: Re: RAID controller safety
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kenny Simpson <theonetruekenny@yahoo.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051229162935.67301.qmail@web34106.mail.mud.yahoo.com>
References: <20051229162935.67301.qmail@web34106.mail.mud.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 30 Dec 2005 15:17:46 +0000
Message-Id: <1135955866.28365.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-12-29 at 08:29 -0800, Kenny Simpson wrote:
>   Specificly, I am looking at the Adaptec RAID controllers and their i2o drivers.  I am told the
> kernel's i2o driver lacks a strong guarantee on fsync, and so far am unable to determine if the
> dpt_i2o driver also falls short in this reguard.

Only dpt can tell you what their firmware actually does.

The i2o core drivers use the following rules

i2o_scsi issues SCSI commands and assumes they are pass through and that
the firmware does not fake completions early (or if it does that it
battery backs them). For the known hardware the i2o SCSI class interface
is a pass through interface with the card cpu just doing protocol gunk
and supervision

i2o_block by default assumes the card is caching. It adopts write
through mode if the controller has no battery, write back if it shows
battery. This can be configured differently via ioctls including the
ability to tune write through of large I/O's (to avoid cache thrashing),
and to do write back with no battery backup for performance in cases
where losing the data on a crash doesn't matter (eg swap)

Alan

