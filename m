Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751015AbWATRrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbWATRrl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 12:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWATRrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 12:47:41 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:64386 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751015AbWATRrk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 12:47:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cQpJC5AGzmK7nFaeoIETJbbwJO+gldk3jUnN29KqQNlnkjgOeNk6zfG5c7UDD72TS0o15lunucPr3Qt09Rw7BaJUOjTBc2abuUxabx5xDdgtf/smPQEnNz+cFHulsYbOch5zje3Hn4gDD9iMUd47o8X0jdyNTuJ7BC5RQuPzctU=
Message-ID: <e9c3a7c20601200947t1d3c1c4eybea2adb97a10c92c@mail.gmail.com>
Date: Fri, 20 Jan 2006 10:47:39 -0700
From: Dan Williams <dan.j.williams@gmail.com>
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: hugetlbfs on ARM / how to mmap() 36-bit PCI memory?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just went through an experiment trying to mmap a PCI resource via
the /sys/bus/pci/devices/<device name>/resource[n] on a XSC3 platform.
 I discovered, correct me if I am wrong, that remap_pfn_range only
acts on 2nd level (4K) pte's.  On this platform PCI memory is only
available at a 36-bit physical address.

In looking for an answer I found this post from Deepak in the thread:
"clean way to support >32bit addr on 32bit CPU "
http://marc.theaimsgroup.com/?t=110540164100006&r=1&w=2

<snip>
Not doable. I believe PAE allows for normal 4K pages to be used when
mapping > 32-bits. XSC3 and ARMv6 only allow for > 32 bit addresses
when using 16MB pages (supersections), so we need to instead use
the hugetlb approach.

~Deepak
</snip>

Questions
1) Currently ARM does not appear to have support for hugetlbfs, is
this in the works / any pointers to help get me started with the code?
2) Does the hugetlbfs interface support PCI memory or is it only meant for RAM?
3) Is there a better approach than hugetlb to mmap PCI space in this scenario?

Thanks,

Dan
