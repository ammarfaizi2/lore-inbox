Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWH3Qsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWH3Qsm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 12:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWH3Qsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 12:48:41 -0400
Received: from ns1.suse.de ([195.135.220.2]:15495 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751147AbWH3Qsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 12:48:41 -0400
From: Andi Kleen <ak@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH RFC 0/6] Implement per-processor data areas for  i386.
Date: Wed, 30 Aug 2006 18:48:39 +0200
User-Agent: KMail/1.9.3
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andrew Morton <akpm@osdl.org>
References: <200608300838_MC3-1-C9C6-CA79@compuserve.com> <44F5BF29.7080004@goop.org>
In-Reply-To: <44F5BF29.7080004@goop.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608301848.39443.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  
> 
> I don't think so.  The whole point is to make the pda easily accessible 
> with simple addressing modes based on %gs:.   I have been wondering if 
> we can modify the percpu mechanism to get the linker to construct the 
> layout of the pda, so that all the existing percpu stuff can be 
> transparently moved into the pda and accessed efficiently.  I think it 
> would be pretty tricky to get it all working though...

I tried that once on x86-64, but it wasn't possible because the linker
is missing the right relocations. It has something on the first look similar 
for __thread data in user space, but it wasn't usable for the kernel.

Even with a single indirection it is still far more efficient than a 
array lookup.

-Andi
