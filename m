Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262305AbVF2ANv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262305AbVF2ANv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 20:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbVF2ANV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 20:13:21 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:36003 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S262305AbVF2ALy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 20:11:54 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Christoph Lameter <christoph@lameter.com>
Subject: Re: [PATCH] Read only syscall tables for x86_64 and i386
Date: Wed, 29 Jun 2005 02:06:13 +0200
User-Agent: KMail/1.7.2
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0506281141050.959@graphe.net.suse.lists.linux.kernel> <p73r7emuvi1.fsf@verdi.suse.de> <Pine.LNX.4.62.0506281238320.1734@graphe.net>
In-Reply-To: <Pine.LNX.4.62.0506281238320.1734@graphe.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506290206.15221.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dinsdag 28 Juni 2005 21:41, Christoph Lameter wrote:

> The ability to protect a readonly section may be another issue.

Exactly. Mapping the readonly section readonly adds a nice way to
check that constant data is handled correctly by all of the code.
Otherwise, there might be some surprises if gcc performs
constant folding and we incorrectly rely on one copy to be writable.

A read-only text segment also raises the bar for authors of rootkits
or other evil hacks that patch the running kernel code.

Right now, s390 (and I believe arm, maybe others as well) is already
able to map in the readonly sections of the kernel from ROM, in order
to have more available RAM for other purposes.

	Arnd <><
