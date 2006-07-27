Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbWG0Osq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWG0Osq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 10:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWG0Osq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 10:48:46 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50139 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751084AbWG0Osp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 10:48:45 -0400
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@zeniv.linux.org.uk, tytso@mit.edu, tigran@veritas.com
In-Reply-To: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Jul 2006 16:07:02 +0100
Message-Id: <1154012822.13509.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-07-27 am 17:25 +0300, ysgrifennodd Pekka J Enberg:
> There are two known remaining issues: if someone expands the fd
> tables, we will BUG_ON. Edgar Toerning expressed concers over allowing
> any user to remove mappings from another process and letting it
> crash. Albert Cahalan suggested either converting the shared mapping
> to private or substitute the unmapped pages with zeroed pages.

That should be three I think. frevoke and revoke should not return until
all the existing outstanding is dead. For devices that means we need to
wake up the device where possible and really suggests we need a device
->revoke method. TTY devices need this to allow us to re-implement
vhangup in terms of revoke. Other devices devices are not all
sufficiently secure without this check. Some may also want to use this
hook to ensure that any security context is dead (eg cached crypto
keys).

Alan

