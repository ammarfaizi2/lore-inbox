Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263437AbTDXTzY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 15:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263441AbTDXTzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 15:55:24 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:9197 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S263437AbTDXTzX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 15:55:23 -0400
Subject: Re: [PATCH] Extended Attributes for Security Modules against 2.5.68
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris Wright <chris@wirex.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>, "Ted Ts'o" <tytso@mit.edu>,
       Stephen Tweedie <sct@redhat.com>, lsm <linux-security-module@wirex.com>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030424124755.G15094@figure1.int.wirex.com>
References: <20030423194501.B5295@infradead.org>
	 <1051125476.14761.146.camel@moss-huskers.epoch.ncsc.mil>
	 <20030423202614.A5890@infradead.org>
	 <1051127534.14761.166.camel@moss-huskers.epoch.ncsc.mil>
	 <20030423212004.A7383@infradead.org>
	 <1051188945.14761.284.camel@moss-huskers.epoch.ncsc.mil>
	 <20030424140358.A30888@infradead.org>
	 <1051192166.14761.334.camel@moss-huskers.epoch.ncsc.mil>
	 <20030424113615.F15094@figure1.int.wirex.com>
	 <1051210971.20300.89.camel@moss-huskers.epoch.ncsc.mil>
	 <20030424124755.G15094@figure1.int.wirex.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1051214842.20300.122.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Apr 2003 16:07:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-24 at 15:47, Chris Wright wrote:
> Yes, there was also some mention of the permission issue w.r.t. HSM and
> (i vaguely recall) an xattr interface proposed that noted if the request was
> internal from the kernel (skip the capable check) or on behalf of user.
> If this were carried through, it could suffice, no?

You still wouldn't want the security check implemented in the xattr
handler (even for calls on behalf of user processes), because it will
differ depending on the security module and may require the full
contextual information (process and inode).  Effectively, you would have
to just implement a call from the xattr handler to the security module,
and we already have hook calls from the [gs]etxattr system call code to
the security module to support such permission checking for user
processes.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

