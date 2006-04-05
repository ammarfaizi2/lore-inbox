Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbWDEDrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWDEDrH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 23:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWDEDrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 23:47:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:35994 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750864AbWDEDrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 23:47:05 -0400
X-IronPort-AV: i="4.03,165,1141632000"; 
   d="scan'208"; a="20040441:sNHT16378950"
Subject: Re: 2.6.17-rc1-mm1
From: Zou Nan hai <nanhai.zou@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
In-Reply-To: <20060404233851.GA6411@agluck-lia64.sc.intel.com>
References: <20060404014504.564bf45a.akpm@osdl.org>
	 <20060404233851.GA6411@agluck-lia64.sc.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1144202706.3197.11.camel@linux-znh>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 05 Apr 2006 10:05:06 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-05 at 07:38, Luck, Tony wrote:
> On Tue, Apr 04, 2006 at 01:45:04AM -0700, Andrew Morton wrote:
> > - VGA on ia64 is broken - the screen comes up blank.  But ia64 otherwise
> >   seems to work OK.  I didn't have time to investigate.
> 
> Broken in base 2.6.17-rc1 too :-(  VGA comes up and prints a
> few messages, and then goes wonky and dies.  Comparing
> what I _think_ I saw with the dmesg output, it appears to
> die here:
> 

The wild VGA comes from the patch which changed ioremap.

Now ioremap would not remap memory to region 6 unless that memory is
marked as EFI_MEMORY_UC by EFI.

Unfortunately on the Tiger Machine, VGA ram base was marked as
EFI_MEMORY_WB instead of EFI_MEMORY_UC...

So you can see the problem disappear if change VGA_MAP_MEM to use
ioremap_nocache.

But I am not quite sure if we can fully trust EFI on this attribute.

Zou Nan hai
