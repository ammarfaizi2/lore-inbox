Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWCaITf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWCaITf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 03:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWCaITf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 03:19:35 -0500
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:27093 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751262AbWCaITe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 03:19:34 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17452.58762.293670.563445@wombat.chubb.wattle.id.au>
Date: Fri, 31 Mar 2006 19:17:14 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, Andrew Morton <akpm@osdl.org>,
       balbir@in.ibm.com, greg@kroah.com, arjan@infradead.org, hadi@cyberus.ca,
       ak@suse.de, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [Patch 0/8] per-task delay accounting
In-Reply-To: <442CBDC8.50401@watson.ibm.com>
References: <442B271D.10208@watson.ibm.com>
	<20060329210314.3db53aaa.akpm@osdl.org>
	<20060330062357.GB18387@in.ibm.com>
	<20060329224737.071b9567.akpm@osdl.org>
	<442C140C.8040404@watson.ibm.com>
	<17452.39418.693521.149502@wombat.chubb.wattle.id.au>
	<442CBDC8.50401@watson.ibm.com>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Shailabh" == Shailabh Nagar <nagar@watson.ibm.com> writes:

Shailabh> Peter Chubb wrote:
 (microstate accounting patch)
>>  It's still maintained in a sporadic sort of way --- I update it
>> when either I need it for something, or someone's downloaded it and
>> asks why it doesn't work agains kernel X.Y.Z.  I see a few
>> downloads a month.
>> 
>> 
Shailabh> So do you intend to pursue acceptance ? If so, do you think
Shailabh> the netlink-based taskstats interface provided by the delay
Shailabh> accounting patches could be an acceptable substitute for the
Shailabh> interfaces you had (from an old lkml post, they appear to be
Shailabh> /proc/tgid/msa and a syscall based one) ?
 
I'd have to take a close look.  The syscall interface is modelled on
getrusage(), and only lets you get your own or your children's data;
I'm not too worried about trashing it, as it should be possible to
emulate in terms of netlink (albeit at a cost; system calls are
relatively cheap)

/proc/<pid>/task/<tid>/msa lets you get at anything you own.  I use
awk scripts to process the msa file in /proc/... and pipe it into
gnuplot at n second intervals; a netlink interface would need to have
an auxiliary program to read it and then squirt it into the scripts, I
think --- or is there a way to get ASCII out on demand?  I quite often
use cat to do quick checks on whats going on too --- so overall I think
the /proc interface is desirable.

-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
http://www.ertos.nicta.com.au           ERTOS within National ICT Australia
