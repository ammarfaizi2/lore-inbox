Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbTIROGZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 10:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbTIROGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 10:06:25 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:273 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261337AbTIROGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 10:06:24 -0400
Date: Thu, 18 Sep 2003 15:05:09 +0100
From: Dave Jones <davej@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: richard.brunner@amd.com, alan@lxorguk.ukuu.org.uk, davidsen@tmr.com,
       zwane@linuxpower.ca, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-ID: <20030918140509.GM8764@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pavel Machek <pavel@ucw.cz>, richard.brunner@amd.com,
	alan@lxorguk.ukuu.org.uk, davidsen@tmr.com, zwane@linuxpower.ca,
	linux-kernel@vger.kernel.org
References: <99F2150714F93F448942F9A9F112634C0638B1DE@txexmtae.amd.com> <20030918074331.GA386@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030918074331.GA386@elf.ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 18, 2003 at 09:43:31AM +0200, Pavel Machek wrote:

 > > The user space problem worries me more, because the expectation
 > > is that if CPUID says the program can use perfetch, it could
 > > and should regardless of what the kernel decided to do here.
 > 
 > User programs should not rely on cpuid;

Depends. /dev/cpu/x/cpuid is preferred over cpuinfo, as it remains
constant across kernel versions.

 > they should read /proc/cpuinfo exactly because this kind of errata.

We don't do any change to /proc/cpuinfo in this case. As I mentioned
in an earlier mail, the only way you could disable prefetch in this way
would be by reporting the entire sse/3dnow instruction sets as unavailable
which is overkill.

With Andi's fix, userspace programs doing prefetch get fixed up
transparently, making this a non-issue.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
