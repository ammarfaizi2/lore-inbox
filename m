Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262306AbVFJK0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbVFJK0Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 06:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbVFJK0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 06:26:25 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:12006 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262306AbVFJK0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 06:26:18 -0400
Message-ID: <42A96B71.3080006@jp.fujitsu.com>
Date: Fri, 10 Jun 2005 19:29:05 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, Linas Vepstas <linas@austin.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH 01/10] IOCHK interface for I/O error handling/detecting
References: <42A8386F.2060100@jp.fujitsu.com> <42A83A8F.9020503@jp.fujitsu.com> <20050609165353.GB9597@kroah.com>
In-Reply-To: <20050609165353.GB9597@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thank you for giving me many useful advices!

Greg KH wrote:
> On Thu, Jun 09, 2005 at 09:48:15PM +0900, Hidetoshi Seto wrote:
> 
>>+void iochk_init(void) { ; }
>>+
>>+void iochk_clear(iocookie *cookie, struct pci_dev *dev)
>>+{
>>+	/* no-ops */
>>+}
> 
> A bit of a coding style difference between the two functions, yet they
> do the same thing :)

I intended to emphasize the pair. I'll unify them if not needed.

>>+int iochk_read(iocookie *cookie)
>>+{
>>+	/* no-ops */
>>+	return 0;
>>+}
> 
> Why not just return the cookie?  Can this ever fail?

In this time, no one initializes the cookie, so I just ignored it.

> Shouldn't these go into a .h file and be made "static inline" so they
> just compile away to nothing?

I'm not used to inlining...
In case of generic definition above, absolutely it should be inlined.
OK, I'll try.

>>+EXPORT_SYMBOL(iochk_clear);
>>+EXPORT_SYMBOL(iochk_read);
> 
> EXPORT_SYMBOL_GPL() perhaps?

Yea.

>>+#ifndef HAVE_ARCH_IOMAP_CHECK
>>+typedef unsigned long iocookie;
>>+#endif
> 
> Why typedef this if it isn't specified?

Because I stuck to have short name alias, and wanted to hide even
whether it is struct or not.

Thanks,
H.Seto

