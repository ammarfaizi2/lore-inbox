Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbWILHfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWILHfs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 03:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWILHfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 03:35:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:58009 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750935AbWILHfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 03:35:47 -0400
Subject: i386 PDA patches use of %gs
From: Arjan van de Ven <arjan@infradead.org>
To: akpm@osdl.org, ak@suse.de, mingo@elte.hu,
       Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 12 Sep 2006 09:35:40 +0200
Message-Id: <1158046540.2992.5.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Userspace uses %gs for it's per thread data (and in modern linux
versions that means "all the time", errno is there for example).

On x86-64 this is the reason that the kernel uses the OTHER segment
register; so for the PDA patches this would mean using %fs and not %gs.

The advantage of this is very simple: %fs will be 0 for userspace most
of the time. Putting 0 in a segment register is cheap for the cpu,
putting anything else in is quite expensive (a LOT of security checks
need to happen). As such I would MUCH rather see that the i386 PDA
patches use %fs and not %gs... 

Jeremy, is there a reason you're specifically using %gs and not %fs? If
not, would you mind a switch to using %fs instead?

Greetings,
   Arjan van de Ven
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

