Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbVC2Xcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVC2Xcl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 18:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVC2Xcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 18:32:41 -0500
Received: from mail26.syd.optusnet.com.au ([211.29.133.167]:923 "EHLO
	mail26.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261648AbVC2Xcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 18:32:39 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16969.58762.180127.283274@wombat.chubb.wattle.id.au>
Date: Wed, 30 Mar 2005 09:32:26 +1000
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Chris Friesen <cfriesen@nortel.com>
Cc: krishna <krishna.c@globaledgesoft.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to measure time accurately.
In-Reply-To: <4248E282.1000105@nortel.com>
References: <424779F3.5000306@globaledgesoft.com>
	<4248E282.1000105@nortel.com>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Chris" == Chris Friesen <cfriesen@nortel.com> writes:

Chris> krishna wrote:
>> Hi All,
>> 
>> Can any one tell me how to measure time accurately for a block of C
>> code in device drivers.  For example, If I want to measure the time
>> duration of firmware download.

Chris> Most cpus have some way of getting at a counter or decrementer
Chris> of various frequencies.  Usually it requires low-level hardware
Chris> knowledge and often it needs assembly code.

As a device driver is inside the linux kernel (unless you're writein a
user-mode device driver :-)) you can use the getcycles() macro that's
defined for most architectures.  It provides a snapshot of the
cycle-counter.

Caveats:
	1.  If you're running with power management, the  cycle
	    counter ticks at a  variable rate.
	2.  If you're on a multiprocessor, the cycle counters of
	    different processors need not be synchronised.
-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
