Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269631AbTGJWCB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 18:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269628AbTGJWCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 18:02:00 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12292 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S269631AbTGJV7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 17:59:31 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Style question: Should one check for NULL pointers?
Date: 10 Jul 2003 15:13:52 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bekof0$g7i$1@cesium.transmeta.com>
References: <7QmZ.5RP.17@gated-at.bofh.it> <3F0DD3FD.3030403@triphoenix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3F0DD3FD.3030403@triphoenix.de>
By author:    Dennis Bliefernicht <itsme.nospam@triphoenix.de>
In newsgroup: linux.dev.kernel
> 
> The problem is IMHO code where some pretty fragile things are handled, 
> especially file systems. I'd say: DO the paranoia checks if some fragile 
> things are involved like key structures of the file system that can take 
> _permanent_ damage. If you check for a NULL pointer you still have the 
> chance to properly leave the system in a consistent state and no user 
> will be happy if his filesystem goes messy just because someone saved a 
> check to have nicer code, even if the original of the NULL pointer 
> wasn't his fault, even if it's a developing version. So if the check 
> isn't a total performace disaster, do it whenever permanent damage could 
> occur.
> 

Actually, you have it somewhat backwards.

In most cases, checking for NULL pointers (and returning an error
whatnot) is actually *more* likely to cause permanent damage than
having the kernel bomb out.  At least with the kernel bombing out you
won't keep grinding on a filesystem for which your kernel
datastructures are bad.  This is *IMPORTANT*.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
