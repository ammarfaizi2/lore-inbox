Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262183AbVCHXLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbVCHXLQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 18:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbVCHXJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 18:09:53 -0500
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:15556 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262183AbVCHXE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 18:04:26 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <16942.12134.913207.508414@wombat.chubb.wattle.id.au>
Date: Wed, 9 Mar 2005 10:04:06 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Kristian =?iso-8859-1?q?S=F8rensen?= <ks@cs.aau.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reading large /proc entry from kernel module
In-Reply-To: <200503081445.56237.ks@cs.aau.dk>
References: <200503081445.56237.ks@cs.aau.dk>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Kristian" == Kristian Sørensen <ks@cs.aau.dk> writes:

Kristian> Hi all!  I have some trouble reading a 2346 byte /proc entry
Kristian> from our Umbrella kernel module.


Kristian> static int umb_proc_write(struct file *file, const char *buffer,
Kristian>                          unsigned long count, void *data) {
Kristian>	char *policy;
Kristian>	int *lbuf;
Kristian>	int i;

Here's your problem:  lbuf should be a char * not an int *.
When you look lbuf[0] you'll get the first four characters packed
into the int.
-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
