Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbTLCV00 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 16:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbTLCV00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 16:26:26 -0500
Received: from fujitsu1.fujitsu.com ([192.240.0.1]:36589 "EHLO
	fujitsu1.fujitsu.com") by vger.kernel.org with ESMTP
	id S261889AbTLCVXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 16:23:42 -0500
Date: Wed, 03 Dec 2003 13:23:10 -0800
From: Yasunori Goto <ygoto@fsw.fujitsu.com>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Subject: Re: [Lhms-devel] RE: memory hotremove prototype, take 3
Cc: "Pavel Machek" <pavel@suse.cz>, <linux-kernel@vger.kernel.org>,
       "Luck, Tony" <tony.luck@intel.com>,
       "IWAMOTO Toshihiro" <iwamoto@valinux.co.jp>,
       "Hirokazu Takahashi" <taka@valinux.co.jp>,
       "Linux Hotplug Memory Support" <lhms-devel@lists.sourceforge.net>
In-Reply-To: <A20D5638D741DD4DBAAB80A95012C0AE0125DCB0@orsmsx409.jf.intel.com>
References: <A20D5638D741DD4DBAAB80A95012C0AE0125DCB0@orsmsx409.jf.intel.com>
Message-Id: <20031203113040.E67F.YGOTO@fsw.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.07.02
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > IMHO, To hot-remove memory, memory attribute should be divided
> > into Hotpluggable and no-Hotpluggable, and each attribute memory
> > should be allocated each unit(ex. node).
> 
> Why? I still don't get that -- we should be able to use the virtual
> addressing mechanism of any CPU to swap under the rug any virtual
> address without needing to do anything more than allocate a page frame
> for the new physical location 

My understanding is that the kernel and device drivers sometimes
assume physical memory address is not changed.
For example, IA32 kernel often uses __PAGE_OFFSET. 
I suppose that there are many case which the kernel and device drivers
assume physical address is not changed like this.
Even if we use Mr. Iwamoto's method use, some memories will remain.

But, if remaining memories will be on only one (or a few) node,
other nodes will be able to be hot-removed.
I think that dividing attribute hotpluggable or not is realistic way.


> (I am ignoring here devices that are 
> directly accessing physical memory--a callback in the device model could
> be added to require them to reallocate their buffers).

Mr. Iwamoto and Mr. Takahashi told me that some memories which is used
by NFS are especially difficult to be hotplugged....

Thanks.

-- 
Yasunori Goto <ygoto at fsw.fujitsu.com>


