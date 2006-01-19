Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932590AbWASJuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590AbWASJuA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 04:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbWASJt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 04:49:59 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33481 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932590AbWASJt7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 04:49:59 -0500
Subject: Re: [PATCH] powerpc: remove useless spinlock from mpc83xx watchdog
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kumar Gala <galak@gate.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, wim@iguana.be, linux-kernel@vger.kernel.org,
       linuxppc-embedded@ozlabs.org
In-Reply-To: <Pine.LNX.4.44.0601190057130.8484-100000@gate.crashing.org>
References: <Pine.LNX.4.44.0601190057130.8484-100000@gate.crashing.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Jan 2006 09:49:16 +0000
Message-Id: <1137664156.8471.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-01-19 at 00:58 -0600, Kumar Gala wrote:
> Since we can only open the watchdog once having a spinlock to protect
> multiple access is pointless.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

NAK

This is a common mistake.

open is called on the open() call and is indeed in this case 'single
open', but file handles can be inherited and many users may have access
to a single file handle.

eg

	f = open("/dev/watchdog", O_RDWR);
	fork();
	while(1) {
		write(f, "Boing", 5);
	}

Alan

