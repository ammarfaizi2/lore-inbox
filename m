Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbTIKNqy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 09:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbTIKNqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 09:46:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46256 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261298AbTIKNp6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 09:45:58 -0400
Date: Thu, 11 Sep 2003 14:45:57 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] kmalloc + memset(foo, 0, bar) = kmalloc0
Message-ID: <20030911134557.GV454@parcelfarce.linux.theplanet.co.uk>
References: <200309111540.58729@bilbo.math.uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309111540.58729@bilbo.math.uni-mannheim.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 03:40:58PM +0200, Rolf Eike Beer wrote:
> Hi,
> 
> a (very) simple grep in drivers/ showed more than 300 matches of code like
> this:
> 
> foo = kmalloc(bar, baz);
> if (! foo)
> 	return -ENOMEM;
> memset(foo, 0, sizeof(foo));

Erm.  It would better *not* be there in such amounts - sizeof(foo) would
be a size of pointer...

> Why not add a small inlined function doing the memset for us
> and reducing the code to
> 
> foo = kmalloc0(bar, baz);
> if (! foo)
> 	return -ENOMEM;

Bad choice of name - too easy to confuse with kmalloc().
