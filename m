Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbVJMIwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbVJMIwE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 04:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbVJMIwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 04:52:04 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:2775 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S932478AbVJMIwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 04:52:02 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Subject: Re: using segmentation in the kernel
Date: Thu, 13 Oct 2005 11:51:16 +0300
User-Agent: KMail/1.8.2
Cc: "Jonathan M. McCune" <jonmccune@cmu.edu>, linux-kernel@vger.kernel.org,
       "Arvind Seshadri" <arvinds@cs.cmu.edu>, "Bryan Parno" <parno@cmu.edu>
References: <434C1D60.2090901@cmu.edu> <Pine.LNX.4.61.0510120837370.8832@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0510120837370.8832@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510131151.16675.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 October 2005 16:03, linux-os (Dick Johnson) wrote:
> On the ix86 you have a problem. Let's say that you write some
> code from scratch, that runs the CPU in 32-bit linear address-mode
> without paging. Then you want to activate paging. To activate
> paging, you MUST have provided some code and some data-space for
> your descriptors, where there is a 1:1 mapping between virtual
> and bus addresses. If you don't do this, at the instant you
> change to paging mode, you crash. The CPU fetches garbage.
> 
> This is why the first few megabytes of Linux are unity-mapped.
> You will always need to run the kernel out of an area where
> a portion of that "segment" is unity-mapped. That segment
> is where the descriptors for addressing, paging, and interrupts
> must reside.
>
> If you truly wanted to run the kernel from 3-4 GB as you state,
> you must have RAM there, i.e., some physical stuff so that
> a 1:1 mapping could be implemented. The 3-4 GB region is
> where a lot of PCI addressing occurs on 32-bit machines and,
> in fact, there are some "do-not-touch" addresses in that
> region as well.

This is untrue. After paging is enabled, you can jump
to non-unity mapped location and remove small unity-mapped region.

> Remember that the kernel runs in virtual address mode, but
> the descriptors that specify that mode need to be in physical
> memory, addressed at the same offset. You can experiment

Some of us are smart enough to add an offset when doing virt<->phys
conversion, if needed.
--
vda
