Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270723AbTGNSuo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 14:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270725AbTGNSuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 14:50:44 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:24743 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S270723AbTGNSug
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 14:50:36 -0400
Subject: [PATCH] Add SELinux module to 2.6.0-test1
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <greg@kroah.com>, Chris Wright <chris@wirex.com>,
       James Morris <jmorris@intercode.com.au>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1058209504.13738.687.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Jul 2003 15:05:04 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch available from
http://www.nsa.gov/selinux/lk/2.6.0-test1-addselinux.patch.gz adds the
SELinux module under security/selinux and modifies the security/Makefile
and security/Kconfig files for SELinux.  The header files are still
under security/selinux since they are private to the module.  The
hashtab code is still part of the SELinux module, as it does not appear
to be generally applicable, but a number of cleanups have been made by
James Morris to the hashtab code and the rest of the ss code based on
the earlier comments.  diffstat -p1 output is below.  Please consider
applying.

 security/Kconfig                                 |    2 
 security/Makefile                                |    6 
 security/selinux/Kconfig                         |   34 
 security/selinux/Makefile                        |   10 
 security/selinux/avc.c                           | 1144 +++++++
 security/selinux/hooks.c                         | 3372 +++++++++++++++++++++++
 security/selinux/include/av_inherit.h            |   37 
 security/selinux/include/av_perm_to_string.h     |  122 
 security/selinux/include/av_permissions.h        |  550 +++
 security/selinux/include/avc.h                   |  234 +
 security/selinux/include/avc_ss.h                |   81 
 security/selinux/include/class_to_string.h       |   39 
 security/selinux/include/common_perm_to_string.h |   65 
 security/selinux/include/flask.h                 |   71 
 security/selinux/include/flask_types.h           |   73 
 security/selinux/include/initial_sid_to_string.h |   32 
 security/selinux/include/objsec.h                |   87 
 security/selinux/include/security.h              |  180 +
 security/selinux/selinuxfs.c                     |  592 ++++
 security/selinux/ss/Makefile                     |   14 
 security/selinux/ss/avtab.c                      |  261 +
 security/selinux/ss/avtab.h                      |   68 
 security/selinux/ss/constraint.h                 |   54 
 security/selinux/ss/context.h                    |  117 
 security/selinux/ss/ebitmap.c                    |  331 ++
 security/selinux/ss/ebitmap.h                    |   49 
 security/selinux/ss/global.h                     |   17 
 security/selinux/ss/hashtab.c                    |  277 +
 security/selinux/ss/hashtab.h                    |  125 
 security/selinux/ss/mls.c                        |  738 +++++
 security/selinux/ss/mls.h                        |   99 
 security/selinux/ss/mls_types.h                  |   58 
 security/selinux/ss/policydb.c                   | 1423 +++++++++
 security/selinux/ss/policydb.h                   |  256 +
 security/selinux/ss/services.c                   | 1385 +++++++++
 security/selinux/ss/services.h                   |   21 
 security/selinux/ss/sidtab.c                     |  328 ++
 security/selinux/ss/sidtab.h                     |   59 
 security/selinux/ss/symtab.c                     |   40 
 security/selinux/ss/symtab.h                     |   23 
 40 files changed, 12474 insertions(+)

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

