Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbVBIIRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbVBIIRz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 03:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbVBIIRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 03:17:41 -0500
Received: from smtp08.web.de ([217.72.192.226]:44680 "EHLO smtp08.web.de")
	by vger.kernel.org with ESMTP id S261801AbVBIIRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 03:17:37 -0500
Message-ID: <4209C71F.9040102@web.de>
Date: Wed, 09 Feb 2005 09:17:35 +0100
From: Michael Renzmann <mrenzmann@web.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050205)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: How to retrieve version from kernel source (the right way)?
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

(Please CC: me, I'm not subscribed - although I'm following the list 
through gmane.org)

I'm working on Madwifi (a driver for wireless lan cards with Atheros 
chipset), which isn't part of the kernel (and probably won't ever be due 
to the binary-only HAL). As every third-party device driver madwifi 
needs to know which kernel version it is compiled for, at least for 
determining the proper location to install itself after compilation. 
But... what is the right way to do this?

We used to get the kernel version via "uname -r", but dropped that 
behaviour. Chances are good that one wants to build the driver for a 
kernel version other than the currently running kernel.

Then we started to grep VERSION, PATCHLEVEL, SUBLEVEL and EXTRAVERSION 
from the kernel's Makefile. This failed, since some distributors seem to 
use shell commands for at least one of those. Example from SuSE 9.1:
=== cut ===
VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 5
EXTRAVERSION = -$(shell echo $(CONFIG_RELEASE)-$(CONFIG_CFGNAME))
=== cut ===

Newer kernels also allow to set CONFIG_LOCALVERSION in .config.

It seems that include/linux/version.h holds the complete version 
information in UTS_RELEASE. Is it reliable to get the information from 
version.h? Or is there any other preferred method for this?

Bye, Mike
