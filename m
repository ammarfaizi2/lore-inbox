Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266538AbUHIMgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266538AbUHIMgi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 08:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266543AbUHIMgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 08:36:38 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:51928 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S266538AbUHIMgg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 08:36:36 -0400
Subject: Re: secure computing for 2.6.7
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Hans Reiser <reiser@namesys.com>
Cc: andrea@cpushare.com, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <411563D0.1050608@namesys.com>
References: <20040704173903.GE7281@dualathlon.random>
	 <40EC4E96.9090800@namesys.com>
	 <1091536845.7645.60.camel@moss-spartans.epoch.ncsc.mil>
	 <411563D0.1050608@namesys.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1092054923.29199.32.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 09 Aug 2004 08:35:23 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-07 at 19:20, Hans Reiser wrote:
> Where do you store the access rules?  With the executable?   How do you 
> automate their determination?

Executables, like other files, are assigned security types (security
equivalence classes for objects) stored as extended attributes.  Policy
rules based on security domains (security equivalence classes for
processes) and security types are defined in a separate security policy
configuration that is compiled into an internal form by a policy
compiler and loaded into the kernel by early userspace (presently by a
modified /sbin/init).   With regard to automating their determination,
SELinux has some rudimentary features for collecting audit data
(optionally in a permissive mode where access denials are merely logged,
not denied) and generating policy rules from such audit data, and there
is work underway to develop better tools for policy generation,
including back ends for analysis of generated policy rules against
security objectives.  You have to be rather careful about such automated
generation, as many programs and library functions probe for access that
is not truly needed for their operation and some code actually varies
its behavior based on such probes (e.g. falling back to a less
privileged mode of operation if the probe fails).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

