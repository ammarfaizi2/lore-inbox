Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVFHRED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVFHRED (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 13:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVFHRCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 13:02:12 -0400
Received: from stark.xeocode.com ([216.58.44.227]:17078 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S261386AbVFHRAN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 13:00:13 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg Stark <gsstark@mit.edu>, linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: SMART support for libata
References: <87y8g8r4y6.fsf@stark.xeocode.com> <41B7EFA3.8000007@pobox.com>
In-Reply-To: <41B7EFA3.8000007@pobox.com>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 08 Jun 2005 12:59:40 -0400
Message-ID: <87br6g6ayr.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FWIW here's a report of a bit of a problem with libata-dev and SMART support.
I'm not actually clear whether this is the fault of libata or the traditional
IDE drivers though.

I built 2.6.12rc4 with 2.6.11-bk6-libata-dev1.patch applied. 
(I had to fix up a couple things that didn't apply against 2.6.12)

I updated to 5.33 per someone's suggestion on the mailing list and SMART
support started working. Yay. At that point I noticed my old PATA drive was
getting really hot so I put it to sleep with "hdparm -Y".

Now whenever smartd probes that drive my system freezes for a few seconds and
I get this in my syslog:

Jun  8 12:49:36 stark kernel: hda: status timeout: status=0xd0 { Busy }
Jun  8 12:49:36 stark kernel: 
Jun  8 12:49:36 stark kernel: ide: failed opcode was: 0xe5

I'm fine with failing to get SMART info from a sleeping drive. I'm not clear
whether it's actually possible to get data back or not though it would be nice
to know how much sleeping is lowering the drive temperature. But freezing the
machine is unkind.

-- 
greg

