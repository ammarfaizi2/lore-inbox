Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUCLGbA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 01:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbUCLGbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 01:31:00 -0500
Received: from ms-smtp-02-smtplb.tampabay.rr.com ([65.32.5.132]:12238 "EHLO
	ms-smtp-02.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S261987AbUCLGa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 01:30:56 -0500
Message-ID: <001101c407fb$de49c9e0$6401a8c0@epimetheus>
From: "Timothy Miller" <tmiller10@cfl.rr.com>
To: <linux-kernel@vger.kernel.org>
Subject: Ah!  Found a bug in radeonfb.c!
Date: Fri, 12 Mar 2004 01:33:01 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was WONDERING why certain things would get corrupted on the screen when
using the radeon framebuffer driver.  I've been seeing a number of
off-by-one errors.

First of all, the kernel source I'm looking at is 2.4.22-gentoo-r7.

Anyhow, here's the deal.  Look at the function 'fbcon_radeon_bmove'.  I'm
having to type this in by hand due to circumstances, so, here's something
that looks vaguely like a patch but which will require people to actually
look at (I've never submitted a patch before, so let's just discuss it
first):

line 4399:
    if (srcy < dsty) {
-        srcy += height;
-        dsty += height;
+        srcy += height-1;
+        dsty += height-1;
    } else


line 4404:
    if (srcx < dstx) {
-        srcx += width;
-        dstx += width;
+        srcx += width-1;
+        dstx += width-1;
    }





