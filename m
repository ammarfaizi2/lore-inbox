Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269840AbUJHL0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269840AbUJHL0J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 07:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269852AbUJHLZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 07:25:28 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:1201 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S269839AbUJHLWB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 07:22:01 -0400
Subject: Re: 2.6.9-rc2-mm4-VP-S7 - ksoftirq and selinux oddity
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
       lkml <linux-kernel@vger.kernel.org>, SELinux@tycho.nsa.gov,
       Ingo Molnar <mingo@redhat.com>, netdev@oss.sgi.com,
       linux-net@vger.kernel.org
In-Reply-To: <20041008093154.GA5089@lkcl.net>
References: <200410070542.i975gkHV031259@turing-police.cc.vt.edu>
	 <1097157367.13339.38.camel@moss-spartans.epoch.ncsc.mil>
	 <20041008093154.GA5089@lkcl.net>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1097234322.16641.3.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 08 Oct 2004 07:18:42 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 05:31, Luke Kenneth Casson Leighton wrote:
>  an alternative possible solution is to get the packet _out_ from
>  the interrupt context and have the aux pid comm exe information added.

No, the network permission checks are intentionally layered to match the
network protocol implementation.  There is a process-to-socket check
performed in process context when the data is received from the socket
by an actual process, but there is also the socket-to-netif/node/port
check performed in softirq context when the packet is received on the
socket from the network.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

