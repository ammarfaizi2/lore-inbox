Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262415AbVCBTLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbVCBTLn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 14:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbVCBTLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 14:11:43 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:39690 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262415AbVCBTLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 14:11:31 -0500
Date: Wed, 2 Mar 2005 20:14:27 +0100
To: linux-kernel@vger.kernel.org
Subject: 2.6.11-rc5-mm1 nfs oddity, file creation => "no such file"
Message-ID: <20050302191427.GA9383@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I observed an oddity on a nfs-mounted fs while using 2.6.11-rc5-mm1.

I tried to save a file from xfig, and got an error message about a
nonexisting file.  Now apps may have their own bugs, so I
retried in the shell:

$ cat > newfile
newfile: No such file or directory
$

Eh - of course it didn't exist - I was trying to create it!

This also resulted in "newfile" being created with size 0.
Repeating the "cat > newfile" worked fine once the zero-length
file existed.  Unfortunately, xfig always removes files before overwriting
so it couldn't save on the nfs volume at all.

File creation by "touch filename" worked flawlessly.

After this I rebooted into 2.6.11-rc3-mm1 which haven't shown this problem
so far.  There were nothing in "dmesg" when this happened, other
than a message about "mount" being older than the kernel.

I can try to recreate the problem if necessary.

Helge Hafting


