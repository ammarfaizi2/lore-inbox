Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbVK0VyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbVK0VyN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 16:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbVK0VyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 16:54:13 -0500
Received: from hera.cwi.nl ([192.16.191.8]:4306 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S1751149AbVK0VyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 16:54:13 -0500
Date: Sun, 27 Nov 2005 22:54:11 +0100 (MET)
From: <Andries.Brouwer@cwi.nl>
Message-Id: <200511272154.jARLsBb11446@apps.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: umount
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently I have seen cases where I/O to a device with bad media
was never noticed (except in the syslog). I think that is bad.
The application writes, but the stuff written lives in buffers.
The close() still does not force file I/O.
But the umount() causes the I/O to happen. Writes fail and the
syslog is full of messages. But the user does not see any messages,
the umount returns without error, and there is no reason to suspect
that anything is wrong.

I am not sure about the correct solution.
Perhaps umount should return -EIO if it did the umount but
I/O errors happened?

Andries

