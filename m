Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262174AbTCRFbu>; Tue, 18 Mar 2003 00:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262177AbTCRFbu>; Tue, 18 Mar 2003 00:31:50 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:55746 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S262174AbTCRFbt>; Tue, 18 Mar 2003 00:31:49 -0500
To: linux-kernel@vger.kernel.org
Subject: kconfig question
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 18 Mar 2003 14:42:37 +0900
Message-ID: <buor895jkmq.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the following two entries in my Kconfig file (arch/v850/Kconfig):

   config RTE_CB_MULTI
   	  bool
	  # RTE_CB_NB85E can either have multi ROM support or not, but
	  # other platforms (currently only RTE_CB_MA1) require it.
	  prompt "Multi monitor ROM support" if RTE_CB_NB85E
	  depends RTE_CB
	  default y

   config RTE_CB_MULTI_DBTRAP
   	  bool "Pass illegal insn trap / dbtrap to kernel"
	  depends RTE_CB_MULTI
	  default n

What I expec this to do is to only ask the first question (RTE_CB_MULTI)
if RTE_CB_NB85E is true and otherwise just assume true -- this part
seems to work correctly -- but to _always_ ask the second question
(RTE_CB_MULTI_DBTRAP) as long as its dependencies are true.

However, what happens in practice is that the second question is only
displayed if the first question is displayed (the resulting actual value
of RTE_CB_MULTI_DBTRAP is whatever value it had before I entered the
menuconfig).

So... is this a bug?  If not, is there some other way I can have a
question [a] depend on another question [b], where [b] is optional
(defaulting to y), but [a] is not?

Thanks,

-Miles
-- 
Saa, shall we dance?  (from a dance-class advertisement)
