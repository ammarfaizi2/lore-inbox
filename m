Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129706AbRBYUdp>; Sun, 25 Feb 2001 15:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129715AbRBYUdf>; Sun, 25 Feb 2001 15:33:35 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:30480 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129706AbRBYUdY>; Sun, 25 Feb 2001 15:33:24 -0500
Date: Sun, 25 Feb 2001 15:32:47 -0500
From: Chris Mason <mason@suse.com>
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs: still problems with tail conversion
Message-ID: <1026050000.983133167@tiny>
In-Reply-To: <20010225173752.A866@arthur.ubicom.tudelft.nl>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, found it.  It is related to the last null byte problem in that it also
only happens when the direct item is split between two blocks.  This is
more likely as the tail increases in size, which is why you saw it on
larger small files.

The bug is in the code that zeros the unused part of the unformatted node
after a direct->indirect conversion.  This code only gets called when the
page/buffer wasn't already up to date, which is why you see it more when
there is less ram.

Fix will be out shortly....

-chris

