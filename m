Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312938AbSDHIYV>; Mon, 8 Apr 2002 04:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313482AbSDHIYU>; Mon, 8 Apr 2002 04:24:20 -0400
Received: from cpe-66-87-67-85.ca.sprintbbd.net ([66.87.67.85]:2820 "EHLO
	minerva.ekline.com") by vger.kernel.org with ESMTP
	id <S312938AbSDHIYT>; Mon, 8 Apr 2002 04:24:19 -0400
Message-Id: <200204080824.g388Nxo32454@minerva.ekline.com>
Content-Type: text/plain; charset=US-ASCII
From: Erik Kline <ekline@ekline.com>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] pam_capability 0.0.13 + 2.4.18 kernel patch
Date: Mon, 8 Apr 2002 00:23:59 -0800
X-Mailer: KMail [version 1.3.1]
Cc: lwn@lwn.net
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

I'd like to announce a new linux pam module called "pam_capability". Taking a 
cue from the capabilities FAQ:
	ftp://ftp.guardian.no/pub/free/linux/capabilities/capfaq.txt
I have tried to implement role-based assigned capabilities for users via a 
pam module. However, lacking capability support in VFS, I patched the kernel 
to pass the process inheritable capabilities to an exec'd binary's permitted 
and effective set during exec (in <src_dir>/fs/exec.c). This ensures that the 
new exec'd binary's process effective set is equal to the inherited set. This 
seemed simplest to implement.  I believe it to be a good way to debug proper 
capability support in the kernel prior to full  VFS support. Suffice it to 
say, you can now easily assign capabilities to users or to process users 
(like "ntp", "apache", and "bind", granting them CAP_NET_BIND_SERVICE, 
allowing them to bind to reserved ports w/o running as root) via pam for such 
services as sshd, login, and su.

I'd like very much to get feedback and help w/ testing the supplied patch and 
pam module: how it can be made more secure, what role definitions work well 
for certain applications, bugs, anything.

The freshmeat project URL is:

	http://freshmeat.net/projects/pam_capability/

and the download URL is:

	http://ekline.com/linux/pam_capability/

Yours, in code,
-Erik Kline

Many personal thanks to Jason Baietto.
