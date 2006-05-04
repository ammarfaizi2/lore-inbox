Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbWEDDR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWEDDR5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 23:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbWEDDR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 23:17:57 -0400
Received: from c-67-177-57-20.hsd1.ut.comcast.net ([67.177.57.20]:52216 "EHLO
	sshock.homelinux.net") by vger.kernel.org with ESMTP
	id S1750909AbWEDDR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 23:17:56 -0400
Date: Wed, 3 May 2006 21:17:55 -0600
From: Phillip Hellewell <phillip@hellewell.homeip.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, toml@us.ibm.com, yoder1@us.ibm.com,
       James Morris <jmorris@namei.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       Phillip Hellewell <phillip@hellewell.homeip.net>,
       Erez Zadok <ezk@cs.sunysb.edu>, David Howells <dhowells@redhat.com>
Subject: [PATCH 0/12: eCryptfs] eCryptfs version 0.1.6
Message-ID: <20060504031755.GA28257@hellewell.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-URL: http://hellewell.homeip.net/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set constitutes the 0.1.6 release of the eCryptfs
cryptographic filesystem:

http://ecryptfs.sourceforge.net/

eCryptfs is a kernel-native stacked cryptographic filesystem for
Linux. It is derived from Erez Zadok's Cryptfs, implemented through
the FiST framework for generating stacked filesystems. eCryptfs
extends Cryptfs to provide a framework for advanced key management and
policy features. The initial release includes support for mount-wide
passphrase only. eCryptfs stores cryptographic metadata in the header
of each file written, so that encrypted files can be copied between
the lower filesystems of hosts; the file will be decryptable through
eCryptfs with the proper key, and there is no need to keep track of
any additional information aside from what is already in the encrypted
file itself. We think of eCryptfs as a sort of ``pgpfs.''

This patch set implements the design reflected in the document sent to
the LKML on March 24th (subject ``eCryptfs Design Document''), with
two modifications per responses to that document. The first
modification is that extents are fixed to 4096-byte regions rather
than whatever the page size of the host happens to be. In cases where
the page size is larger than 4096 bytes and where the pages are not
aligned, eCryptfs crosses page boundaries in the lower file while
processing the 4096-byte extents. The second modification is that the
header region occupies either 8192 bytes or the page size of the host
on which the file is created, whichever is larger. This maximizes the
probability that pages will be aligned between the unencrypted and
encrypted data, which is not a requirement, but it helps with
performance.

This patch set was produced and tested against the 2.6.17-rc3-mm1
release of the kernel.

Thanks,
Phillip
