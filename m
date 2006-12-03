Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935778AbWLCKqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935778AbWLCKqw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 05:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935644AbWLCKqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 05:46:52 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:53420 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S935778AbWLCKqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 05:46:51 -0500
X-Originating-Ip: 74.109.98.100
Date: Sun, 3 Dec 2006 05:43:21 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: any value to "struct configfs_attribute" anymore?
Message-ID: <Pine.LNX.4.64.0612030534070.2710@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.723, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00, TW_GF 0.08)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  as a followup to my previous patch submission, is there any value to
the definition of "struct configfs_attribute" in configfs.h anymore,
given a similar structure in sysfs.h?

configfs.h:
-----------

struct configfs_attribute {
        const char              *ca_name;
        struct module           *ca_owner;
        mode_t                  ca_mode;
};

sysfs.h:
--------

struct attribute {
        const char              * name;
        struct module           * owner;
        mode_t                  mode;
};

  if these two structs are *necessarily* identical, then it would make
sense to remove the few remaining uses of the former and replace them
with references to the latter, no?  there are only a few files that
appear to still make reference to the former:

fs/configfs/inode.c
fs/ocfs2/cluster/heartbeat.c
fs/ocfs2/cluster/nodemanager.c
fs/dlm/config.c

so standardizing on the latter would be fairly easy.  or is there a
reason why those two structures still have to be treated
independently?

rday
