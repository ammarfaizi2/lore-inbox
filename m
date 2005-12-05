Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbVLER2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbVLER2N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 12:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbVLER2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 12:28:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8678 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932477AbVLER2K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 12:28:10 -0500
Date: Mon, 5 Dec 2005 12:27:54 -0500
From: Dave Jones <davej@redhat.com>
To: Avi Kivity <avi@argo.co.il>
Cc: Lee Revell <rlrevell@joe-job.com>, Andi Kleen <ak@suse.de>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Andrew Morton <akpm@osdl.org>, cpufreq <cpufreq@www.linux.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CPU frequency display in /proc/cpuinfo
Message-ID: <20051205172754.GD12664@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Avi Kivity <avi@argo.co.il>, Lee Revell <rlrevell@joe-job.com>,
	Andi Kleen <ak@suse.de>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	Andrew Morton <akpm@osdl.org>, cpufreq <cpufreq@www.linux.org.uk>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20051202181927.GD9766@wotan.suse.de> <20051202104320.A5234@unix-os.sc.intel.com> <20051204164335.GB32492@isilmar.linta.de> <20051204183239.GE14247@wotan.suse.de> <1133725767.19768.12.camel@mindpipe> <20051205011611.GA12664@redhat.com> <43946ACE.9040405@argo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43946ACE.9040405@argo.co.il>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 06:29:02PM +0200, Avi Kivity wrote:
 > Dave Jones wrote:
 > 
 > >I can't think of a single valid reason why a program would want
 > >to know the MHz rating of a CPU. Given that it's a) approximate,
 > >b) subject to change due to power management, c) completely nonsensical
 > >across CPU vendors, and d) only one of many variables regarding CPU
 > >performance, any program that bases any decision on the values found
 > >by parsing that field of /proc/cpuinfo is utterly broken beyond belief.
 > > 
 > >
 > Sometimes you need extremely low overhead time measurements, which need 
 > not be too accurate. One way to do this is to dump rdtsc measurements 
 > into some array, and later scale it using the cpu frequency.
 > 
 > I've done exactly this. The processes were pinned to their processors, 
 > and there was no frequency scaling in effect. It worked very well.

That code will break as soon as it's run on a CPU that uses P-states.
You can't "just scale" the value, there are other factors at work.

		Dave

