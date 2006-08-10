Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422639AbWHJR3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422639AbWHJR3F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 13:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422634AbWHJR3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 13:29:05 -0400
Received: from pat.uio.no ([129.240.10.4]:36773 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1422635AbWHJR3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 13:29:03 -0400
Subject: Re: Urgent help needed on an NFS question, please help!!!
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Neil Brown <neilb@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <4ae3c140608100923j1ffb5bb5qa776bff79365874c@mail.gmail.com>
References: <4ae3c140608092204n1c07152k52010a10e209bb77@mail.gmail.com>
	 <17626.49136.384370.284757@cse.unsw.edu.au>
	 <4ae3c140608092254k62dce9at2e8cdcc9ae7a6d9f@mail.gmail.com>
	 <17626.52269.828274.831029@cse.unsw.edu.au>
	 <4ae3c140608100815p57c0378kfd316a482738ee83@mail.gmail.com>
	 <20060810161107.GC4379@parisc-linux.org>
	 <4ae3c140608100923j1ffb5bb5qa776bff79365874c@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 10 Aug 2006 13:28:41 -0400
Message-Id: <1155230922.10547.61.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.157, required 12,
	autolearn=disabled, AWL -0.86, NIGERIAN_SUBJECT2 1.76,
	PLING_PLING 0.43, RCVD_IN_XBL 2.51, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-10 at 12:23 -0400, Xin Zhao wrote:
> That makes sense.
> 
> Can we make the following two conclusions?
> 1. In a single machine, inode+dev ID+i_generation can uniquely identify a file

Not really. The device id is frequently subject to change on server
reboot or device disconnect/reconnect.

> 2. Given a stored file handle and an inode object received from the
> server,  an NFS client can safely determine whether this inode
> corresponds to the file handle by checking the inode+dev+i_generation.

No! The file handle is an opaque bag of bytes as far as clients are
concerned. If you change the server, then the filehandle format can and
will change. On linux, even changing the setting of the subtree_checking
export option will suffice to change the filehandle.

Cheers,
   Trond

