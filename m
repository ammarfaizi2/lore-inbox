Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161695AbWKEUF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161695AbWKEUF4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 15:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161693AbWKEUF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 15:05:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45773 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161690AbWKEUFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 15:05:55 -0500
Date: Sun, 5 Nov 2006 15:04:48 -0500
From: Dave Jones <davej@redhat.com>
To: Christian <christiand59@web.de>
Cc: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org
Subject: Re: [discuss] Linux 2.6.19-rc4: known unfixed regressions (v2)
Message-ID: <20061105200448.GE859@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Christian <christiand59@web.de>,
	Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>,
	Adrian Bunk <bunk@stusta.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-acpi@vger.kernel.org
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <454AFD01.4080306@linux.intel.com> <20061103155656.GA1000@redhat.com> <200611051832.13285.christiand59@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611051832.13285.christiand59@web.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2006 at 06:32:12PM +0100, Christian wrote:
 > Am Freitag, 3. November 2006 16:56 schrieb Dave Jones:
 > > On Fri, Nov 03, 2006 at 11:25:37AM +0300, Alexey Starikovskiy wrote:
 > >  > Could this be a problem?
 > >  > --------------------
 > >  > ...
 > >  > CONFIG_ACPI_PROCESSOR=m
 > >  > ...
 > >  > CONFIG_X86_POWERNOW_K8=y
 > >
 > > Hmm, possibly.  Christian, does it work again if you set them both to =y ?
 > 
 > Yes, it works now! Only the change to CONFIG_ACPI_PROCESSOR=y made it work 
 > again!

So, the reasoning behind this, is that we have this construct..

config X86_POWERNOW_K8_ACPI
    bool
    depends on X86_POWERNOW_K8 && ACPI_PROCESSOR
    depends on !(X86_POWERNOW_K8 = y && ACPI_PROCESSOR = m)
    default y


Which makes us use the ACPI stuff if it's there, otherwise not,
and in your case, it seems your system _needs_ this enabled
to make powernow work.

Thing is, this was there in 2.6.18 too, so strictly speaking,
we haven't regressed here, and you're getting exactly what you asked for.
The problem is that it's completely silent as to why it then fails.

I'm open to improvements, but I'm not sure what the right thing to do
here is.. opinions ?

	Dave

-- 
http://www.codemonkey.org.uk
