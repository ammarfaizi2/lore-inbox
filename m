Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWDUPHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWDUPHs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 11:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWDUPHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 11:07:47 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:4786 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751204AbWDUPHr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 11:07:47 -0400
Date: Fri, 21 Apr 2006 17:07:45 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Dmitry Fedorov <dm.fedorov@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kfree(NULL)
In-Reply-To: <7115951b0604210707q2113dd65tda67e24c07d6c0ad@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0604211643350.31515@yvahk01.tjqt.qr>
References: <200604210703.k3L73VZ6019794@dwalker1.mvista.com> 
 <Pine.LNX.4.64.0604210322110.21429@d.namei>  <20060421015412.49a554fa.akpm@osdl.org>
  <200604210656.40158.vernux@us.ibm.com> <7115951b0604210707q2113dd65tda67e24c07d6c0ad@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Maybe kfree should really be a wrapper around __kfree which does the real
>> work.  Then kfree could be a inlined function or a #define that does the NULL
>> pointer check.
>
>NULL pointer check in kfree saves lot of small code fragments in callers.
>It is one of many reasons why kfree does it.
>Making kfree inline wrapper eliminates this save.

How about

slab.h:
#ifndef CONFIG_OPTIMIZING_FOR_SIZE
static inline void kfree(const void *p) {
    if(p != NULL)
        __kfree(p);
}
#else
extern void kfree(const void *);
#endif

slab.c:
#ifdef CONFIG_OPTIMIZING_FOR_SIZE
void kfree(const void *p) {
    if(p != NUILL)
        _kfree(p);
}
#endif

That way, you get your time saving with -O2 and your space saving with -Os.


Jan Engelhardt
-- 
