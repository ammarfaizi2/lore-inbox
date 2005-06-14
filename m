Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbVFNDdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVFNDdi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 23:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbVFNDdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 23:33:38 -0400
Received: from imf16aec.mail.bellsouth.net ([205.152.59.64]:46758 "EHLO
	imf16aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261407AbVFNDdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 23:33:36 -0400
Message-ID: <002401c57099$394f9070$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: "Coywolf Qi Hunt" <coywolf@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
References: <000b01c5707e$c189c930$2800000a@pc365dualp2> <2cd57c9005061320084de5d80d@mail.gmail.com>
Subject: Re: [RFC] exit_thread() speedups in x86 process.c
Date: Tue, 14 Jun 2005 00:26:11 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem with that approach is GCC would still just relocate the push/pop
block to the bottom of the function.  This means you won't be likely to pick
up anything useful in L1 or L2 as the function exits normally - in fact
you'd typically be guaranteed to be picking up a partial line of gorp that
is completely worthless later on.

This is one of my issues with the notion of unlikely() being smoothed on
everywhere like Bondo<g> - it also makes it "unlikely" that you'll get any
serendipitous L1/L2 advantages that could be had by locating related
functions next to each other.

When you take the unlikely stuff completely out of line in a seperate
functions located elsewhere, the mainline code can make better use of the
caches.  The Intel parts thrive on L1 hits and die if they're not getting
them.

----- Original Message ----- 
From: "Coywolf Qi Hunt" <coywolf@gmail.com>


I see the effect, But I think it would be better to leave the job to
gcc to generate better code for unlikely, imho.

-- 
Coywolf Qi Hunt
http://ahbl.org/~coywolf/

