Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269121AbUJQNft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269121AbUJQNft (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 09:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269127AbUJQNft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 09:35:49 -0400
Received: from gate.in-addr.de ([212.8.193.158]:46025 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S269121AbUJQNfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 09:35:46 -0400
Date: Sun, 17 Oct 2004 15:35:37 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041017133537.GL7468@marowsky-bree.de>
References: <20041016062512.GA17971@mark.mielke.cc> <MDEHLPKNGKAHNMBLJOLKMEONPAAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKMEONPAAA.davids@webmaster.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-10-16T17:28:24, David Schwartz <davids@webmaster.com> wrote:

> The kernel elects to drop the packet on the call to 'recvmsg'. This is its
> right -- it can drop a UDP packet at any time. POSIX is careful not to imply
> that 'select' guarantees future behavior because this is not possible in
> principle.

I'm sorry, but according to my reading of POSIX and the Austin spec,
this is exactly what select() returning 'ready to read' implies.

The SuV spec is actually quite detailed about the options here:

	A descriptor shall be considered ready for reading when a call
	to an input function with O_NONBLOCK clear would not block,
	whether or not the function would transfer data successfully.
	(The function might return data, an end-of-file indication, or
	an error other than one indicating that it is blocked, and in
	each of these cases the descriptor shall be considered ready for
	reading.)

This actually forbids recvmsg() to return EAGAIN and EWOULDBLOCK as
has been suggested. EIO seems to be the best fit.

But I'd have to agree that blocking on recvmsg() after select() has
indicated ready to read does violate the specification, unless the
socket has actually been opened with O_NONBLOCK.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX AG - A Novell company

