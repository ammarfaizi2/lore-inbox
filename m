Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965107AbWBHVYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965107AbWBHVYT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 16:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965111AbWBHVYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 16:24:19 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:12737 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S965107AbWBHVYS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 16:24:18 -0500
Date: Wed, 8 Feb 2006 14:24:16 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Jes Sorensen'" <jes@sgi.com>, Alex Williamson <alex.williamson@hp.com>,
       "Luck, Tony" <tony.luck@intel.com>, Adrian Bunk <bunk@stusta.de>,
       Keith Owens <kaos@sgi.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let IA64_GENERIC select more stuff
Message-ID: <20060208212416.GA1593@parisc-linux.org>
References: <43EA4557.6070107@sgi.com> <200602081955.k18Jtug12275@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602081955.k18Jtug12275@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 11:55:58AM -0800, Chen, Kenneth W wrote:
> CONFIG_IA64_GENERIC select CONFIG_ACPI, and CONFIG_ACPI select CONFIG_PCI,
> This whole thread is silly since the beginning and it is a moot point for
> all of previous discussions.  What are we talking about exactly??

I think the problem is that ia64 is abusing the 'select' feature.
Select is a reverse dependency.  It should be used to turn things on
which are required for this option to work.  Right now, the generic
config uses it to turn on things which people think you probably want
if you're building a generic kernel.

IMO, the select statements should be deleted.  They make it impossible to
build a generic kernel without ACPI or NUMA.  While both are ubiquitous
in ia64 implementations, they really aren't mandatory.
