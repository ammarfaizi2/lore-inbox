Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268174AbUBRWDE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 17:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268232AbUBRWDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 17:03:03 -0500
Received: from [202.65.75.150] ([202.65.75.150]:60038 "EHLO
	pythia.bakeyournoodle.com.") by vger.kernel.org with ESMTP
	id S268174AbUBRWDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 17:03:00 -0500
From: Tony Breeds <tony@bakeyournoodle.com>
Date: Thu, 19 Feb 2004 05:58:46 +0800
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.2: "-" or "_", thats the question
Message-ID: <20040218215846.GI2681@bakeyournoodle.com>
Mail-Followup-To: Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <1o903-5d8-7@gated-at.bofh.it> <1pkw6-3BU-3@gated-at.bofh.it> <1prnS-4x8-1@gated-at.bofh.it> <402F8A00.8030501@uchicago.edu> <40306F65.8060702@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40306F65.8060702@t-online.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 16, 2004 at 08:21:09AM +0100, Harald Dunkel wrote:

> I know. But this requires some very ugly workarounds outside
> of module-init-tools. For example, if you want to check
> whether a module $module_name has already been loaded, you
> cannot use
> 
>     grep -q "^${module_name} " /proc/modules
>
> Instead you have to use a workaround like
> 
>     x="`echo $module_name | sed -e 's/-/_/g'`"
>     cat /proc/modules | sed -e 's/-/_/g' | grep -q "^${x} "
> 
> This is inefficient and error-prone.
> 
> Maybe somebody has another idea for the workaround,
> but I like the first version.

just run modprobe?  Then you don't have to care.

IN_KERNEL=$(/sbin/modprobe -vn "${module_name}")
if [ -z "${IN_KERNEL}" ; then
	/bin/echo "Module: ${module_name} is in the kernel"
else
	/bin/echo "Module: ${module_name} would need to be loaded"
	/bin/echo "${IN_KERNEL}"
fi

Or similar.  Yeah it's a little ugly but only as prone to failure as
module-init-tools

Yours Tony

        linux.conf.au       http://lca2005.linux.org.au/
	Apr 18-23 2005      The Australian Linux Technical Conference!

