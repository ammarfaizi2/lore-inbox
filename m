Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264363AbTKUQZI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 11:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264369AbTKUQZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 11:25:07 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:13298 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S264363AbTKUQZD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 11:25:03 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: Justin Cormack <justin@street-vision.com>
Subject: Re: OT: why no file copy() libc/syscall ??
Date: Fri, 21 Nov 2003 10:24:31 -0600
X-Mailer: KMail [version 1.2]
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1068512710.722.161.camel@cube> <03112013081700.27566@tabby> <1069357453.26642.93.camel@lotte.street-vision.com>
In-Reply-To: <1069357453.26642.93.camel@lotte.street-vision.com>
MIME-Version: 1.0
Message-Id: <03112110243200.29137@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 November 2003 13:44, Justin Cormack wrote:
> On Thu, 2003-11-20 at 19:08, Jesse Pollard wrote:
[snip]
>
> If you really want a filesystem that supports efficient copying you
> probably want it to have the equivalent of COW blocks, so that a copy
> just sets up a few pointers, and the copy only happens when the original
> or copied files are changed.

Ummmm... I REALLY don't like COW on a disk. Much too big a chance that the
filesystem will deadlock, and with no recovery method. (oversubscribed, then
crash, corrupting the homeblock, repair (committing journal?) requires
space... no space... therefore mostly dead. You'd have to be able to mount
without the journal or the homeblock, then delete something, then commit the
journal, dismount, recover the rest-- though this might be overboard, the
homebock might not even be damaged).

> But basically you wont get a syscall until you have a filesystem with
> semantics that only maps onto this sort of operation.

I belive NFSv3/4 has a file copy request included. And I understand that
the SAMBA server does too.
