Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbWHKApF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWHKApF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 20:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWHKApF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 20:45:05 -0400
Received: from pat.uio.no ([129.240.10.4]:47255 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932385AbWHKApD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 20:45:03 -0400
Subject: Re: Urgent help needed on an NFS question, please help!!!
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Neil Brown <neilb@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <4ae3c140608101525u7b6eeaebjca351ba850173544@mail.gmail.com>
References: <4ae3c140608092204n1c07152k52010a10e209bb77@mail.gmail.com>
	 <17626.49136.384370.284757@cse.unsw.edu.au>
	 <4ae3c140608092254k62dce9at2e8cdcc9ae7a6d9f@mail.gmail.com>
	 <17626.52269.828274.831029@cse.unsw.edu.au>
	 <4ae3c140608100815p57c0378kfd316a482738ee83@mail.gmail.com>
	 <20060810161107.GC4379@parisc-linux.org>
	 <4ae3c140608100923j1ffb5bb5qa776bff79365874c@mail.gmail.com>
	 <1155230922.10547.61.camel@localhost>
	 <4ae3c140608101102j3ec28dccob94d407b9879aa86@mail.gmail.com>
	 <1155239982.5826.24.camel@localhost>
	 <4ae3c140608101525u7b6eeaebjca351ba850173544@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 10 Aug 2006 20:44:54 -0400
Message-Id: <1155257094.5826.101.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-0.978, required 12,
	autolearn=disabled, AWL -0.69, NIGERIAN_SUBJECT2 1.76,
	PLING_PLING 0.43, RCVD_IN_XBL 2.51, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-10 at 18:25 -0400, Xin Zhao wrote:
> The inter-VM inode helps reduce communication cost used to retrieve
> file attributes in a VM environment. In a network environment, it is
> possible for a client to direct see the inode caches of the server.
> But in the virtual server environment, where both client and server
> running on the same physical host, this would be possible.
> 
> If clients have read-only access to server's inode cache, they can
> directly retrieve file attributes without incurring expensive
> getattr() rpc call. Of couse the delegation is able to allow a client
> to trust local cached file attributes without worry about server
> change. But this only works when file is not shared by multiple
> clients. Right? Does NFS4 has some other mechanisms that can further
> improve performance on metadata access?

Not metadata access, no. That would require some seriously messy locking
rules.
It improves performance by allowing a client to access the block device
directly for data reads and writes if it has the capability of doing so.

  Trond

