Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264364AbTEHA4F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 20:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbTEHA4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 20:56:05 -0400
Received: from air-2.osdl.org ([65.172.181.6]:6554 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264364AbTEHA4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 20:56:04 -0400
Date: Wed, 7 May 2003 18:05:30 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: garbled oopsen
Message-Id: <20030507180530.23d0e780.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have several oopses that are garbled.  Part of the problem is that
page fault code (x86: arch/i386/mm/fault.c) does not attempt to
serialize the "Unable to handle kernel ... at virtual address ..."
messages, since it's considered better to get _some_ messages out
than no messages.  (and serialize it with what?)

However, after untwisting these, I can tell you that unraveling
them is not fun.

Can these be cleaned up in any reasonable way?
Any suggestions?

This is on 2.5.68 and 2.5.69.


(sample 1)
i
de-sUcnsaibl:e  hdtod :h asuncd l1e 80ke22rn0e1l96 p3aging request at virtual address 6b6b6b8b

(sample 2)
i<de1->Usncsaibl:e h dtod: h saunc dl18e 0k2e20r1ne96l3 p

which decodes into:
i de -  s cs i  :  h d  d:   s u c   18  0 2 20 1  96 3
 <  1 >U n  a bl e    to   h  a n  dl  e  k e  r ne  l  p

(sample 3, much longer)
scsi_eh_<pr4>t_hfdadi: lA_TstAaPIts r: e2se:t0: 0co:m0 plcmetdse 
failiedde:- sc0s,i :c anRecaeclh: ed1 
idTeosctsali_ pofc_ 1in ctro mminantdersr oupnt 1  hdanedvliceres
 rePaqcuikrete  ceho mmwoanrdk
 cosmcplsiet_ehe_d,2 : 0 abboyrttesin tgr canmdsf:e0rxrf7eddb
f1didc
e-scidsei-: shcsddi::  achbeorckt  icognndoiretdi
on sfocsr i_1e41h_
2: iabdoe-rstcisngi : chmddd :f aqilueedue: 0xcmf7dd b= f1[d c3 
0 0s cs0i _4e0 h_02 :]
 Seinddie-ngs cBsiD:R  Rsdeaevc:h ed0xf i7ddde5sccs0i0_
pci_dien-trs cisin:te rdrevuiptc e harensdelte ri
gnoidreed-s
csiid: eR-escaschi:ed h iddd:e scqsuei_ 1p4c1_i, nctmrd  i=n te[r 0 ru0p 0t  h0 a0nd 0le r]

/end/
