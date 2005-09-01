Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbVIAIsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbVIAIsj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 04:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbVIAIsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 04:48:39 -0400
Received: from isilmar.linta.de ([213.239.214.66]:15286 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1750740AbVIAIsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 04:48:38 -0400
Date: Thu, 1 Sep 2005 10:48:31 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] acpi-cpufreq: Remove P-state read after a P-state write in normal path
Message-ID: <20050901084831.GA6285@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Len Brown <len.brown@intel.com>
References: <20050826171052.B27226@unix-os.sc.intel.com> <20050828180941.GB28994@isilmar.linta.de> <20050829110357.A14724@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050829110357.A14724@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 29, 2005 at 11:03:57AM -0700, Venkatesh Pallipadi wrote:
> Yes. ACPI spec says transitions can fail. But, it doesn't fail often in 
> practise. And even if it fails, I think, we should handle it without this 
> read os STATUS register.

How can we handle it, if we do not even know that it failed? How should the
user recognize something is broken?

> The speedstep-centrino driver, which does similar
> thing as acpi-cpufreq, does not do this status check after control MSR write.
> We can skip the read of STATUS in cpi-cpufreq in a similar way. No?

Well, regarding speedstep-centrino, it is news to me that the MSR write can
fail... if it can fail, we should check for it.

> And reading the STATUS in a loop should go away. I don't see that it being 
> mentioned in ACPI spec. The 1mS loop seems totally redundant.

It looks to me as somebody had experienced that the transition only
succeeded after waiting for some time.

But well, as you do know the ACPI spec better than I do, I'll accept your
evaluation that this patch won't cause any trouble.

	Dominik
