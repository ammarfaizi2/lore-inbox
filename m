Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266705AbUG1Whn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266705AbUG1Whn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 18:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266683AbUG1Whl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 18:37:41 -0400
Received: from mail013.syd.optusnet.com.au ([211.29.132.67]:4741 "EHLO
	mail013.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266705AbUG1WeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 18:34:20 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16648.10711.200049.616183@wombat.chubb.wattle.id.au>
Date: Thu, 29 Jul 2004 08:33:59 +1000
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: stat very inefficient
In-Reply-To: <233602095@toto.iv>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "viro" == viro  <viro@parcelfarce.linux.theplanet.co.uk> writes:

On Tue, Jul 27, 2004 at 08:13:01PM -0700, David S. Miller wrote:
>> I was about to make sparc64 specific copies of all the stat system
>> calls in order to optimize this properly.  But that makes little
>> sense, instead I think fs/stat.c should call upon arch-specific
>> stat{,64} structure fillin routines that can do the magic, given a
>> kstat struct.
>> 
>> Comments?

viro> I'm not sure that it's worth doing for anything below the
viro> "widest" version of stat.  For that one - yeah, no objections.

Agree -- glibc redirects stat() to stat64() under many compilation
models.

But is stat{,64} actually showing up badly in profiles?
If it's not I don't think it's worth doing *anything* (I can imagine
loads where it would, e.g., make on a large sourcetree, or running a
backup)


--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*



