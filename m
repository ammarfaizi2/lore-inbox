Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267335AbUJNS7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267335AbUJNS7A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 14:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267350AbUJNS4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 14:56:34 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:9253 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S266891AbUJNSyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 14:54:03 -0400
Date: Thu, 14 Oct 2004 14:54:02 -0400
From: Jeffrey Mahoney <jeffm@csh.rit.edu>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Hans Reiser <reiser@namesys.com>
Subject: [PATCH 0/2] reiserfs: Warn on unsupported options
Message-ID: <20041014185402.GA9619@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.108-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, the subject sounds silly, but it's needed.

The set of allowable mount options shouldn't change based on the running
kernel configuration. The feature that the option corresponds to may be
unavailable, but in many cases it should be sufficient to warn the user that
the feature is disabled, but the mount has succeeded.

Ext3 does this for things like acl/xattr, and I feel that reiserfs should as
well.

Fortunately, the code to implement it is trivial.

In the following two messages are two patches:
* reiserfs-unsupported-opts.diff
   - Adds a REISERFS_UNSUPPORTED_OPT mount flag, and uses it to denote
     when a mount option is allowed, but not supported in the running
     configuration.
   - Rather than setting/clearing this bit, it's treated as special
     and issues a warning using the name of the mount option.
* reiserfs-unsupported-acl.diff
   - Uses the above flag to denote ACLs and user xattrs as unsupported
     when support is not compiled in.

Currently, if a filesystem is mounted with -oacl and they are not
compiled in, the filesystem will fail to mount. With these patches, the options
are ignored with a warning.

Andrew - Please apply.

-Jeff

-- 
Jeff Mahoney
SuSE Labs
