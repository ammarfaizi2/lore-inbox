Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbVANXZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbVANXZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 18:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVANXZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 18:25:50 -0500
Received: from thunk.org ([69.25.196.29]:40348 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261510AbVANXWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 18:22:06 -0500
Date: Fri, 14 Jan 2005 18:21:54 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: short read from /dev/urandom
Message-ID: <20050114232154.GB18479@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Ulrich Drepper <drepper@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <41E7509E.4030802@redhat.com> <20050114191056.GB17481@thunk.org> <41E833F4.8090800@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E833F4.8090800@redhat.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 01:04:52PM -0800, Ulrich Drepper wrote:
> I'm concerned that there is isgnificant code out there relying on the 
> no-short-read promise.  And perhaps more importantly, other 
> implementations promise the same.
> 
> The code in question comes from a crypto library which is in wide use 
> (http://www.cryptopp.com) and it is using urandom under this assumption. 
>  I fear there is quite a bit more code like this out there.  Changing 
> the ABI after the fact is no good and dangerous in this case.
> 
> I know this is making the device special, but I really think the 
> no-short-reads property should be perserved for urandom.

Good point.  The fact that there are other implementations out there
which are doing this is a convincing argument.  

I am still a bit concerned still that a stupidly written program that
opens /dev/urandom (perhaps unwittingly) and tries to read a few
hundred megabytes will become uninterruptible until the read
completes, but I'm not sure it's worth it to but in some kludge that
says "break if there's a signal and count > 1 megabyte --- otherwise
we'll return soon enough".

						- Ted
