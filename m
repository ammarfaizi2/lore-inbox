Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262527AbUCLUXA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 15:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbUCLUSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 15:18:30 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:38555
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S262497AbUCLUQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 15:16:51 -0500
Message-ID: <40521AA6.7070308@redhat.com>
Date: Fri, 12 Mar 2004 12:16:38 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040310
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: host name length
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

POSIX nowadays contains

  _POSIX_HOST_NAME_MAX
and
  HOST_NAME_MAX

for programs to use to learn about the maximum host name length which is
allowed.  _POSIX_HOST_NAME_MAX is the standard-required minimum maximum
and the value must be 256.

The problem is that HOST_NAME_MAX currently is defined as 64, as defined
by __NET_UTS_LEN in <linux/utsname.h>.  I.e., we have HOST_NAME_MAX as
smaller than the minimum maximum which is obviously not POSIX compliant.

Now, we can simply ignore the problem or do something about it and
introduce a third version of the utsname structure with sufficiently big
nodename field.

Many OSes used small values before but 256 was chosen as a minimum
maximum and some OSes were changed since host names longer than 64 chars
indeed do exist.  I wonder why this never has been brought to the
attention.  Or were people happy enough with truncated host names?


Anyway, is there interest in getting this changed?

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
