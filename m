Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbUEWLr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUEWLr3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 07:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbUEWLr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 07:47:29 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:7955 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262605AbUEWLr1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 07:47:27 -0400
Date: Sun, 23 May 2004 13:49:36 +0200
To: Willy Tarreau <willy@w.ods.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, Christoph Hellwig <hch@lst.de>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: i486 emu in mainline?
Message-ID: <20040523114936.GA26157@hh.idb.hist.no>
References: <20040522234059.GA3735@infradead.org> <1085296400.2781.2.camel@laptop.fenrus.com> <20040523084415.GB16071@alpha.home.local> <20040523091356.GD5889@devserv.devel.redhat.com> <20040523094853.GA16448@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040523094853.GA16448@alpha.home.local>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2004 at 11:48:53AM +0200, Willy Tarreau wrote:
> 
> You mean like when a user does a malloc() and the memory is not physically
> allocated because not used yet ? or even in case memory has been swapped
> out ? I believe I begin to understand, but the corner case is not really
> clear to me. It yet seems strange to me that the user can reference memory
> areas that the kernel cannot access. 

The user referencing non-present memory is not a problem, because:
1. It is always pssoible to block the user process and let it wait
   (a long time) for swapping to happen. That might not be an
   option for the kernel - it can't wait while holding a
   spinlock, for example.
2. It is always ok to kill the user process if it uses memory it
   doesn't have.  It is not ok to "kill" the kernel.  The indirect ways
   of using user memory from the kernel side ensures that the
   normal mechanisms (swap-wait or kill) applies to the process owning
   the memory.  Direct reference from kernel does not invoke normal page 
   fault mechanisms when memory goes wrong.

Helge Hafting 
