Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267923AbUI1P3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267923AbUI1P3n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 11:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267974AbUI1P3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 11:29:42 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:51092 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S267936AbUI1P3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 11:29:40 -0400
To: Paul Jackson <pj@sgi.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
References: <1096302710971@topspin.com> <10963027102899@topspin.com>
	<20040927131014.695b8212.pj@sgi.com> <52fz53e526.fsf@topspin.com>
	<20040927234333.7cceff47.pj@sgi.com>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 28 Sep 2004 08:29:39 -0700
In-Reply-To: <20040927234333.7cceff47.pj@sgi.com> (Paul Jackson's message of
 "Mon, 27 Sep 2004 23:43:33 -0700")
Message-ID: <52mzzacsyk.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH][1/2] [RESEND] kobject: add HOTPLUG_ENV_VAR
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 28 Sep 2004 15:29:39.0861 (UTC) FILETIME=[F8479450:01C4A56F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your patch is buggy:

+	length += snprintf (buffer + length, max(buffer_size - length, 0),
 			    "DEVICE=/proc/bus/usb/%03d/%03d",
 			    usb_dev->bus->busnum, usb_dev->devnum);

snprintf() returns the number of characters that would be written not
counting the trailing NUL.  So the next env var is going to be
concatenated with this one.

It's precisely this sort of easy-to-make off-by-one bug that convinces
me the hotplug environment variable handling needs to be wrapped up in
a helper macro or function.

Thanks,
  Roland
