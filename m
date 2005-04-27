Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbVD0Pq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbVD0Pq3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 11:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbVD0Pq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 11:46:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47040 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261755AbVD0PqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 11:46:25 -0400
Date: Wed, 27 Apr 2005 16:46:43 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: k8 s <uint32@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Doubt Regarding Multithreading and Device Driver
Message-ID: <20050427154643.GX13052@parcelfarce.linux.theplanet.co.uk>
References: <699a19ea050427080545fb1676@mail.gmail.com> <20050427151040.GA5717@roonstrasse.net> <699a19ea05042708305fb7194b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <699a19ea05042708305fb7194b@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 09:00:58PM +0530, k8 s wrote:
> But i am sharing something in file->private_data which is a private
> variable to the process(that is passed to the device driver
> functions). Isn't it?

It is not.  It is private to struct file.  Not to process.  And any number
of things (starting with fork()) will give several processes references to
the same struct file.  As soon as it had returned from ->open(), it should
be considered externally visible and potentially shared until ->release()
is called.
