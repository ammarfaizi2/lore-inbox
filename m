Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267338AbUITU3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267338AbUITU3r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 16:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbUITU1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 16:27:44 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:10626 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S266837AbUITU0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 16:26:42 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[1/6]-ACPI core enhancement support
Date: Mon, 20 Sep 2004 14:26:31 -0600
User-Agent: KMail/1.7
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       acpi-devel@lists.sourceforge.net, "Brown, Len" <len.brown@intel.com>,
       LHNS list <lhns-devel@lists.sourceforge.net>,
       Linux IA64 <linux-ia64@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040920092520.A14208@unix-os.sc.intel.com> <200409201326.44946.dtor_core@ameritech.net> <20040920120128.A15677@unix-os.sc.intel.com>
In-Reply-To: <20040920120128.A15677@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409201426.31672.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 September 2004 1:01 pm, Keshavamurthy Anil S wrote:
> On Mon, Sep 20, 2004 at 01:26:44PM -0500, Dmitry Torokhov wrote:
> > Also, introducing recursion (depth does not seem to be limited here) is
> > not a good idea IMHO - better convert it into iteration to avoid stack
> > problems down teh road.
> Humm, I guess recursion should be fine and even though the code does not have
> an explicit limit, the ACPI namespace describing the Ejectable device will limit the
> number of recursible devices. And I believe this won;t be more than 3 to 4 level depth.
> Hence recursion is fine here.
> 
> If you still strongly believe that recursion is not the right choice here, 
> let me know and I will convert it to iteration.

I'm also in favor of removing the recursion, if only because it
allows local analysis.  I.e., a correctness argument based solely
on the code in the patch is much more useful than one that relies
on properties of an external and mostly unknown ACPI namespace.
