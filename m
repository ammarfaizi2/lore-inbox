Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751455AbVKORdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbVKORdo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 12:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbVKORdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 12:33:44 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:34016 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751455AbVKORdn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 12:33:43 -0500
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
From: Dave Hansen <haveblue@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: "SERGE E. HALLYN [imap]" <serue@us.ibm.com>, Paul Jackson <pj@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com
In-Reply-To: <20051115164708.GA12807@kroah.com>
References: <20051114212341.724084000@sergelap>
	 <20051114153649.75e265e7.pj@sgi.com>
	 <20051115010155.GA3792@IBM-BWN8ZTBWAO1>
	 <20051114175140.06c5493a.pj@sgi.com>
	 <20051115022931.GB6343@sergelap.austin.ibm.com>
	 <20051114193715.1dd80786.pj@sgi.com>
	 <20051115051501.GA3252@IBM-BWN8ZTBWAO1>  <20051115164708.GA12807@kroah.com>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 18:33:39 +0100
Message-Id: <1132076019.6108.67.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-15 at 08:47 -0800, Greg KH wrote:
> Why not just use Xen?  It can handle process migration from one virtual
> machine to another just fine.

Xen is relatively slow compared to the approach that we want to use.
It's a pain in the neck to set up, especially if you want a _lot_ of
partitions.  We were going to try to compare the relative performance of
the two approaches as as the number of vservers and Xen VMs is
increased.  We haven't found anyone brave enough to set up 100 Xen
guests on a single system. :)

The overhead of storing the application snapshots that we're envisioning
can be quite tiny compared to Xen.  This becomes horribly important if
you want to store the snapshots for a bit, and not simply keep one
around for long enough to restore the image elsewhere.

Xen doesn't share Linux caches between partitions.  So, as you increase
the number of Xen partitions, the overhead of storing things like the
'/' dentry goes up pretty linearly.  Keeping only one Linux instance
around makes such things much nicer to share.

The laundry-list of advantages is pretty long.  This is starting to
sound like a good OLS paper :)

-- Dave

