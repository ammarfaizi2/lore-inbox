Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318376AbSGaN5T>; Wed, 31 Jul 2002 09:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318378AbSGaN5T>; Wed, 31 Jul 2002 09:57:19 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:38413 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S318376AbSGaN5Q>;
	Wed, 31 Jul 2002 09:57:16 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Rik van Riel <riel@conectiva.com.br>
Date: Wed, 31 Jul 2002 16:00:20 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: BUG at rmap.c:212
CC: akpm@zip.com.au, <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.50
Message-ID: <AE2FE25828@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Jul 02 at 10:11, Rik van Riel wrote:
> On Wed, 31 Jul 2002, Petr Vandrovec wrote:
> 
> > > Line 212 is   'pte_chain_unlock(page);'   right ?
> >
> > Nope. On my system (2.5.29-changeset548) it is a BUG() call which was
> > added by akpm in rmap.c revision 1.5, in his 'Add BUG() on a can't-happen
> > code path in page_remove_rmap()'. It just added #else BUG() branch
> > to #ifdef DEBUG_RMAP conditional.
> 
> > Probably because of your code did not do anything special when
> > 'Not found. This should NEVER happen!' code path triggers.
> Of course, ntpd is probably running into a different problem,
> but the printk's enabled with DEBUG_RMAP should give us some
> hints.

No nvidia here. Boot, start X, quit X, run updatedb, reboot...
cat /proc/`pidof ntpd`/maps says that it has mmaped only ntpd and
few libraries from /lib. I hope that printed values will have
some value for you. And btw, ntpd uses some mlock*() call, it has status
'SL' in process list. Do you know how to find what memory it has locked?

Jul 31 15:38:13 vana sshd[1303]: Received signal 15; terminating.
Jul 31 15:38:13 vana ntpd[1326]: ntpd exiting on signal 15
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893098 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc89309c not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc8930a0 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc8930a4 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana wwwoffled[1311]: Exit signalled. 
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893100 not present.
Jul 31 15:38:13 vana wwwoffled[1311]: Exiting. 
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893228 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc89322c not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893230 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893234 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: dbbde210 dadfe210 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893238 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc89323c not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893240 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893260 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: dec759c4 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc8932d4 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893310 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: db27f1e8 dbbde2ec dadfe2ec 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893314 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: db27f1ec dbbde2f0 dadfe2f0 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc89331c not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: db27f1f4 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893380 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893438 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc89343c not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: dbbde418 dadfe418 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893448 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: dbbde424 dadfe424 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc8934b0 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc8934c0 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc8934d0 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: dbbde4ac dadfe4ac 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc8934d4 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: dbbde4b0 dadfe4b0 dfc5c3ac cddaf3ac d418c3ac ca9353ac c559a3ac 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc8934ec not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: dbbde4c8 dadfe4c8 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893520 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893528 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc89353c not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893550 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893554 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893558 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893560 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893568 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc89356c not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893570 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893574 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc89358c not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: dbbde568 dadfe568 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893590 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: dfc5c468 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893594 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: dfc5c46c 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893604 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: dbbde5e0 dadfe5e0 dfc5c4dc 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893630 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: dbbde098 dadfe098 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893634 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: dbbde09c dadfe09c 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893638 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: dbbde0a0 dadfe0a0 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc89363c not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: dbbde0a4 dadfe0a4 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893640 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: dbbde0a8 dadfe0a8 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893644 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: dbbde0ac dadfe0ac 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893648 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: dbbde0b0 dadfe0b0 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc89364c not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: dbbde0b4 dadfe0b4 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893650 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: dbbde0b8 dadfe0b8 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893654 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: dbbde0bc dadfe0bc 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc893658 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: dbbde0c0 dadfe0c0 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc89365c not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: dbbde0c4 dadfe0c4 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc8936b0 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc8936c8 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc8936cc not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc8936e0 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc8936e8 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: dbbde150 dadfe150 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc8936f0 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:13 vana kernel: page_remove_rmap: pte_chain dc8936f4 not present.
Jul 31 15:38:13 vana kernel: page_remove_rmap: only found: 
Jul 31 15:38:13 vana kernel: page_remove_rmap: driver cleared PG_reserved ?
Jul 31 15:38:15 vana kernel: Kernel logging (proc) stopped.
Jul 31 15:38:15 vana kernel: Kernel log daemon terminating.

                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
