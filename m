Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267906AbTAMRPN>; Mon, 13 Jan 2003 12:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267907AbTAMRPN>; Mon, 13 Jan 2003 12:15:13 -0500
Received: from pat.uio.no ([129.240.130.16]:935 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S267906AbTAMRPL>;
	Mon, 13 Jan 2003 12:15:11 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Performance problems with NFS under 2.4.20
References: <m3y95pkqpd.fsf@quimbies.gnus.org>
	<shsfzrxrqjb.fsf@charged.uio.no> <m3iswtkp0x.fsf@quimbies.gnus.org>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 13 Jan 2003 18:23:59 +0100
In-Reply-To: <m3iswtkp0x.fsf@quimbies.gnus.org>
Message-ID: <shs3cnxufo0.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Lars Magne Ingebrigtsen <larsi@gnus.org> writes:

     > I have several machines that reads the same files/directories,
     > but only one machine that writes to the directories.  Will that
     > be OK?

If you require your data cache to be guaranteed to be consistent you
still have to use some form of locking to ensure that nobody tries to
read a file that is in the process of being updated on the server.
If so, close-to-open helps by ensuring that you can safely rely on
more lightweight locking protocols such as that provided by the
"lockfile" utility (a.k.a. dotlocking) instead of the full NFS Lock
Manager.

Cheers,
  Trond
