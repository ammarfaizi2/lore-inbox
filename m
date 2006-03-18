Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbWCRV5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWCRV5h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 16:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbWCRV5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 16:57:37 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:61930 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751052AbWCRV5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 16:57:37 -0500
Date: Sat, 18 Mar 2006 22:57:19 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Xavier Bestel <xavier.bestel@free.fr>
cc: Andrew Morton <akpm@osdl.org>, viro@ftp.linux.org.uk,
       linux-kernel@vger.kernel.org, aia21@cantab.net, len.brown@intel.com
Subject: Re: [patch 1/1] consolidate TRUE and FALSE
In-Reply-To: <20060317234311.c5e338f6.xavier.bestel@free.fr>
Message-ID: <Pine.LNX.4.61.0603182238140.4492@yvahk01.tjqt.qr>
References: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net>
 <20060316164932.GT27946@ftp.linux.org.uk> <20060316132639.274691d6.akpm@osdl.org>
 <20060317234311.c5e338f6.xavier.bestel@free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Isn't there a runtime cost converting all "non-false" values to a unique "true" (i.e. converting non-zero values to one) ?
>

Somewhat. The answer is "yes, but depends on usage". If you just 
write

	_Bool x = filthy_action();
	if(x)

Then the compiler is smart enough to optimize 'x' away if it is not used 
somewhere else, therefore we do not pay a price for converting the return 
type of filthy_action (=int) to a _Bool.

The asm output for storing the result of filthy_action() [requires 
'volatile int x' in this small example]

	call strxcmp
	mov [ebp-4], eax

While making that a 'volatile _Bool x' makes it:

	call strxcmp
	test eax, eax
	setnz al
	mov [ebp-1], al

Makes me prefer typedef int bool over _Bool.


Jan Engelhardt
-- 
