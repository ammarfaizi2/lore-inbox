Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263282AbVCKC0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263282AbVCKC0a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 21:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263285AbVCKC0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 21:26:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:13511 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262393AbVCKCXh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 21:23:37 -0500
Date: Thu, 10 Mar 2005 21:23:32 -0500
From: Dave Jones <davej@redhat.com>
To: Paul Mackerras <paulus@samba.org>
Cc: torvalds@osdl.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: AGP bogosities
Message-ID: <20050311022332.GB20697@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Paul Mackerras <paulus@samba.org>, torvalds@osdl.org,
	benh@kernel.crashing.org, linux-kernel@vger.kernel.org
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com> <20050311021248.GA20697@redhat.com> <16944.65532.632559.277927@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16944.65532.632559.277927@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 01:18:36PM +1100, Paul Mackerras wrote:
 > Dave Jones writes:
 > 
 > >  >  		cap_ptr = pci_find_capability(device, PCI_CAP_ID_AGP);
 > >  > -		if (!cap_ptr) {
 > >  > -			pci_dev_put(device);
 > >  > -			continue;
 > >  > -		}
 > >  > -			cap_ptr = 0;
 > >  >  	}
 > > 
 > > This part I'm not so sure about.
 > > The pci_get_class() call a few lines above will get a refcount that
 > > we will now never release.
 > 
 > The point is that pci_get_class does a pci_dev_put() on the "from"
 > parameter, so your code ended up doing a double put.

After it does that pci_dev_put on the from, it does another pci_dev_get
on 'dev', which is what my put was releasing.

Or am I terribly confused ?

		Dave

