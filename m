Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWHJUAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWHJUAI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932705AbWHJUAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:00:02 -0400
Received: from pat.uio.no ([129.240.10.4]:30386 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932707AbWHJT76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:59:58 -0400
Subject: Re: Urgent help needed on an NFS question, please help!!!
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Neil Brown <neilb@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <4ae3c140608101102j3ec28dccob94d407b9879aa86@mail.gmail.com>
References: <4ae3c140608092204n1c07152k52010a10e209bb77@mail.gmail.com>
	 <17626.49136.384370.284757@cse.unsw.edu.au>
	 <4ae3c140608092254k62dce9at2e8cdcc9ae7a6d9f@mail.gmail.com>
	 <17626.52269.828274.831029@cse.unsw.edu.au>
	 <4ae3c140608100815p57c0378kfd316a482738ee83@mail.gmail.com>
	 <20060810161107.GC4379@parisc-linux.org>
	 <4ae3c140608100923j1ffb5bb5qa776bff79365874c@mail.gmail.com>
	 <1155230922.10547.61.camel@localhost>
	 <4ae3c140608101102j3ec28dccob94d407b9879aa86@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 10 Aug 2006 15:59:42 -0400
Message-Id: <1155239982.5826.24.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-0.769, required 12,
	autolearn=disabled, AWL -0.48, NIGERIAN_SUBJECT2 1.76,
	PLING_PLING 0.43, RCVD_IN_XBL 2.51, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-10 at 14:02 -0400, Xin Zhao wrote:
> Thanks. Trond.
> 
> The device is subject to change when server reboot? I don't quite
> understand. If the backing device at the server side is not changed,
> how come server reboot will cause device ID change?

Things like USB, firewire, and fibre channel allocate their device ids
on the fly. There is no such thing as a fixed device id in those cases.

> About your comment on the second conclusion, I already explained in
> one of my previous email. We assume that both server and clients are
> under our control. That is, we don't consider too much about
> interoperability.  The file handle format will be static even the NFS
> server is changed. Actually, in our inter-VM inode sharing scheme, we
> don't even care about the normal file handle contents. Instead, we
> only check our extended fields, which include: server-side inode
> address, ino, dev info, i_generation and server_generation. An NFS
> client first uses the server-side inode address to locate the inode
> object in the server inode cache (we dynamically remapped the inode
> cache into the client, in order to expedite metadata retrieval and
> bypass inter-VM communication). After getting the inode object, the
> NFS client has to validate this inode object corresponds to the file
> handle so that it can read the right file attributes stored in the
> inode. There are many possibilities that can cause a located inode
> stores false information: the inode has been released because someone
> on the server remove the file, the inode was filled by another file's
> inode (other possibilities?).  So we must validate the inode before
> using the file attributes retrieved from the mapped inode.
> 
> That's why we bring up this question.

Why do this, when people are working on standards and implementations
for doing precisely the above within the NFSv4 protocol?

> Also, does someone compare NFS v4's delegation mechanism with the
> speculative execution mechanism proposed in SOSP 2005
> http://www.cs.cmu.edu/~dga/15-849/papers/speculator-sosp2005.pdf?
> 
> What are the pros and cons of these two mechanisms?

Delegations are all about caching. This paper appears to be about
getting round the bottlenecks due to synchronous operations. How are the
two issues related?

Cheers,
  Trond

