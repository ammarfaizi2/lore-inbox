Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWCBAgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWCBAgA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 19:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWCBAgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 19:36:00 -0500
Received: from proof.pobox.com ([207.106.133.28]:63694 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S1750812AbWCBAf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 19:35:59 -0500
Date: Wed, 1 Mar 2006 17:35:54 -0700
From: Paul Dickson <dickson@permanentmail.com>
To: linux-kernel@vger.kernel.org
Subject: NFS doen't uniformly copy timestamps to server
Message-Id: <20060301173554.f2d18939.dickson@permanentmail.com>
X-Mailer: Sylpheed version 2.2.0beta7 (GTK+ 2.8.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I first noticed this problem in late December (I wrote a script
to get around it then).  If I attempt to copy the mtime with a file, it
won't get transfered.  But I can set it later.

Within a NFS mount directory:
	cp -a file1 file2	# Timestamp not copied
	mv file1 file2 		# Timestamp not copied
	touch -r file1 file2	# Timestamp copied

I've looked through the man files for mount, exportfs, and exports and I
don't see an option I'm over looking.  An ethereal dump shows the mtime
being sent to the server and the server replying with NFS3_OK and the
correct mtime, but the resulting file does not have the mtime applied.

More data is at:
  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=183208

This currently happens with 2.6.16rc5-git3

Is this a problem with the NFS server or am I applying the wrong options?

	-Paul

