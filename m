Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268059AbUHXPmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268059AbUHXPmw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 11:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268004AbUHXPjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 11:39:43 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:40164 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S267941AbUHXPi7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 11:38:59 -0400
Subject: Re: RCU issue with SELinux (Re: SELINUX performance issues)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
       "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@redhat.com>
In-Reply-To: <042b01c489ab$8a871ce0$f97d220a@linux.bs1.fc.nec.co.jp>
References: <Xine.LNX.4.44.0408161119160.4659-100000@dhcp83-76.boston.redhat.com>
	 <032901c486ba$a3478970$f97d220a@linux.bs1.fc.nec.co.jp>
	 <1093014789.16585.186.camel@moss-spartans.epoch.ncsc.mil>
	 <042b01c489ab$8a871ce0$f97d220a@linux.bs1.fc.nec.co.jp>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1093361844.1800.150.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 24 Aug 2004 11:37:24 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-24 at 03:25, Kaigai Kohei wrote:
> You are right. Indeed, the lock for hash bucket is also necessary
> when avc_insert() is called. I fixed them.

avc_has_perm* can be called from interrupt or bh, e.g. send_sigio or
sock_rcv_skb.  So using just spin_lock/spin_unlock rather than
spin_lock_irqsave/restore is unsafe, right?
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

