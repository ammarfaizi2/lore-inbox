Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268939AbTGJFxI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 01:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268940AbTGJFxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 01:53:08 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:53138 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S268939AbTGJFxF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 01:53:05 -0400
Date: Thu, 10 Jul 2003 07:07:44 +0100
From: Jamie Lokier <jamie@shareable.org>
To: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Subject: Re: NFS client errors with 2.5.74?
Message-ID: <20030710060744.GA27308@mail.jlokier.co.uk>
References: <20030710054121.GB27038@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030710054121.GB27038@mail.jlokier.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some more information:

The kernel messages "kernel: nfs: server 192.168.1.1 not responding,
timed out" do have some relationship with the EIO errors after all.

When I "ls" a directory for the first time (i.e. it's not in cache), I
get an EIO _every time_.  It's the getdents64() call which returns EIO.

The second and subsequent times I list that directory, the listing is
fine.  However if I pick another directory which isn't in cache yet,
getdents64() returns EIO.

A packet trace shows something interesting: duplicate requests.

In this case, I see four (4) READDIRPLUS requests with identical XIDs.
Ethereal says that all four are sent in 0.04 seconds.

Then I see four replies, of course with identical XIDs too.  The
replies all have status OK.  But four duplicate requests is mighty
suspicious.

-- Jamie
