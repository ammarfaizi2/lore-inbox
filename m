Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbTJANId (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 09:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbTJANIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 09:08:32 -0400
Received: from main.gmane.org ([80.91.224.249]:38565 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262081AbTJANIb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 09:08:31 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: File Permissions are incorrect. Security flaw in Linux
Date: Wed, 01 Oct 2003 15:08:28 +0200
Message-ID: <yw1x65j9m7g3.fsf@users.sourceforge.net>
References: <1065012013.4078.2.camel@lisaserver>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:ODE6IkMp2tX6/Zed4u07XK0f0is=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Lisa R. Nelson" <lisanels@cableone.net> writes:

> [1.] One line summary of the problem:    
> A low level user can delete a file owned by root and belonging to group
> root even if the files permissions are 744.  This is not in agreement
> with Unix, and is a major security issue.
>
> [2.] Full description of the problem/report: 
>     Permissions on a file basis take precedence over directory
> permissions (for most cases), but in Linux they do not.  In order to
> secure a file, you have to secure the directory which effects all files
> within it.  
>     As user 'lisa', I do all my work on my server.  One task is to move
> pictures from my digital camera to my server picture directory that is
> wide open to everyone.  All users can create sub-folders and put
> pictures in there.  But every hour I have a cron job run that changes
> the ownership to root, and sets the permissions to 644 on all files in
> that directory structure.  Thinking the files could no longer be altered
> by anyone but root (as would be the case in unix), and found anyone
> could delete them.  That's when I discovered this major bug.

This is not a bug.  Deleting a file is in effect a modification to the
directory containing the file, not to the file itself.  If the file
has a hard link in another directory, it will still remain there,
unmodified.  If you want only the owner of a file to be able to delete
it, set the sticky bit on the directory containing it, like this:

chmod 1777 /the/dir

This is commonly used on /tmp.  It is also the all Unix systems I've
been using work.

-- 
Måns Rullgård
mru@users.sf.net

