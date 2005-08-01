Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262274AbVHAPxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbVHAPxR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 11:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262230AbVHAPuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 11:50:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:58092 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262219AbVHAPtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 11:49:06 -0400
X-Authenticated: #4401329
Message-ID: <42EE4462.9030101@gmx.net>
Date: Mon, 01 Aug 2005 17:48:50 +0200
From: Simon Sudler <Simon.Sudler@gmx.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: reed-solomon lib
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I'm working with the reed-solomon lib. Since i use a
RS(255,191,64) code, i found a strange limitation in
the reed_solomon.c:

194:	/* Sanity checks */
         if (symsize < 1)
                 return NULL;
         if (fcr < 0 || fcr >= (1<<symsize))
                 return NULL;
         if (prim <= 0 || prim >= (1<<symsize))
                 return NULL;
         if (nroots < 0 || nroots >= (1<<symsize) || nroots > 8)
                 return NULL;

in line 201 the nroot are limited to max 8. I checkt the
original code from Phil Karn (http://cache.qualcomm.com/code/fec/)
in witch is no limitation. After a closer look a the original
code, i couldn't find any relevant difference exept for
the line above.
After removing of the "nroots > 8" my code was working fine...
perhaps someone was to carful to avoid a errors with the kmalloc
function in rs_init.

Cheers,
Simon

