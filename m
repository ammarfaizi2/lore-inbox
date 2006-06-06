Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWFFGvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWFFGvv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 02:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWFFGvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 02:51:51 -0400
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:22447 "EHLO
	mail8.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1750725AbWFFGvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 02:51:50 -0400
Date: Tue, 6 Jun 2006 02:51:48 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: linux-kernel@vger.kernel.org
cc: Stephen Smalley <sds@tycho.nsa.gov>, Chris Wright <chrisw@sous-sol.org>,
       Greg KH <greg@kroah.com>
Subject: HOWTO add privileged code to the kernel without breaking LSM/SELinux
Message-ID: <Pine.LNX.4.64.0606060229240.10150@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you add any new code to the kernel which exposes any kind of 
privileged operation to userspace, then it probably needs an LSM hook and 
subsequent changes to SELinux.

It would certainly be unreasonable to expect all kernel developers to know 
how to do this, however, it is usually very simple to determine when a new 
LSM would be needed as a first step.

The simple tests are: does the code you're adding perform any new DAC 
checks involving any of the user or group ID fields of a task?  Did you 
add a capable() call?  Does it call DAC helper functions?

If so, it's possible that a corresponding MAC check needs to be added via 
LSM; and I'd ask that you simply cc any or all of the LSM and/or SELinux 
maintainers when posting such patches upstream for RFC or inclusion.  We 
can work on the LSM and SELinux side of things if needed.

This will not cover every case, but I think it will cover most of the ones 
that are likely to come up in the future.  If in doubt, it won't hurt to ask.


(CC'd GKH hoping something of this can go into his kernel hacking howto).


- James
-- 
James Morris
<jmorris@namei.org>
