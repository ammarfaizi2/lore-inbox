Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261921AbVAYMr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbVAYMr7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 07:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVAYMr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 07:47:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52446 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261921AbVAYMry (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 07:47:54 -0500
Subject: Re: journaled filesystems -- known instability; Was: XFS: inode
	with st_mode == 0
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
Cc: Stephen Tweedie <sct@redhat.com>, Jakob Oestergaard <jakob@unthought.net>,
       Christoph Hellwig <hch@infradead.org>,
       David Greaves <david@dgreaves.com>, Jan Kasprzak <kas@fi.muni.cz>,
       linux-kernel <linux-kernel@vger.kernel.org>, kruty@fi.muni.cz
In-Reply-To: <41EC2ECF.6010701@mnsu.edu>
References: <20041209125918.GO9994@fi.muni.cz>
	 <20041209135322.GK347@unthought.net> <20041209215414.GA21503@infradead.org>
	 <20041221184304.GF16913@fi.muni.cz> <20041222084158.GG347@unthought.net>
	 <20041222182344.GB14586@infradead.org> <41E80C1F.3070905@dgreaves.com>
	 <20050114182308.GE347@unthought.net> <20050116135112.GA24814@infradead.org>
	 <20050117100746.GI347@unthought.net>  <41EC2ECF.6010701@mnsu.edu>
Content-Type: text/plain
Message-Id: <1106657254.1985.294.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 25 Jan 2005 12:47:35 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2005-01-17 at 21:31, Jeffrey Hundstad wrote:
> For more of this look up subjects:
>   Bad things happening to journaled filesystem machines
>   Oops in kjournald

That seems to have been due to the xattr problems recently fixed in
Linus's tree.  The xattr race was allowing one process to delete an
unshared xattr block while another was trying to share it, and the
journaling code was getting upset when the second process then tried to
commit the now-deleted block.

--Stephen


