Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262531AbVBDKRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbVBDKRO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 05:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbVBDKRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 05:17:14 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:65207 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S262531AbVBDKQs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 05:16:48 -0500
Date: Fri, 4 Feb 2005 12:18:27 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Stelian Pop <stelian@popies.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
Message-ID: <20050204101827.GA13455@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202155403.GE3117@crusoe.alcove-fr>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, Stelian!
One thing everyone creating kernel patches with subversion
must be aware of, is the fact that the subversion built-in diff command does
not understand the gnu diff -p flag (or indeed, any gnu diff flags at all,
with the exception of -u, which is the default anyway).

Thus you must use an external diff command to create kernel patches,
passing the -up flags to gnu diff, otherwise the patch is much less readable. 
There are two good ways to do this that I know of:

1. Remember to always generate patches with:
	svn diff --diff-cmd=/usr/bin/diff -x -up

2. Make subversion use gnu diff -up by defult to generate patches.

To do this, create a script that runs diff -up, passing any additional
parameters exactly as they are:

cat > /usr/bin/svndiff << EOF
#!/usr/bin/perl

exec("diff","-up",@ARGV);
EOF

chmod +x /usr/bin/svndiff

And set it as the default diff command in subversion:

cat >> ~/.subversion/config << EOF

[helpers]
diff-cmd = /usr/bin/svndiff

EOF

Tested with subversion 1.1.3.

-- 
MST - Michael S. Tsirkin
