Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbTKNUz5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 15:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbTKNUz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 15:55:57 -0500
Received: from userel174.dsl.pipex.com ([62.188.199.174]:65412 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id S261678AbTKNUz4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 15:55:56 -0500
Date: Fri, 14 Nov 2003 20:55:48 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@einstein.homenet
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Harald Welte <laforge@netfilter.org>, <linux-kernel@vger.kernel.org>
Subject: Re: seq_file API strangeness
In-Reply-To: <20031114202327.GK24159@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0311142048520.849-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

On the same subject, but a different issue:

In the ->open() method I allocate a seq->private like this:

  err = seq_open(file, sop);
  if (!err) {
	struct seq_file *m = file->private_data;

	m->private = kmalloc(sizeof(struct ctask), GFP_KERNEL);
        if (!m->private) {
                        kfree(file->private_data);
                        return -ENOMEM;
        }
  }

Now, freeing the structure that I did not allocate (file->private_data 
allocated in seq_open()) is not nice. But calling seq_release() from 
->open() method is not nice either (different arguments, namely 'inode'
and also m->buf is NULL at that point, although I believe kfree(NULL) is 
not illegal).

What do you think?

Kind regards
Tigran

