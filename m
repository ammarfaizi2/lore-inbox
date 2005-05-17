Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbVEQQ5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbVEQQ5l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 12:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbVEQQ5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 12:57:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28628 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261825AbVEQQ5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 12:57:35 -0400
Date: Tue, 17 May 2005 17:57:56 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Christoph Hellwig <hch@infradead.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>,
       Serge Hallyn <serue@us.ibm.com>
Subject: Re: [patch 2/7] BSD Secure Levels: move bd claim from inode to filp
Message-ID: <20050517165756.GC29811@parcelfarce.linux.theplanet.co.uk>
References: <20050517152303.GA2814@halcrow.us> <20050517152545.GA2944@halcrow.us> <20050517160900.GB32436@infradead.org> <20050517164922.GA29811@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050517164922.GA29811@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 05:49:22PM +0100, Al Viro wrote:
> 	a) have caused open() on that device node, even though caller did
> not ask for that and actually had not planned to do anything with actual
> device.
> 	b) have caused all subsequent permission() for MAY_WRITE fail for
> that sucker [*] until somebody opens and closes device in question (for
> read, obviously).

Actually, that is correct only if that somebody gets the same task_struct
as deceased caller of utime()/whatever had triggered call of permission().
Due to (c) below...

> 	c) seclvl_bd_release() expects, for some reason, to be called when
> task that had called seclvl_bd_claim() to be still alive.  Use of current
> in setting/checking ->i_security is a bad joke.
