Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbUJZD5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbUJZD5c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 23:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbUJZDxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 23:53:22 -0400
Received: from hera.kernel.org ([63.209.29.2]:50816 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262066AbUJZDs5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 23:48:57 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Is anyone using the load_ramdisk= option in the kernel still?
Date: Tue, 26 Oct 2004 03:48:40 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <clkheo$otl$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1098762521 25526 127.0.0.1 (26 Oct 2004 03:48:41 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 26 Oct 2004 03:48:41 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've come to the conclusion that in order to stay backwards
compatible while moving root-mounting stuff to userspace, in the
initial patch everything in prepare_namespace() and south needs to be
fully supported in userspace.  This looks perfectly doable, but is a
fair bit of work.

The one piece of ugliness I've encountered has to do with the
load_ramdisk= option; this causes a ramdisk to be loaded from an
external device, usually a floppy.  The ugliness has to do with the
fact that it requires the kernel itself to deduce the size of the
ramdisk, which is filesystem-specific.  Although this code is
currently run for initrds as well, it doesn't need to, since the
kernel knows the size of an initrd.

This code isn't complex by any means, but it's ugly and complex, and
I'm trying to make something a bit cleaner than just copying the
existing in-kernel code to userspace.

So, in short:

a) Does anyone use the load_ramdisk= option anymore, or is it
legitimate to drop?

b) If it is necessary to retain, does anyone care if this option would
only support gzip format in the future, i.e. NOT support uncompressed
filesystem images?  Since a gzip stream is self-terminating, this
takes care of the problem of finding the end, but adds a sizable chunk
of code to the kinit binary.

	-hpa

