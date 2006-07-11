Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWGKIm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWGKIm3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 04:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWGKIm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 04:42:29 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:42908 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750756AbWGKIm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 04:42:28 -0400
Message-ID: <44B3646F.5030902@fr.ibm.com>
Date: Tue, 11 Jul 2006 10:42:23 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 0/7] execns syscall and user namespace
References: <20060711075051.382004000@localhost.localdomain> <1152604970.3128.15.camel@laptopd505.fenrus.org>
In-Reply-To: <1152604970.3128.15.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

> how does this interact with the unshare() syscall ?

it complements unshare(). The purpose of this syscall is to unshare a
namespace after the process has been flushed.

> can the unshare syscall be rigged up such that you have the same effect?

We need a clean context with no reference in other namespaces to make
unshare safe. It seemed easier to add an improved execve() with an extra
flag than to modify unshare() to make it flush the old exec.

Now, that does not make unshare() useless. It's perfectly acceptable for
uts namespace. But IMO, it's dangerous for ipc namespace and user namespace
which are more complex because they have references all over the place :
network with socket, mm for shmem, files for accounting.

thanks,

C.

