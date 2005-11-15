Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbVKOQx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbVKOQx1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964924AbVKOQx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:53:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29064 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964951AbVKOQxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:53:25 -0500
Date: Tue, 15 Nov 2005 08:52:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Zachary Amsden <zach@vmware.com>
cc: Arjan van de Ven <arjan@infradead.org>, Gerd Knorr <kraxel@suse.de>,
       Dave Jones <davej@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
In-Reply-To: <437A0BC3.3060909@vmware.com>
Message-ID: <Pine.LNX.4.64.0511150849590.3945@g5.osdl.org>
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com> 
 <20051111103605.GC27805@elf.ucw.cz> <4374F2D5.7010106@vmware.com> 
 <Pine.LNX.4.64.0511111147390.4627@g5.osdl.org>  <4374FB89.6000304@vmware.com>
  <Pine.LNX.4.64.0511111218110.4627@g5.osdl.org>  <20051113074241.GA29796@redhat.com>
  <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org>  <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org>
 <4378A7F3.9070704@suse.de>  <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org>
 <4379ECC1.20005@suse.de>  <437A0649.7010702@suse.de>  <437A0710.4020107@vmware.com>
 <1132070764.2822.27.camel@laptopd505.fenrus.org> <437A0BC3.3060909@vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 Nov 2005, Zachary Amsden wrote:
> 
> It's not overkill in the virtualization context, and there are (struggling,
> but infinite possibilities) opportunities for native here as well.

No, there are almost no opportunities for native.

Especially with SMP, doing on-line code switching is really really nasty. 
You basically have to shut down all CPU's to make sure there are no races 
with other CPU's executing the code while it's being rewritten.

I'd be very very nervous about it. It would have to be some major 
performance feature for it to make sense over a simple "switch function 
pointers around" approach.

		Linus
