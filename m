Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267809AbUHFN7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267809AbUHFN7V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 09:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268006AbUHFN7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 09:59:21 -0400
Received: from the-village.bc.nu ([81.2.110.252]:7105 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267809AbUHFN7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 09:59:17 -0400
Subject: Re: Linux kernel file offset pointer races
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Kankovsky <peak@argo.troja.mff.cuni.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040804214056.6369.0@argo.troja.mff.cuni.cz>
References: <20040804214056.6369.0@argo.troja.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091796995.16306.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 06 Aug 2004 13:56:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-08-04 at 21:36, Pavel Kankovsky wrote:
> IMHO, the proper fix is to serialize all operations modifying a shared
> file pointer (file->f_pos): read(), readv(), write(), writev(),
> lseek()/llseek(). As far as I can tell, this is required by POSIX:

Not if you want to get any useful work done. No Unix does this. The
situation with multiple parallel lseek/read/writes is somewhat undefined
anyway since you don't know if the seek or the write occurred first in
user space.

O_APPEND is a bit different, as are pread/pwrite but those are dealt
with using locking for files.


