Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266517AbUFVBk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266517AbUFVBk1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 21:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266515AbUFVBk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 21:40:27 -0400
Received: from mail016.syd.optusnet.com.au ([211.29.132.167]:30345 "EHLO
	mail016.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266517AbUFVBkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 21:40:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16599.36319.269156.432040@wombat.chubb.wattle.id.au>
Date: Tue, 22 Jun 2004 11:39:43 +1000
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: s0348365@sms.ed.ac.uk
Cc: Martin Schlemmer <azarah@nosferatu.za.org>,
       Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] kbuild updates
In-Reply-To: <539000871@toto.iv>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alistair" == Alistair John Strachan <s0348365@sms.ed.ac.uk> writes:


Alistair> Sam, maybe if there was a way to easily detect whether a
Alistair> kernel had been build with or without a different output
Alistair> directory, it would be easier to have vendors take this
Alistair> change on board. For example, I imagine in the typical case
Alistair> whereby no change in build directory is made, you will have
Alistair> something like this:


You can do this without any changes:

     if [ -d /lib/modules/`uname -r`/build/include2 ]; then
       kerndir=`cd  /lib/modules/`uname -r`/build/include2/asm; cd -P../..;/bin/pwd`
     else
       kerndir=`cd /lib/modules/`uname -r`/build; /bin/pwd`
    fi


But can the include2/asm symlink be made a relative one, please?  I frequently
build on one machine, then NFS-mount the build tree and run make
modules_install somewhere else; I always at present have to convert
that link to a relative symlink before doing so.

-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
