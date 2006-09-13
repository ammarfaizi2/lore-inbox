Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbWIMOvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWIMOvY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 10:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbWIMOvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 10:51:23 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:55940 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1750900AbWIMOvW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 10:51:22 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: kmannth@us.ibm.com
Subject: Re: one more ACPI Error (utglobal-0125): Unknown exception  code:0xFFFFFFEA [Re: 2.6.18-rc4-mm3]
Date: Wed, 13 Sep 2006 08:51:15 -0600
User-Agent: KMail/1.9.1
Cc: Shaohua Li <shaohua.li@intel.com>,
       "Moore, Robert" <robert.moore@intel.com>, Len Brown <lenb@kernel.org>,
       Mattia Dongili <malattia@linux.it>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       linux acpi <linux-acpi@vger.kernel.org>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
References: <B28E9812BAF6E2498B7EC5C427F293A4E38B52@orsmsx415.amr.corp.intel.com> <4132.24.9.204.52.1157682479.squirrel@mail.cce.hp.com> <1158110859.6047.27.camel@keithlap>
In-Reply-To: <1158110859.6047.27.camel@keithlap>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609130851.16028.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 September 2006 19:27, keith mannthey wrote:
> On Thu, 2006-09-07 at 20:27 -0600, Bjorn Helgaas wrote:
> > > On Thu, 2006-09-07 at 09:25 -0600, Bjorn Helgaas wrote:
> > >> If we decide that "try HID first, then try CID" is the right thing,
> > >> I think we should figure out how to make that work.  Maybe that
> > >> means extending the driver model somehow.
> > > Don't think it's easy, especially no other bus needs it I guess.
> > 
> > I agree it's probably not easy, but I think having the right
> > semantics is more important than fitting cleanly into the
> > driver model.  But I know that without code, I'm just venting
> > hot air, not contributing to a solution.
> > 
> > How's the ACPI driver model integration going, anyway?  I seem
> > to recall some patches a while back, but I don't think they're
> > in the tree yet.
> > 
> > > Do we really need the memory hotplug device returns pnp0c01/pnp0c02?
> > > What's the purpose?
> > 
> > I don't know.  But I think Keith already determined that a BIOS change
> > is not likely.  I hate to ask for BIOS changes like this because it
> > feels like asking them to avoid broken things in Linux.
> 
>   Ok my motherboard patch was dropped from -mm so I am broken again but
> others are fixed. Is the answer that we do nothing about this issues?   
> 
>   I am pretty sure my SSDT table is valid if someone *cannot* point out
> in the spec where my device is malformed  by having both HID and CID I
> will not be able even start the request to change the BIOS (it would be
> a waste of my time).  Sure having the CID of the memory device may be
> overkill but is it wrong?  

I think that your SSDT is valid.  I can't point to a specific
reference in the spec, but I think the "try _HID first, then try
_CID" strategy is clearly the intent.  Otherwise, there would be
no reason to separate _HID from _CID.

>   Unless someone can show me a alternate solution I am going to push the
> check HID before CID patch to -mm in the next day or two. 

I support this, although I do understand that it will make it more
difficult to integrate ACPI into the driver model because the driver
model currently only does one pass to check whether a driver can claim
a device.

Bjorn
