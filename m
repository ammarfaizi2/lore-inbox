Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbVCHIqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVCHIqA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 03:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVCHIqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 03:46:00 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:9859 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261880AbVCHIpw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 03:45:52 -0500
Subject: Re: [PATCH 2.6.11-rc4-mm1] connector: Add a fork connector
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Jay Lan <jlan@engr.sgi.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Erich Focht <efocht@hpce.nec.com>, Kaigai Kohei <kaigai@ak.jp.nec.com>
In-Reply-To: <1110266972.10433.27.camel@frecb000711.frec.bull.fr>
References: <1109240677.1738.196.camel@frecb000711.frec.bull.fr>
	 <1110266972.10433.27.camel@frecb000711.frec.bull.fr>
Date: Tue, 08 Mar 2005 09:45:51 +0100
Message-Id: <1110271551.10590.41.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 08/03/2005 09:54:58,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 08/03/2005 09:55:01,
	Serialize complete at 08/03/2005 09:55:01
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-08 at 08:29 +0100, Guillaume Thouvenin wrote:
>   TODO:
>     - Run the lmbench with the user space application that manages
>       group of processus. if fork connector is not used the only 
>       overhead is a test in the do_fork() routine.

For information here are some results when using the process creation
tests "lat_proc fork". Test was run ten times thus the average is
computed with the ten metrics.

with a kernel 2.6.11-rc4-mm1
        max value = 164.0588 msec
        min value = 159.8571 msec
        average   = 161.7012 msec

with a kernel 2.6.11-rc4-mm1 and the cnfork (cn_fork_enable == 0)
        max value = 163.3438 msec
        min value = 159.8857 msec
        average   = 160.9447 msec

with a kernel 2.6.11-rc4-mm1 and the cnfork (cn_fork_enable == 1)
        max value = 177.6885 msec
        min value = 170.9057 msec
        average   = 173.7675 msec

  So we see that when the fork connector is disable the time it takes to
split a process into two copies is the same (and it's normal) and when
the fork connector is enable, it's around 7.5% slower.

Best,
Guillaume  


