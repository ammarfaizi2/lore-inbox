Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271841AbRIQQQv>; Mon, 17 Sep 2001 12:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271777AbRIQQQc>; Mon, 17 Sep 2001 12:16:32 -0400
Received: from mailhost.opengroup.fr ([62.160.165.1]:5514 "EHLO
	mailhost.ri.silicomp.fr") by vger.kernel.org with ESMTP
	id <S271809AbRIQQQ0>; Mon, 17 Sep 2001 12:16:26 -0400
Date: Mon, 17 Sep 2001 18:16:48 +0200 (CEST)
From: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>
To: <linux-kernel@vger.kernel.org>, <linux-smp@vger.kernel.org>
Subject: [Q] Implementation of spin_lock on i386: why "rep;nop" ?
Message-ID: <Pine.LNX.4.31.0109171725140.26090-100000@sisley.ri.silicomp.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

One of my coworkers directed my attention to the implementation of
spinlocks on IA-32. In spin_lock_string, we can read:

	"cmpb $0,%0\n\t" \
	"rep;nop\n\t" \
	"jle 2b\n\t" \

The "rep;nop" line looks dubious, since the IA-32 programmer's manual from
Intel (year 2001) mentions that the behaviour of REP is undefined when it
is not used with string opcodes. BTW, according to the same manual, REP is
supposed to modify ecx, but it looks like is is not the case here... which
is fortunate, since ecx is never saved. :-)

What is the intent behind this "rep;nop" ? Does it really rely on an
undocumented behaviour ?


Regards,

-- 
Jean-Marc Saffroy - Research Engineer - Silicomp Research Institute
mailto:saffroy@ri.silicomp.fr

