Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932520AbVKWVZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbVKWVZW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 16:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbVKWVZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 16:25:21 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:60804 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S932520AbVKWVZU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 16:25:20 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Duncan Sands <duncan.sands@free.fr>
Subject: speedtch driver, 2.6.14.2
Date: Wed, 23 Nov 2005 21:25:25 +0000
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511232125.25254.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Duncan,

I recently switched from the userspace speedtouch driver to the in-kernel one. 
However, on my rev 4.0 Speedtouch 330, I periodically get the message:

ATM dev 0: error -110 fetching device status

I suspect the source of this "error" is the warning message from speedtch:435:

	ret = speedtch_read_status(instance);
	if (ret < 0) {
		atm_warn(usbatm, "error %d fetching device status\n", ret);
		instance->poll_delay = min(2 * instance->poll_delay, MAX_POLL_DELAY);
		return;
	}

Tell me if I'm wrong, but I suspect speedtch_check_status() is called 
periodically to check line status. It may be the case that my modem does not 
like having its status read when it is sending/receiving data (which it is 
constantly doing).

Unfortunately the message eventually fills the dmesg ring buffer. My current 
workaround is to remove the atm_warn() call; everything works fine, but I'm 
concerned that the modem will not automatically reconnect if the connection 
drops as a result of the failure from speedtch_read_status().

Any suggestions for debugging this further? From a quick google I've noticed a 
recent Fedora bugzilla entry mentioning this same problem.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
