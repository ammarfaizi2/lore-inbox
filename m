Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbTKVRW6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 12:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbTKVRW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 12:22:58 -0500
Received: from web41906.mail.yahoo.com ([66.218.93.157]:46470 "HELO
	web41906.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262564AbTKVRWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 12:22:54 -0500
Message-ID: <20031122172253.5645.qmail@web41906.mail.yahoo.com>
Date: Sat, 22 Nov 2003 09:22:53 -0800 (PST)
From: Michael Welles <mikewelles71@yahoo.com>
Subject: Re: Using get_cwd inside a module.
To: Christoph Hellwig <hch@infradead.org>, Juergen Hasch <lkml@elbonia.de>
Cc: Michael Welles <mike@bangstate.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20031122110459.A31359@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For changedfiles, using cut n' paste sys_getcwd, we've
managed to get "good enough" functionality.  When a
user runs "touch foo" in /tmp/watch, when we intercept
the  openw, we manage to resolve "foo" to
"/tmp/watch/foo".   We still break on things like 
"touch ../../foo", since we resolve that to
"/tmp/watch/../../foo"  -- but that's pretty fixable  
with a little effort.

NFS mounted filesystems still get us, since we rely on
intercepting the system calls and putting a wrapper
around them.  I've looked into doing so, but I didn't
see a way of doing so in a module -- and we haven't
wanted to demand that users patch and rebuild a
kernel.


--- Christoph Hellwig <hch@infradead.org> wrote:

> 
> Well, reporting a single path component relative to
> the parent directory
> is doable, there's just no way to have a canonical
> absolute or
> multi-component pathname.
> 


__________________________________
Do you Yahoo!?
Free Pop-Up Blocker - Get it now
http://companion.yahoo.com/
