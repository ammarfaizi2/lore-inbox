Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267389AbTBQSKY>; Mon, 17 Feb 2003 13:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267393AbTBQSKX>; Mon, 17 Feb 2003 13:10:23 -0500
Received: from holomorphy.com ([66.224.33.161]:59022 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267389AbTBQSKX>;
	Mon, 17 Feb 2003 13:10:23 -0500
Date: Mon, 17 Feb 2003 10:16:14 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Kamble, Nitin A" <nitin.a.kamble@intel.com>
Cc: linux-kernel@vger.kernel.org, "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: Re: [PATCH][2.5] IRQ distribution patch for 2.5.58
Message-ID: <20030217181614.GP29983@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Kamble, Nitin A" <nitin.a.kamble@intel.com>,
	linux-kernel@vger.kernel.org,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	"Mallick, Asit K" <asit.k.mallick@intel.com>,
	"Saxena, Sunil" <sunil.saxena@intel.com>
References: <E88224AA79D2744187E7854CA8D9131DA5CE8D@fmsmsx407.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E88224AA79D2744187E7854CA8D9131DA5CE8D@fmsmsx407.fm.intel.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2003 at 01:08:55PM -0800, Kamble, Nitin A wrote:
> +		spin_lock(&desc->lock);
> +		irq_balance_mask[selected_irq] = target_cpu_mask;
> +		spin_unlock(&desc->lock);

Wrong.

		irq_balance_mask[selected_irq] = cpu_to_logical_apicid(min_loaded);

... except this needs auditing for the assumption that the RTE's are
using logical DESTMOD.

Guess whose box won't boot with your code in?

-- wli
