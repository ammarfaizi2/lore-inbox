Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292768AbSCDTEK>; Mon, 4 Mar 2002 14:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292779AbSCDTED>; Mon, 4 Mar 2002 14:04:03 -0500
Received: from gordo.y12.doe.gov ([134.167.141.46]:3556 "EHLO
	gordo.y12.doe.gov") by vger.kernel.org with ESMTP
	id <S292768AbSCDTC2>; Mon, 4 Mar 2002 14:02:28 -0500
Message-ID: <3C83C4B6.B7A95B5A@y12.doe.gov>
Date: Mon, 04 Mar 2002 14:02:14 -0500
From: David Dillow <dillowd@y12.doe.gov>
Organization: BWXT Y-12/ACT/UT Subcon/What a mess!
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IBM Lanstreamer bugfixes (round 3)
In-Reply-To: <Pine.LNX.4.33.0203041023580.11065-100000@janetreno.austin.ibm.com>
	 <3C83A925.F93BF448@mandrakesoft.com> <3C83AE6B.9B5DE85F@y12.doe.gov>
	 <3C83B2E7.B5EB0FB5@mandrakesoft.com> <3C83C0B8.659F1AE@y12.doe.gov> <3C83C258.FCF57746@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> David Dillow wrote:
> > Right, I was talking more about the cache line size... is it sufficient
> > for that?
> 
> pci_enable_device doesn't touch PCI_COMMAND_INVALIDATE either, on most
> platforms (particularly ia32, i.e. the popular one :))

Doh! I see my mistake; I was reading pdev_enable_device() which sets it
to L1_CACHE_BYTES. And a quick grep shows me that it is called from
pci_assign_unassigned_resources(), which is not called on ia32 as far as
I can see....

This seems to be a common thing to set; shouldn't we have a helper for
it as well, or have pci_enable_device() do it?

Thanks,
Dave Dillow
dillowd@y12.doe.gov
