Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030347AbWBWAwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030347AbWBWAwx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 19:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbWBWAwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 19:52:53 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:10247 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1030347AbWBWAwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 19:52:53 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: spinlock __raw_spin_unlock : comment disagrees with Wikipedia article
Date: Wed, 22 Feb 2006 16:51:46 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKKEMGKEAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Wed, 22 Feb 2006 16:48:18 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Wed, 22 Feb 2006 16:48:19 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    The code for __raw_spin_unlock contains the following comment:

/*
 * __raw_spin_unlock based on writing $1 to the low byte.
 * This method works. Despite all the confusion.
 * (except on PPro SMP or if we are using OOSTORE, so we use xchgb there)
 * (PPro errata 66, 92)
 */

    Yet the Wikipedia article on spinlocks says:

http://en.wikipedia.org/wiki/Spinlock
"In theory, spin_unlock could use an unlocked MOV instead of the locked
XCHG, however some processors (notably, some Cyrix processors and some
revisions of the Intel Pentium III) will do the wrong thing and data
protected by the lock could be corrupted."

    Does anyone know for sure who is right? I assume if the Linux kernel was
wrong, it would probably be blowing up by now. Or does it rely on something
that isn't guaranteed but happens to work on all current hardware? Or
perhaps it's some kind of very rare issue. What is the source for the
comment about "some revisions of the Intel Pentium II"? Does one know?

    Is 'movb' okay, but perhaps some other type of instructions might not
work, such as a 32-bit operation?

    DS


