Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbTLDNrp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 08:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbTLDNrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 08:47:45 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:43136 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S262055AbTLDNrg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 08:47:36 -0500
Date: Thu, 4 Dec 2003 14:47:33 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: David Hinds <dhinds@sonic.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Worst recursion in the kernel
Message-ID: <20031204134733.GA7890@wohnheim.fh-wedel.de>
References: <20031203143122.GA6470@wohnheim.fh-wedel.de> <20031203100709.B6625@sonic.net> <20031203190440.GA15857@wohnheim.fh-wedel.de> <20031203150804.A19286@sonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031203150804.A19286@sonic.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 December 2003 15:08:04 -0800, David Hinds wrote:
> 
> The issue is that validate_mem() doesn't need to use read_cis_mem's
> functionality directly (so it can't just be modified to use the __*
> form).  It calls other stuff, which calls other stuff, which
> eventually calls read_cis_mem(), and all that other stuff is used by
> other callers.  So there isn't an obvious place to insert this
> bifurcation.

This explanation sounds a bit like "that mess is too fragile, there is
no way to touch it without everything falling apart."  Just one more
reason to change it and make it more maintainable.  I agree, it is a
big piece of work waiting for 2.7 to open up, but your only excuse not
to do it eventually is lack of time. ;)

> inv_probe() is pretty comprehensible, it calls itself directly, in
> order to traverse a short linked list from tail to head.

Sounds like a valid candidate for <list.h>, but if you can prove the
list to always be short, it is ok.

Jörn

-- 
Write programs that do one thing and do it well. Write programs to work
together. Write programs to handle text streams, because that is a
universal interface. 
-- Doug MacIlroy
