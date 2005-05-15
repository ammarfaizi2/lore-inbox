Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVEOKZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVEOKZV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 06:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbVEOKZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 06:25:21 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:1726 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S261596AbVEOKZP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 06:25:15 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 7/8] ppc64: SPU file system
Date: Sun, 15 May 2005 12:08:52 +0200
User-Agent: KMail/1.7.2
Cc: Greg KH <greg@kroah.com>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
       Anton Blanchard <anton@samba.org>
References: <200505132117.37461.arnd@arndb.de> <200505141505.08999.arnd@arndb.de> <1116138546.5095.6.camel@gaston>
In-Reply-To: <1116138546.5095.6.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200505151208.54229.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sünndag 15 Mai 2005 08:29, Benjamin Herrenschmidt wrote:
> Why not just write(pc) to start and read back status from the same
> file ?

I suppose you are thinking of the simple_transaction_read() style
interface. I've got the feeling that this is generally even
less popular than ioctl because 

- it is still an untyped interface (as would be a read() based one)
- you can't do 32 bit emulation (doesn't matter for me, we only
  have 32 bit data)
- it is non-atomic
- it doubles the system call overhead

One operation that I want to allow is to have an infinite loop
running on the SPU that does a simple operation (e.g. process
one MPEG macroblock) and have that called by multiple unrelated
processes in turns. When my operation is not atomic, users need
to have additional IPC serialization of their accesses. Most
would want that anyway, but it is not a requirement with an
interface that needs only a single system call.

For the extra syscall overhead, I would like to see measurements
of a real world application before I change to an interface that
is slower in theory. Do you have measurements for the time spent
in a trivial system call on G5 or Power4?

	Arnd <><
