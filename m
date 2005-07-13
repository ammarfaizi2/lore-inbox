Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262458AbVGMBbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbVGMBbk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 21:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbVGMBbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 21:31:40 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:8121 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262471AbVGMBa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 21:30:29 -0400
Message-ID: <42D46F58.4070900@jp.fujitsu.com>
Date: Wed, 13 Jul 2005 10:33:12 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH 2.6.13-rc1 03/10] IOCHK interface for I/O error handling/detecting
References: <42CB63B2.6000505@jp.fujitsu.com> <42CB664E.1050003@jp.fujitsu.com> <20050712195120.GE26607@austin.ibm.com>
In-Reply-To: <20050712195120.GE26607@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas wrote:
> Thus, one wouldn't want to perform an iochk_read() in this way unless
> one was already pretty sure that an error had already occured ... 

If another kind of I/O error detecting system finds a error before
performing iochk_read(), it can prevents coming iochk_read() from
spending such crazy cycles in have_error() by marking cookie->error.

 >> int iochk_read(iocookie *cookie)
 >>  {
 >> +	if (cookie->error || have_error(cookie->dev))

Isn't it enough?

And as Ben said, it seems that ppc64 can have its own special iochk_*,
unless calling pci_read_config_word() ;-)

Thanks,
H.Seto

