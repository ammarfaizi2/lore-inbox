Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbVKSPa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVKSPa1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 10:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbVKSPa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 10:30:27 -0500
Received: from mail.gondor.com ([212.117.64.182]:54023 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S1750700AbVKSPa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 10:30:27 -0500
Date: Sat, 19 Nov 2005 16:30:24 +0100
From: Jan Niehusmann <jan@gondor.com>
To: Bart Samwel <bart@samwel.tk>
Cc: linux-kernel@vger.kernel.org, Zhu Yi <yi.zhu@intel.com>
Subject: Re: Laptop mode causing writes to wrong sectors?
Message-ID: <20051119153024.GB4725@knautsch.gondor.com>
References: <20051116181612.GA9231@knautsch.gondor.com> <20051117223340.GD14597@elf.ucw.cz> <437E215E.30500@tmr.com> <20051118232019.GA2359@spitz.ucw.cz> <437EE4B3.2090408@samwel.tk> <20051119140527.GA4725@knautsch.gondor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051119140527.GA4725@knautsch.gondor.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2005 at 03:05:28PM +0100, Jan Niehusmann wrote:
> That's interesting. Both Bradley and me are using ipw2200, an in the
> madwifi thread, one person also mentions he is using this driver. I
> don't know if madwifi and ipw2200 use common or very similar code. But
> perhaps this problem really is caused by a combination of laptop
> mode / disk spinup and certain wireless drivers?

Perhaps this one is related?

http://bughost.org/bugzilla/show_bug.cgi?id=821

If the corruption caused by this bug could lead to the filesystem
corruption I observed, it would match my observations quite well:

- Corruption started shortly after I upgraded to a kernel with 
  ipw2200 driver version 1.0.8
- Happens when using wireless
- File system corruption happens with laptop mode (because then the
  probability that dirty pages which will be written to disk later can
  be overwritten before the write actually happens is much higher)
- Problem is difficult to reproduce, as it's not deterministic which
  type of data structure gets overwritten, and it can happen only once
  per reboot (or driver reload)

Question is, could this bug cause filesystem corruption without any Oops
visible in the kernel log? Cc: to Zhu Yi at Intel - can you answer this
question?

Jan

