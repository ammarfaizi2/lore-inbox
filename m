Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261867AbSJQUV4>; Thu, 17 Oct 2002 16:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262022AbSJQUV4>; Thu, 17 Oct 2002 16:21:56 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:43527 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261867AbSJQUVy>; Thu, 17 Oct 2002 16:21:54 -0400
Date: Thu, 17 Oct 2002 21:27:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Russell Coker <russell@coker.com.au>
Cc: Greg KH <greg@kroah.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021017212749.A8506@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Russell Coker <russell@coker.com.au>, Greg KH <greg@kroah.com>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org,
	linux-security-module@wirex.com
References: <20021017195015.A4747@infradead.org> <20021017195838.A5325@infradead.org> <20021017190723.GB32537@kroah.com> <200210172220.21458.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210172220.21458.russell@coker.com.au>; from russell@coker.com.au on Thu, Oct 17, 2002 at 10:20:21PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 10:20:21PM +0200, Russell Coker wrote:
> Now if every SE system call was to be a full Linux system call then LANANA 
> would be involved in the discussions every time that a new SE call was added, 
> which would not be desired by the SE Linux people or the LANANA people.  So 
> this means having a switch statement for the different SE calls.

Then stabilize your interface before going into production use.  Why
should selinux (or lsm) get special treatment?

> Do we expect that SE Linux or other security system calls will be such a 
> performance bottleneck that an extra switch or two will hurt?

It's not the performance issues, it's about getting a proper syscall table
instead of deep nesting without knowing what it actually does.
Look at e.g. the horrors of doing a proper 32->64bit translation
of those syscalls.

> Also it would mean that developmental projects would be more difficult.

Yes.  In general you should avoid adding syscalls anyway. If we
wanted to make it easy we'd have created loadable syscalls from the very
beginning.
