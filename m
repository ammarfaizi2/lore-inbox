Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262270AbVC2JRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbVC2JRb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 04:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbVC2JRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 04:17:31 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:4074 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S262270AbVC2JRN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 04:17:13 -0500
Subject: Re: [patch 1/2] fork_connector: add a fork connector
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Paul Jackson <pj@engr.sgi.com>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
       Jay Lan <jlan@engr.sgi.com>, Erich Focht <efocht@hpce.nec.com>,
       Ram <linuxram@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>
In-Reply-To: <20050329004915.27cd0edf.pj@engr.sgi.com>
References: <1111745010.684.49.camel@frecb000711.frec.bull.fr>
	 <20050328134242.4c6f7583.pj@engr.sgi.com> <1112079856.5243.24.camel@uganda>
	 <20050329004915.27cd0edf.pj@engr.sgi.com>
Date: Tue, 29 Mar 2005 11:17:02 +0200
Message-Id: <1112087822.8426.46.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/03/2005 11:26:43,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/03/2005 11:26:45,
	Serialize complete at 29/03/2005 11:26:45
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-29 at 00:49 -0800, Paul Jackson wrote:
>   This
> amortizes the cost of almost all the handling, and of all the disk i/o,
> over many data collection events.  Correct me if I'm wrong, but
> fork_connector doesn't do this merging of events into a consolidated
> data buffer, so is at a distinct disadvantage, for this use, because the
> data merging is delayed, and a separate, user level process, is required
> to accomplish the merging and conversion to writable blocks of data
> suitable for storing on the disk.

  The goal of the fork connector is to inform a user space application
that a fork occurs in the kernel. This information (cpu ID, parent PID
and child PID) can be used by several user space applications. It's not
only for accounting. Accounting and fork_connector are two different
things and thus, fork_connector doesn't do the merge of any kinds of
data (and it will never do). 

  One difference with relayfs is the amount of datas that are
transfered. The relayfs is done, like Evgeniy said, for large amount of
datas. So I think that it's not suitable for what we want to achieve
with the fork connector.


I hope this help,
Regards,
Guillaume

