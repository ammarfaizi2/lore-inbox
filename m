Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135267AbRDRXqE>; Wed, 18 Apr 2001 19:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135479AbRDRXpx>; Wed, 18 Apr 2001 19:45:53 -0400
Received: from suntan.tandem.com ([192.216.221.8]:59389 "EHLO
	suntan.tandem.com") by vger.kernel.org with ESMTP
	id <S135267AbRDRXpr>; Wed, 18 Apr 2001 19:45:47 -0400
Message-ID: <3ADE27C3.F5962329@compaq.com>
Date: Wed, 18 Apr 2001 16:48:19 -0700
From: "Brian J. Watson" <Brian.J.Watson@compaq.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.2.12-20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Why does do_signal() repost deadly signals?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If a signal's default behavior is to kill a process, do_signal() reposts that
signal before calling do_exit(). Why does it do that?

Our guess is that it prevents the exiting process from blocking for an extremely
long period of time. One example might be a process with an open NFS file. The
process has to flush its writes out to the server during the close, but the
server might be unavailable. Examining the code, it looks like the reposted
signal prevents the NFS flush from waiting on any RPC response.

Is this the reason for reposting the signal? Are there any others?

--
Brian Watson
Compaq Computer

Not subscribed to LKML. Please CC me in response.
