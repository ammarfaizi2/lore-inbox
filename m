Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262976AbUBZUQn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 15:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262964AbUBZUNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 15:13:22 -0500
Received: from mail010.syd.optusnet.com.au ([211.29.132.56]:28045 "EHLO
	mail010.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262977AbUBZUMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 15:12:32 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16446.21156.906300.266465@wombat.chubb.wattle.id.au>
Date: Fri, 27 Feb 2004 07:10:12 +1100
To: davidm@hpl.hp.com
Cc: Andrew Morton <akpm@osdl.org>, Peter Chubb <peter@chubb.wattle.id.au>,
       kingsley@aurema.com, linux-kernel@vger.kernel.org
Subject: Re: /proc visibility patch breaks GDB, etc.
In-Reply-To: <16446.19305.637880.99704@napali.hpl.hp.com>
References: <16445.37304.155370.819929@wombat.chubb.wattle.id.au>
	<20040225224410.3eb21312.akpm@osdl.org>
	<16446.19305.637880.99704@napali.hpl.hp.com>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David Mosberger <davidm@napali.hpl.hp.com> writes:

>>>>> On Wed, 25 Feb 2004 22:44:10 -0800, Andrew Morton <akpm@osdl.org> said:
Andrew> Peter Chubb <peter@chubb.wattle.id.au> wrote:
  >> 
  >> The immediate symptom is GDB saying: Could not open
  >> /proc/757/status when 757 is a TID not a PID.

Andrew> What does `ls /proc/757' say?  Presumably no such file or
Andrew> directory?  It's fairly bizare behaviour to be able to open
Andrew> files which don't exist according to readdir, which is why
Andrew> we made that change.

David> Excuse, but this seems seriously FOOBAR.  I understand that
David> it's interesting to see the thread-leader/thread relationship,
David> but surely that's no reason to break backwards compatibility
David> and the ability to look up _any_ task's info via /proc/PID/.  A
David> program that only wants to show "processes" (thread-group
David> leaders) can simply read /proc/PID/status and ignore the
David> entries for which Tgid != PPid.

Think of scanning /proc on a large SMP machine (e.g., Altix with >512
processors) running lots and lots of multithreaded processes to find
all processes --- like ps(1) does --- and you can see why not
cluttering up /proc with threads is a good idea.


--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
