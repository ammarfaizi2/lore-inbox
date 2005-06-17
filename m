Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbVFQMrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVFQMrp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 08:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbVFQMro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 08:47:44 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:23004 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261656AbVFQMrT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 08:47:19 -0400
Date: Fri, 17 Jun 2005 14:47:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Reiner Sailer <sailer@watson.ibm.com>
Cc: LKLM <linux-kernel@vger.kernel.org>,
       LSM <linux-security-module@mail.wirex.com>,
       Kylene Hall <kylene@us.ibm.com>, Emily Rattlif <emilyr@us.ibm.com>,
       Tom Lendacky <toml@us.ibm.com>, Greg KH <greg@kroah.com>,
       Chris Wright <chrisw@osdl.org>, Reiner Sailer <sailer@us.ibm.com>
Subject: Re: [PATCH] 2 of 5 IMA: documentation patch
Message-ID: <20050617124701.GA12863@elf.ucw.cz>
References: <1118845859.2269.17.camel@secureip.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118845859.2269.17.camel@secureip.watson.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> --- linux-2.6.12-rc6-mm1_orig/Documentation/ima/integrity_measurements.txt	1969-12-31 19:00:00.000000000 -0500
> +++ linux-2.6.12-rc6-mm1-ima/Documentation/ima/integrity_measurements.txt	2005-06-14 16:25:05.000000000 -0400
> @@ -0,0 +1,87 @@
> +The IBM Integrity Measurement Architecture (IMA) offers means to
> +securely identify the software that was loaded into a system run-time
> +since the last reboot. The IMA builds the information necessary to
> +identify the loaded software and provides the basis for services to
> +build on top of such information. However, it does not include any
> +means that would enable remote parties to extract the information
> +itself.
> +
> +Guarantees: IMA offers "software load-guarantees" in that
> +identification of all loaded software is guaranteed to be reflected in
> +measurement data and protected in a hardware TPM security chip (if
> +available). IMA is non-intrusive and neither disturbs the system, nor
> +prevents the system from any actions. However, if running in real
> +mode, when the TPM chip is not accessible IMA might require the system
> +not to start (for security guarantee reasons).
> +
> +Limitations: IMA does not detect corruption of software once it is
> +loaded into main memory. Instead, it indicates known vulnerabilities
> +in such software (e.g., buffer overflow) by securely identifying the
> +software at load-time. Only executable files (binaries, libraries,
> +kernel modules) are measured by default. However, IMA offers a
> +ima file system that enables applications to instruct the kernel to
> +measure files that they have opened (/ima/measurereq).
> +
> +Assumed usage: Verify system installed software configurations and
> +system run-time integrity from a secure management location.

You say that you must panic system if TPM is not acessible during
bootup. That smells just plain wrong. If I want to trick secure
managment point, what prevents me from booting kernel in "test" mode,
and then lie about it? 

> +Some of our work shows that IMA is very useful to detect Rootkit
> +exploits that totally take over the software of a Linux system but
> +cannot hide themselves from contributing to the TPM aggregate and this
> +will be detectable from a non-corrupted platform. While the corrupted
> +system might not show the Rootkit, a remote party can securely
> +identify known bad or unknown software having been loaded into the
> +system.

No; with your current system, it only means I may not place my rootkit
into executable file. I can still place my evil rootkit into shell
script and/or config file.

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
