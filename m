Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbVLHOkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbVLHOkm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 09:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbVLHOkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 09:40:42 -0500
Received: from iona.labri.fr ([147.210.8.143]:29140 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S932164AbVLHOkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 09:40:41 -0500
Message-ID: <43984595.1090406@labri.fr>
Date: Thu, 08 Dec 2005 15:39:17 +0100
From: Emmanuel Fleury <emmanuel.fleury@labri.fr>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to enable/disable security features on mmap() ?
References: <43983EBE.2080604@labri.fr> <1134051272.2867.63.camel@laptopd505.fenrus.org> <43984154.5050502@labri.fr>
In-Reply-To: <43984154.5050502@labri.fr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I guess that setting the variable randomize_va_space to 0 just remove
the stack pointer (sp) randomization.

Seen in arch/i386/kernel/process.c:

unsigned long arch_align_stack(unsigned long sp)
{
        if (randomize_va_space)
                sp -= get_random_int() % 8192;
        return sp & ~0xf;
}

Why not having defined this as a CONFIG_STACK_RANDOMIZATION variables
(you have some need to avoid to use it in the case of the Crusoe processor:

Seen in karch/i386/ernel/cpu/transmeta.c:

#ifdef CONFIG_SYSCTL
        /* randomize_va_space slows us down enormously;
           it probably triggers retranslation of x86->native bytecode */
        randomize_va_space = 0;
#endif

Regards
-- 
Emmanuel Fleury

Elegance is not optional.
  -- Richard O'Keefe
