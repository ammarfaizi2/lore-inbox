Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbTJAN6I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 09:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbTJAN6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 09:58:08 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:10506 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S262101AbTJAN6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 09:58:05 -0400
Subject: Re: File Permissions are incorrect. Security flaw in Linux
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: "Lisa R. Nelson" <lisanels@cableone.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1065012013.4078.2.camel@lisaserver>
References: <1065012013.4078.2.camel@lisaserver>
Content-Type: text/plain
Message-Id: <1065016679.2445.5.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 01 Oct 2003 15:58:00 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-10-01 at 14:40, Lisa R. Nelson wrote:

> [1.] One line summary of the problem:    
> A low level user can delete a file owned by root and belonging to group
> root even if the files permissions are 744.  This is not in agreement
> with Unix, and is a major security issue.

Don't know which Unix you are referring to, but on Solaris and Linux,
the delete (unlink) and create file operations are subject to directory
permissions. Thus, deleting a file requires write permission on the
directory. The write permission on a file allows to modify its contents
and has nothing to do with being able to delete it.

Thus, what you are seeing is completely normal:

1. mkdir /mydir
2. cd /mydir
3. chmod 777 .
4. touch myfile
5. chmod 444 myfile

Anyone will be able to delete "myfile" since the directory where it
belongs (mydir) has full write privileges for anyone.

I recommend you using the sticky bit on shared directories, like /tmp.
If a directory has the sticky bit enabled, a file can only be deleted by
its owner (and root, of course):

1. mkdir /mydir
2. cd /mydir
3. chmod 1777 .
4. touch myfile

Now, "myfile" can only be deleted by its owner (or root), since the
directory where it belongs is marked with the sticky bit.

HTH


