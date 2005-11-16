Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932603AbVKPVHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbVKPVHl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 16:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932604AbVKPVHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 16:07:41 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:14022 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932603AbVKPVHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 16:07:40 -0500
Date: Wed, 16 Nov 2005 13:07:26 -0800
From: Paul Jackson <pj@sgi.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: mrmacman_g4@mac.com, serue@us.ibm.com, linux-kernel@vger.kernel.org,
       frankeh@watson.ibm.com, haveblue@us.ibm.com
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Message-Id: <20051116130726.2412fbc9.pj@sgi.com>
In-Reply-To: <20051116203603.GA12505@elf.ucw.cz>
References: <20051114212341.724084000@sergelap>
	<20051114153649.75e265e7.pj@sgi.com>
	<20051115055107.GB3252@IBM-BWN8ZTBWAO1>
	<20051113152214.GC2193@spitz.ucw.cz>
	<9901B851-17B2-4AEB-813F-A92560DFE289@mac.com>
	<20051116203603.GA12505@elf.ucw.cz>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could we switch
> to 128-bits so that pids are never reused or something like that?

Not easily.  We've got a very cool pid-dispenser at this point that
has excellent performance and scalability, but requires a bit map,
one bit per potential pid.  That bitmap can't exceed a small percentage
of main memory on most any configuration, constraining us to perhaps
20 to 30 bits.  The code currently has a 22 bit arbitrary limit.
Something like 30 bits would usually only make sense on the terabyte
NUMA monster boxes.

128-bit UUID technology scales fine, but adds quite a few compute
cycles per allocation, and would blow out a whole lot of user code
expecting to put a pid in a machine word.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
