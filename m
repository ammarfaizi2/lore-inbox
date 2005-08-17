Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbVHQN41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbVHQN41 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 09:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbVHQN40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 09:56:26 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:4760 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751123AbVHQN40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 09:56:26 -0400
Subject: Re: [PATCH 5/14] i386 / Use early clobber to eliminate rotate in
	desc
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Zachary Amsden <zach@vmware.com>, Andi Kleen <ak@suse.de>, akpm@osdl.org,
       chrisl@vmware.com, chrisw@osdl.org, Keir.Fraser@cl.cam.ac.uk,
       linux-kernel@vger.kernel.org, m+Ian.Pratt@cl.cam.ac.uk,
       mbligh@mbligh.org, pratap@vmware.com, virtualization@lists.osdl.org,
       zwame@arm.linux.org.uk
In-Reply-To: <43027F6C.4070801@zytor.com>
References: <200508110454.j7B4sBDK019538@zach-dev.vmware.com>
	 <20050816234514.GG27628@wotan.suse.de> <43027D20.7020907@vmware.com>
	 <43027F6C.4070801@zytor.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 17 Aug 2005 15:22:22 +0100
Message-Id: <1124288543.773.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-08-16 at 17:06 -0700, H. Peter Anvin wrote:
> At least i386 and x86-64 gcc should recognize
> 
> 	((foo << x) + (foo >> (32-x)))
> 
> ... as a 32-bit rotate

Only for  1 <= x <= 31. For the x = 0 case the code posted is undefined
and at least in some cases gcc will do "interesting" things as a result
such as treating >> 32 as >> 0.

Alan

