Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267497AbSLSBzg>; Wed, 18 Dec 2002 20:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267505AbSLSBzg>; Wed, 18 Dec 2002 20:55:36 -0500
Received: from holomorphy.com ([66.224.33.161]:29119 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267497AbSLSBzf>;
	Wed, 18 Dec 2002 20:55:35 -0500
Date: Wed, 18 Dec 2002 18:01:47 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Till Immanuel Patzschke'" <tip@inw.de>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 15000+ processes -- poor performance ?!
Message-ID: <20021219020147.GN31800@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
	'Till Immanuel Patzschke' <tip@inw.de>,
	lse-tech <lse-tech@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <A46BBDB345A7D5118EC90002A5072C7806CACA2C@orsmsx116.jf.intel.com> <1040265088.27221.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1040265088.27221.7.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-19 at 01:04, Perez-Gonzalez, Inaky wrote:
>> If it has it ... well, I have no idea - maybe Robert Love would know.

On Thu, Dec 19, 2002 at 02:31:28AM +0000, Alan Cox wrote:
> He's running the -aa kernel, which has all the right bits for this too.
> In fact in some ways for very large memory boxes its probably the better
> variant

In my experience the most critical issues running 16K processes are:
(1) the highmem footprint of the pte's is significant
(2) the lowmem footprint of pmd's

and most of the rest is in the noise. It's probably a bad idea to run
top(1) or perhaps even mount /proc/ at all until top itself,
proc_pid_readdir(), and the tasklist_lock are all fixed.

Pretty much all he needs to "stay alive" is highpte of some flavor or
another. Performance etc. is addressed somewhat more by 2.5.x than -aa,
at least in the context of not degrading with this kind of multitasking.
i.e. shpte and pidhash. I've been randomly shooting down do_each_thread()
and for_each_process() loops in -wli, which is why I recommended it.

Bill
