Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262752AbVBCRJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262752AbVBCRJn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 12:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbVBCRJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 12:09:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53992 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S263313AbVBCRBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 12:01:20 -0500
Date: Thu, 3 Feb 2005 17:01:11 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: NFSD needs EXPORTFS
Message-ID: <20050203170111.GE20386@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Got this report about 2.6.11-rc3.  Is this the correct solution?

----- Forwarded message from Joel Soete <soete.joel@tiscali.be> -----

A short analyse, it seems that's because NFSD was builtin while EXPORTFS
was a module in my previous config file. Imho EXPORTFS would be build as
NFSD?

Is the following hunk would do the trick:
--- fs/Kconfig.Orig     2005-02-03 16:45:13.562275206 +0100
+++ fs/Kconfig  2005-02-03 16:46:36.496469111 +0100
@@ -1400,6 +1400,7 @@
        tristate "NFS server support"
        depends on INET
        select LOCKD
+       select EXPORTFS
        select SUNRPC
        help
          If you want your Linux box to act as an NFS *server*, so that other
========><========

Thanks in advance,
    Joel

----- End forwarded message -----

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
