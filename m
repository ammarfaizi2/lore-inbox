Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271717AbTHDMrR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 08:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271720AbTHDMrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 08:47:17 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:19911 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S271717AbTHDMrQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 08:47:16 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16174.21970.527300.160659@laputa.namesys.com>
Date: Mon, 4 Aug 2003 16:47:14 +0400
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: FS: hardlinks on directories
In-Reply-To: <20030804141548.5060b9db.skraw@ithnet.com>
References: <20030804141548.5060b9db.skraw@ithnet.com>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski writes:
 > Hello all,
 > 
 > although it is very likely I am entering (again :-) an ancient discussion I
 > would like to ask why hardlinks on directories are not allowed/no supported fs
 > action these days. I can't think of a good reason for this, but can think of
 > many good reasons why one would like to have such a function, amongst those:
 > 
 > - restructuring of the fs to meet different sorting criterias (kind of a
 > database view onto the fs)
 > - relinking of the fs for export to other hosts via nfs or the like (enhanced
 > security through artificially constructed, exported trees)
 > 
 > Would a feature like that be seen as "big action" or rather small enhancement
 > to the fs-layer?
 > Are there any supporters for this feature out there?

Hard links on directories are hard to do in the UNIX file system model.

Where ".." should point? How to implement rmdir? You can think about
UNIX unlink as some form of reference counter based garbage
collector---when last (persistent) reference to the object is removed it
is safe to recycle it. It is well-known that reference counting GC
cannot cope with cyclical references. Usually this is not a problem for
the file system because all cyclical references are very well
known---they always involve "." and "..". But as one allows hard links
on directories, file system is no longer tree, but generic directed
graph and reference counting GC wouldn't work.

 > 
 > Regards,
 > Stephan

Nikita.

