Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030439AbVKIWW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030439AbVKIWW1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbVKIWW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:22:27 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:61621 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030439AbVKIWW0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:22:26 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17266.30336.927121.984127@tut.ibm.com>
Date: Wed, 9 Nov 2005 16:21:52 -0600
To: Andrew Morton <akpm@osdl.org>
Cc: Tom Zanussi <zanussi@us.ibm.com>, linux-kernel@vger.kernel.org,
       karim@opersys.com
Subject: Re: [PATCH 2/4] relayfs: Documentation for non-relay file support
In-Reply-To: <20051109140055.1c83abae.akpm@osdl.org>
References: <17266.28445.60709.667841@tut.ibm.com>
	<20051109140055.1c83abae.akpm@osdl.org>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > Tom Zanussi <zanussi@us.ibm.com> wrote:
 > >
 > >  +relay_open() automatically creates files in the relayfs filesystem to
 > >  +represent the per-cpu kernel buffers; it's often useful for
 > >  +applications to be able to create their own files in the relayfs
 > >  +filesystem as well e.g. 'control' files used to communicate control
 > >  +information between the kernel and user sides of a relayfs
 > >  +application.
 > 
 > What are the semantics of these control files?  How does an application
 > know that there's something new to be read from them?  select() or poll()
 > or blocking read()?

It's completely up to the client to define whatever file operations it
wants, which are passed in to relayfs_create_file().  The relayfs
example apps, for instance, read from these files whenever they're
notifed via the relay file poll implementation that there's a
sub-buffer ready.  These are basically the same thing as proc or
debugfs files created by passing explicit file operations.

 > 
 > Can userspace write to the control files?   If so, what happens
in-kernel?

Yes, the client can supply a write() file op that does whatever it
wants to.  For the relayfs examples, the write() implementation
updates the count of sub-buffers consumed, for instance.

Tom


