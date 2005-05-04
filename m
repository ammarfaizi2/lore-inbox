Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbVEDPkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbVEDPkj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 11:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbVEDPki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 11:40:38 -0400
Received: from vaak.stack.nl ([131.155.140.140]:60434 "EHLO mailhost.stack.nl")
	by vger.kernel.org with ESMTP id S261839AbVEDPke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 11:40:34 -0400
Date: Wed, 4 May 2005 17:40:31 +0200 (CEST)
From: Serge van den Boom <svdb@stack.nl>
To: linux-kernel@vger.kernel.org
Subject: /proc/$PID/mem rationale
Message-ID: <20050504170503.L89175@toad.stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Could someone explain the reasoning behind these two design decisions
regarding /proc/$PID/mem?
- You can only read() from this file from a process which is attached to
  the file's process through ptrace(). Why this requirement?
  The following command line could be rather useful, but the ptrace()
  requirement prevents this from working:
      dd if=/proc/$SOME_PID/mem bs=1 seek=$ADDRESS
- You can only read() from the mem file from the process that open()ed it.
  Even if the ptrace() requirement were dropped, you wouldn't be able
  to do something like the following command because of this:
      dd bs=1 seek=$ADDRESS < /proc/$SOME_PID/mem
  The usefulness of this may be limited, but I haven't been able to find
  any reason not to allow such actions.

I would appreciate it if you could CC me in replies.

Cheers,

Serge van den Boom


