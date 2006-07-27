Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751921AbWG0SQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbWG0SQJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 14:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751916AbWG0SQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 14:16:08 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41600 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751919AbWG0SQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 14:16:06 -0400
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Petr Baudis <pasky@suse.cz>
Cc: Pekka J Enberg <penberg@cs.Helsinki.FI>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org, viro@zeniv.linux.org.uk,
       tytso@mit.edu, tigran@veritas.com
In-Reply-To: <20060727180634.GA28962@pasky.or.cz>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
	 <20060727180634.GA28962@pasky.or.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Jul 2006 19:34:22 +0100
Message-Id: <1154025262.13509.93.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-07-27 am 20:06 +0200, ysgrifennodd Petr Baudis:
> Well, except that you can revoke the log file before the shadow file is
> opened, at which point open() probably reuses the fd and the program
> conveniently logs to /etc/shadow.

revoke() kills *access* by that handle, it does not kill the fd. The BSD
designers thought of that one. Instead you end up with a handle that
reports -ENXIO (from memory) for I/O accesses, ioctl etc until you close
it when it goes away as expected.

Alan

