Return-Path: <linux-kernel-owner+w=401wt.eu-S932695AbWLSJAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695AbWLSJAv (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 04:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932699AbWLSJAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 04:00:51 -0500
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:36062 "EHLO
	liaag1ab.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932695AbWLSJAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 04:00:50 -0500
Date: Tue, 19 Dec 2006 03:55:38 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [solved] Yenta Cardbus allocation failure
To: "Markus Rechberger" <mrechberger@gmail.com>
Cc: linux-kernel@vger.kernel.org,
       Dominik Brodowski <linux@dominikbrodowski.net>
Message-ID: <200612190359_MC3-1-D590-3237@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <d9def9db0612181612v657197ees925609243fc1ef65@mail.gmail.com>

On Tue, 19 Dec 2006 01:12:07 +0100, Markus Rechberger wrote:

> I went on with investigating that problem and found the problem,
> though I'm not sure if that solution is acceptable..
> 
> seems like the memory range gets preallocated in setup-bus.c, and
> CARDBUS_MEM_SIZE defines that size.
> 
> I changed
> #define CARDBUS_MEM_SIZE        (32*1024*1024)
> to
> #define CARDBUS_MEM_SIZE        (48*1024*1024)
> 
> and now the system is able to allocate the resources for the 3rd
> pci/pcmcia function.
> 
> Can anyone please have a closer look at it too? I think the whole
> implementation isn't really good there..
> 
> so this is the new output of iomem:
> $ cat /proc/iomem
> ...
> 30000000-35ffffff : PCI Bus #02
>   30000000-32ffffff : PCI CardBus #03
> 36000000-360003ff : 0000:00:1f.1
> 39000000-3bffffff : PCI CardBus #03
>   39000000-39ffffff : 0000:03:00.0
>   3a000000-3affffff : 0000:03:00.1
>   3b000000-3bffffff : 0000:03:00.2 <- this one failed to allocate previously

Wow, 3 regions of 16MB each!  Your change fixes this problem for you, but
what if someone needs four such regions?

-- 
MBTI: IXTP

