Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261969AbVD1K3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbVD1K3u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 06:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbVD1K3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 06:29:50 -0400
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:40338 "HELO
	server5.heliogroup.fr") by vger.kernel.org with SMTP
	id S261969AbVD1K3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 06:29:49 -0400
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc3 mmap lack of consistency among runs
Date: Thu, 28 Apr 2005 09:59:55 GMT
Message-ID: <0561FRW12@server5.heliogroup.fr>
X-Mailer: Pliant 93
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a way to freeze then restart processes,
the first shot of the process calls 'mmap' with NULL as 'start',
then restarts of the process will call 'mmap' with the value received at the
first shot, and expect to be assigned the requested area.

This used to work perfectly with 2.6.11 and all previous kernels (unless some
shared libraries have been upgraded in the mean time),
but with 2.6.12-rc3 (I have not tested rc1 and rc2) it fails half time.

I can solve the problem through specifying a 'start' value at the first shot,
but then I will get a more serious problem on the long run because the
application would then have to be awared of the general layout of the address
space enforced by the kernel and so could be disturbed by any change.
