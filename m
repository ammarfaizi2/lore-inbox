Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270517AbTG1TsT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 15:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270519AbTG1TsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 15:48:19 -0400
Received: from pat.uio.no ([129.240.130.16]:3978 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S270517AbTG1TsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 15:48:15 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16165.32242.536710.725927@charged.uio.no>
Date: Mon, 28 Jul 2003 21:48:02 +0200
To: Paul Mundt <lethal@linux-sh.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS weirdness in 2.6.0-test1
In-Reply-To: <20030726015007.GA18944@linux-sh.org>
References: <20030725151127.GA2947@linux-sh.org>
	<16161.25923.623651.618044@charged.uio.no>
	<20030726015007.GA18944@linux-sh.org>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Paul Mundt <lethal@linux-sh.org> writes:

     > Any other suggestions?

I think I've found the problem. It is due to us overwriting
req->rq_rcv_buf in call_encode() while the RPC request is still on the
list waiting for a reply from the server.

Actually, this *is* likely to be an issue on 2.4.x too, but as it is
also going to be very timing related, you are probably being lucky in
one case, and not the other.

I'll draw up a patch some time in the next 24 hours...

Cheers,
  Trond
