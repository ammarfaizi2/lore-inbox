Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbVC3GjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbVC3GjX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 01:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVC3GjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 01:39:23 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:19844 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261766AbVC3GjC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 01:39:02 -0500
Subject: Re: [patch 1/2] fork_connector: add a fork connector
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Jay Lan <jlan@engr.sgi.com>, Paul Jackson <pj@engr.sgi.com>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
       Erich Focht <efocht@hpce.nec.com>, Ram <linuxram@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.62.0503292200550.30657@twinlark.arctic.org>
References: <1111745010.684.49.camel@frecb000711.frec.bull.fr>
	 <20050328134242.4c6f7583.pj@engr.sgi.com> <1112079856.5243.24.camel@uganda>
	 <20050329004915.27cd0edf.pj@engr.sgi.com> <1112092197.5243.80.camel@uganda>
	 <20050329090304.23fbb340.pj@engr.sgi.com> <4249C418.5040007@engr.sgi.com>
	 <Pine.LNX.4.62.0503292200550.30657@twinlark.arctic.org>
Date: Wed, 30 Mar 2005 08:38:46 +0200
Message-Id: <1112164726.8426.119.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/03/2005 08:48:32,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/03/2005 08:48:35,
	Serialize complete at 30/03/2005 08:48:35
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-29 at 22:06 -0800, dean gaudet wrote:
> On Tue, 29 Mar 2005, Jay Lan wrote:
> 
> > The fork_connector is not designed to solve accounting data collection
> > problem.
> > 
> > The accounting data collection must be done via a hook from do_exit().
> 
> by the time do_exit() occurs the parent may have disappeared... you do 
> need to record something at fork() time so that you can account to the 
> correct ancestor.

You're right. At fork(), the "job daemon", provided by ELSA, records
information about parent PID, child PID and also about the group of
processes they belong to. At exit(), accounting data are recorded by CSA
or BSD-like accounting. 

> an example of where this ancestry is useful would be the summation of all 
> cpu time spent by children of apache, spamd, clamd, ...

You're right. One usage can be: apache, spamd and clamd can be put in a
job (a group of processes) by using the "job daemon" and automatically,
all children will belong to the same jobs respectively. So the gaol here
is really to perform per-group of processes accounting using ELSA and
CSA accounting data.

Best Regards,
Guillaume

