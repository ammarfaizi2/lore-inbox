Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbVDJXTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbVDJXTd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 19:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbVDJXTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 19:19:25 -0400
Received: from hermes.domdv.de ([193.102.202.1]:65031 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261638AbVDJXTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 19:19:12 -0400
Message-ID: <4259B46D.9020402@domdv.de>
Date: Mon, 11 Apr 2005 01:19:09 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH encrypted swsusp 0/3] encrypted swsusp image
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches allow for encryption of the on-disk swsusp image
to prevent data gathering of e.g. in-kernel keys or mlocked data after
resume.

For this purpose the aes cipher must be compiled into the kernel as
module load is not possible at resume time.

A random key is generated at suspend time, stored in the suspend header
on disk and deleted from the header at resume time. If you don't resume
a mkswap on the suspend partition will also delete the temporary key.

Only the data pages are encrypted as only these may contain sensitive data.

This works on my x86_64 laptop (64bit mode) and probably needs testing
on other platforms.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de


