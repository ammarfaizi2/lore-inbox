Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261961AbVEXSSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbVEXSSP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 14:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbVEXSSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 14:18:10 -0400
Received: from colin.muc.de ([193.149.48.1]:8207 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261961AbVEXSRt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 14:17:49 -0400
Date: 24 May 2005 20:17:43 +0200
Date: Tue, 24 May 2005 20:17:43 +0200
From: Andi Kleen <ak@muc.de>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Ashok Raj <ashok.raj@intel.com>, zwane@arm.linux.org.uk,
       discuss@x86-64.org, shaohua.li@intel.com, linux-kernel@vger.kernel.org,
       rusty@rustycorp.com.au
Subject: Re: [discuss] Re: [patch 0/4] CPU hot-plug support for x86_64
Message-ID: <20050524181743.GG86233@muc.de>
References: <20050520221622.124069000@csdlinux-2.jf.intel.com> <20050523164046.GB39821@muc.de> <20050523095450.A8193@unix-os.sc.intel.com> <20050523171212.GF39821@muc.de> <20050523104046.B8692@unix-os.sc.intel.com> <20050524054617.GA5510@in.ibm.com> <20050523230106.A13839@unix-os.sc.intel.com> <20050524085330.GB8279@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050524085330.GB8279@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2005 at 02:23:30PM +0530, Srivatsa Vaddagiri wrote:
> On Mon, May 23, 2005 at 11:01:06PM -0700, Ashok Raj wrote:
> > We do this today in x86_64 case when we setup this upcomming cpu in 
> > cpu_online_map. But the issue is when we use ipi broadcast, its an ugly
> 
> I don't know of x86-64, but atleast on x86 ipi broadcast will send 
> to _all_ CPUs present, right? I mean the h/w does not know of the offline
> CPUs and will send to them also. This could lead to a problem for the offline 
> CPUs when they come online and can take a spurious IPI (unless
> there is support in h/w to clear pending IPI before doing STI).

x86-64 works the same here. 

The hardware does not clear pending IPIs AFAIK, but software could
do that manually during cpu bootup. Races can be avoided by taking
call_lock and the tlb flush lock while doing that.

-Andi
