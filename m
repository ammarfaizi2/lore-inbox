Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317925AbSGWR6G>; Tue, 23 Jul 2002 13:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318147AbSGWR6G>; Tue, 23 Jul 2002 13:58:06 -0400
Received: from pat.uio.no ([129.240.130.16]:25761 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S317925AbSGWR6G>;
	Tue, 23 Jul 2002 13:58:06 -0400
To: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Problem with msync system call
References: <EE83E551E08D1D43AD52D50B9F511092E1149F@ntserver2.suse.lists.linux.kernel>
	<p73fzyatlsi.fsf@oldwotan.suse.de>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 23 Jul 2002 20:01:07 +0200
In-Reply-To: <p73fzyatlsi.fsf@oldwotan.suse.de>
Message-ID: <shsheiql3x8.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andi Kleen <ak@suse.de> writes:

     > Do a F_SETFL lock/unlock on the file That should act as a full
     > NFS write barrier and flush all buffers. Best is if you
     > synchronize between the various writers with the full lock.

Note: This will not work for files that are in the process of being
mmap()ed. In order to make it all work, you have to munmap() first,
then lock, then mmap().

This is due to limitations in the VM which won't allow anyone to
invalidate a mapping that is in use.

Cheers,
  Trond
