Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264798AbUF2EJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264798AbUF2EJN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 00:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265396AbUF2EJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 00:09:12 -0400
Received: from vsat-148-63-57-162.c001.g4.mrt.starband.net ([148.63.57.162]:13527
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S264798AbUF2EJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 00:09:10 -0400
Message-ID: <40E0EAC1.50101@redhat.com>
Date: Mon, 28 Jun 2004 21:06:25 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a2) Gecko/20040627
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: inconsistency between SIOCGIFCONF and SIOCGIFNAME
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

POSIX does not specify the if_indextoname and if_nameindex functions,
they are only vaguely specified in an RFC.  So there is some room for
interpretation but still I think it is an issue.

If SIOCGIFCONF to query the system's interfaces only active interfaces
are returned.  But SIOCGIFNAME (and SIOCGIFINDEX) allow querying
interfaces which are down and not fully initialized.

RFC 3493 says if_nameindex should return *all* interfaces.  This means
that neither if_indextoname or if_nametoindex (defined in the same rfc)
should define more interfaces.


With the current kernels all I could do is to make if_indextoname and
if_nametoindex slower by always calling if_nameindex implicitly to see
whether the interface is defined at all.  It would be much better if the
kernel could do the right thing.  I.e., do one of the following:

~ if the SIOCGIFCONF, return all interfaces SIOCGIFNAME also knows
  about.

~ do not allow SIOCGIFNAME and SIOCGIFINDEX) to return values if
  SIOCGIFCONF, would not return any.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
