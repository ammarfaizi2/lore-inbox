Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758140AbWLCR3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758140AbWLCR3d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 12:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758144AbWLCR3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 12:29:33 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:18128 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S1758140AbWLCR3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 12:29:33 -0500
X-Originating-Ip: 74.109.98.100
Date: Sun, 3 Dec 2006 12:25:13 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: why do both kobjects and ksets have a "kobj_type" member?
Message-ID: <Pine.LNX.4.64.0612031217470.4903@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  what is the rationale for both the kobject structs and the kset
structs having a kobj_type?  can those values possibly be different?
from kobject.h:

 ...
 *      kset - a set of kobjects of a specific type, belonging
 *      to a specific subsystem.
 *
 *      All kobjects of a kset should be embedded in an identical
 *      type.
 ...

so that suggests that the types can't be *different* within a single
kset.  furthermore, we have:

...
static inline struct kobj_type * get_ktype(struct kobject * k)
{
        if (k->kset && k->kset->ktype)
                return k->kset->ktype;
        else
                return k->ktype;
}
...

which seem to clearly show that the ktype of the kset overrides that
of the kobject, unless the kset *has* no ktype, or the kobject is not
even a member of a kset.  are either of those situations possible?
just being inordinately curious.

rday

