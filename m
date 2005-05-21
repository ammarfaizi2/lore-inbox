Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbVEUGQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbVEUGQV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 02:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbVEUGQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 02:16:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:17031 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261674AbVEUGQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 02:16:03 -0400
Date: Fri, 20 May 2005 23:02:36 -0700
From: Greg KH <greg@kroah.com>
To: Reiner Sailer <sailer@watson.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@mail.wirex.com,
       kylene@us.ibm.com, emilyr@us.ibm.com, toml@us.ibm.com
Subject: Re: [PATCH 2 of 4] ima: related Makefile compile order change and Readme
Message-ID: <20050521060236.GB24597@kroah.com>
References: <1116596180.8156.8.camel@secureip.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116596180.8156.8.camel@secureip.watson.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2005 at 09:36:20AM -0400, Reiner Sailer wrote:
> The IBM Integrity Measurement Architecture (IMA) builds information
> about the software that was loaded into a system run-time since the
> last reboot. For each loaded executable (binary, kernel module,
> library), the IMA calculates once a SHA1 value over the executable file 
> and stores it for later reference. IMA uses (optionally) the Trusted
> Computing Group Trusted Platform Module to protect the integrity of
> the accumulated measurements. IMA can, for example, be used to build 
> services that detect compromised malicious software loaded into the 
> runtime or can be used to validate expected system configurations.

Do you have any benchmarks with this code running in TPM and non-TPM
mode vs. normal operation?

Also, your coding style has some issues (spaces instead of tabs), {} for
one line if statements, etc.  Please fix them up.

Also DO NOT USE PROC!  Please use the proper kernel interfaces if you
wish to dump loads of statistics to userspace (your own filesystem,
sysfs, debugfs (hint, hint, hint...)

Also, there are a lot more virtual fs in the kernel than you are
checking against in your "don't care about these files" test.  You need
to have a comprehensive list if you want to get it correct.

thanks,

greg k-h
