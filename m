Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266775AbUITTBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266775AbUITTBs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 15:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266867AbUITTBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 15:01:48 -0400
Received: from fmr03.intel.com ([143.183.121.5]:60104 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S266753AbUITTBl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 15:01:41 -0400
Date: Mon, 20 Sep 2004 12:01:28 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: acpi-devel@lists.sourceforge.net,
       Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
       "Brown, Len" <len.brown@intel.com>,
       LHNS list <lhns-devel@lists.sourceforge.net>,
       Linux IA64 <linux-ia64@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[1/6]-ACPI core enhancement support
Message-ID: <20040920120128.A15677@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20040920092520.A14208@unix-os.sc.intel.com> <20040920093402.C14208@unix-os.sc.intel.com> <200409201326.44946.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200409201326.44946.dtor_core@ameritech.net>; from dtor_core@ameritech.net on Mon, Sep 20, 2004 at 01:26:44PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2004 at 01:26:44PM -0500, Dmitry Torokhov wrote:
> On Monday 20 September 2004 11:34 am, Keshavamurthy Anil S wrote:
> > +void
> > +acpi_bus_trim(struct acpi_device       *start,
> > +               int rmdevice)
> > +{
> > +       acpi_status             status = AE_OK;
> > +       struct acpi_device      *parent = NULL;
> > +       struct acpi_device      *child = NULL;
> > +       acpi_handle             phandle = 0;
> > +       acpi_handle             chandle = 0;
> > +
> > +       parent  = start;
> > +       phandle = start->handle;
> 
> 
> Why do all these variables have to be initialized? parent and phandle are
> set up explicitly couple of lines below, the rest is only used safely
> as well...
You are correct, variable initialization can be removed. I will do this.

> 
> Also, introducing recursion (depth does not seem to be limited here) is
> not a good idea IMHO - better convert it into iteration to avoid stack
> problems down teh road.
Humm, I guess recursion should be fine and even though the code does not have
an explicit limit, the ACPI namespace describing the Ejectable device will limit the
number of recursible devices. And I believe this won;t be more than 3 to 4 level depth.
Hence recursion is fine here.

If you still strongly believe that recursion is not the right choice here, 
let me know and I will convert it to iteration.

Thanks,
Anil
