Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbUENPWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbUENPWL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 11:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbUENPWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 11:22:11 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:44190 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261528AbUENPWG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 11:22:06 -0400
Subject: Re: [PATCH] capabilites, take 2
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       luto@myrealbox.com, Chris Wright <chrisw@osdl.org>,
       olaf+list.linux-kernel@olafdietsche.de, Valdis.Kletnieks@vt.edu
In-Reply-To: <1084536213.951.615.camel@cube>
References: <1084536213.951.615.camel@cube>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1084548061.17741.119.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 14 May 2004 11:21:01 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-14 at 08:03, Albert Cahalan wrote:
> This would be an excellent time to reconsider how capabilities
> are assigned to bits. You're breaking things anyway; you might
> as well do all the breaking at once. I want local-use bits so
> that the print queue management access isn't by magic UID/GID.
> We haven't escaped UID-as-priv if server apps and setuid apps
> are still making UID-based access control decisions.

Capabilities are a broken model for privilege management; try RBAC/TE
instead.  http://www.securecomputing.com/pdf/secureos.pdf has notes
about the history and comparison of capabilities vs. TE.

Instead of adding new capability bits, replace capable() calls with LSM
hook calls that offer you finer granularity both in operation and in
object-based decisions, and then use a security module like SELinux to
map that to actual permission checks.  SELinux provides a framework for
defining security classes and permissions, including both definitions
used by the kernel and definitions used by userspace policy enforcers
(ala security-enhanced X).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

