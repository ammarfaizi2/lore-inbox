Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751497AbWIFSOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbWIFSOY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 14:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWIFSOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 14:14:24 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:21962 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751491AbWIFSOV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 14:14:21 -0400
Subject: Re: one more ACPI Error (utglobal-0125): Unknown exception code: 
	0xFFFFFFEA [Re: 2.6.18-rc4-mm3]
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>,
       "Li, Shaohua" <shaohua.li@intel.com>,
       Mattia Dongili <malattia@linux.it>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       linux acpi <linux-acpi@vger.kernel.org>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <200609011720.36318.bjorn.helgaas@hp.com>
References: <B28E9812BAF6E2498B7EC5C427F293A4D850BB@orsmsx415.amr.corp.intel.com>
	 <49303.24.9.204.52.1157080555.squirrel@mail.cce.hp.com>
	 <1157151674.5656.21.camel@keithlap>
	 <200609011720.36318.bjorn.helgaas@hp.com>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Wed, 06 Sep 2006 11:14:15 -0700
Message-Id: <1157566456.5713.4.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 17:20 -0600, Bjorn Helgaas wrote:
> On Friday 01 September 2006 17:01, keith mannthey wrote:
> > On Thu, 2006-08-31 at 21:15 -0600, Bjorn Helgaas wrote:
> > > The current ACPI driver binding algorithm in acpi_bus_find_driver()
> > > looks at each driver, checking whether it can match either the _HID
> > > or the _CID of a device.  Since we try the motherboard driver first,
> > > it matches the memory device _CID.
> > 
> > Ok I reverted the motherboard driver patch and cooked up the following
> > patch that works for my issue.  
> > 
> >   It creates the idea that acpi_match_ids has a type of request to check
> > against for _HID, _CID or both.  See acpi_bus_match_req. I then fix up
> > all the needed callers to change the API to acpi_match_ids and
> > acpi_bus_match and have callers can say what they want to match
> > against. 
> >   
> >   Then in acpi_bus_find_driver I have it do 2 passes to search for _HID
> > first then the _CID.  
> > 
> > Does this look like it is in the right ballpark or should we be doing
> > something else?  Built/tested against 2.6.18-rc4-mm3. 
> 
> Conceptually I like this much better than mucking with the motherboard
> driver.  I'm not sure the important people have signed off on this
> strategy of binding with _HID first, then _CID (hi, Len :-))  Maybe
> there are ramifications that we need to consider.  But I think it
> is a better match for "what people expect should happen."

ACPI folks can we get some response to this?  This problem has been
reported a few times against the -mm tree and I would like to get the
proper fix (whatever it is) upstream sometime soon. 

Bjorn thanks for the help and for pointing the error reports in the
right direction. 

Thanks,
  Keith 


