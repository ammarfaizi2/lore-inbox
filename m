Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbTD3Cp1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 22:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbTD3Cp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 22:45:27 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:30877 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261939AbTD3Cp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 22:45:26 -0400
Date: Tue, 29 Apr 2003 22:57:46 -0400
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Per-Mount UID/GID Rewrite Vector
Message-ID: <20030430025746.GA24281@delft.aura.cs.cmu.edu>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <PEEPIDHAKMCGHDBJLHKGEEFJCJAA.rwhite@casabyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PEEPIDHAKMCGHDBJLHKGEEFJCJAA.rwhite@casabyte.com>
User-Agent: Mutt/1.5.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 29, 2003 at 02:42:57PM -0700, Robert White wrote:
> Opinions?  Objections?  Reasons I'm an idiot?

Working with Coda, I've thought about these issues many times. I believe
the user mapping is a many-many relationship, which is hard or even
impossible to represent with such a simple mapping. Also the mapping
would vary depending on which device/file hierarchy is inserted. For
Coda it even depends on which subtree within the filesystem you traverse
as those might access servers is different administrative organisations.

Not doing anything tricky and allowing nosuid,noexec,nodev,uid=XX,gid=XX
to apply to all filesystems (possibly within the VFS layer) is
probably a more reliable solution. Otherwise it just becomes too complex
to manage.

For Coda we're pretty much punting the uid mapping. It is used for
'presentation' purposes only as all security is based on the Coda token
and directory ACLs. We do not really use the unix owner and permission
bits. We also explicitly clear the SUID bit, and rely on a locally
installed copy of sudo or super (preferably with a modification to check
something like an SHA1 or MD5 checksum of the executable) to provide the
priviledge escalation. This way running setuid applications becomes a
local policy.

For sandboxing purposes, perhaps you could think in the direction of
mounting the device in an UML environment, or it's own namespace.

Jan

