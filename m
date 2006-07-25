Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbWGYFpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbWGYFpc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 01:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWGYFpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 01:45:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20456 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932473AbWGYFpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 01:45:30 -0400
Subject: Re: [RFC][PATCH] procfs: add privacy options
From: Arjan van de Ven <arjan@infradead.org>
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Wolfgang Draxinger <Wolfgang.Draxinger@campus.lmu.de>,
       Bodo Eggert <7eggert@gmx.de>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <44C547B0.1090304@lsrfire.ath.cx>
References: <44C50A2B.3040203@lsrfire.ath.cx>
	 <m18xmiogp3.fsf@ebiederm.dsl.xmission.com>
	 <44C547B0.1090304@lsrfire.ath.cx>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 25 Jul 2006 07:45:06 +0200
Message-Id: <1153806307.8932.9.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> You mean using ptrace_may_attach() and/or MAY_PTRACE() for determining
> access to all (or at least more) files in /proc/<pid> instead of my
> proposed "chmod 500"?  What are the advantages?

Hi,

file permissions are simple, but too simplistic to express a full "am I
allowed to see that guy" rules as general principle. Just think of
SELinux or any other kind of role based access control mechanism where
"root is not full root". But it goes beyond that really; applications
that drop their ptrace capability because they KNOW they won't use it
and by dropping the capability deny an exploit that takes over from
using it. There's just too many such cases that file permissions don't
capture where ptrace is a more detailed description of the permission
check you want (idea being that if you can ptrace someone you own them).
It's good general principle to at least try to not duplicate such
permission checks; history shows that those will be gotten incorrect.

Greetings,
   Arjan van de Ven

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

