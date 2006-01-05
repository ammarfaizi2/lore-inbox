Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWAESpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWAESpm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 13:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWAESpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 13:45:42 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:45512 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932139AbWAESpl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 13:45:41 -0500
Subject: [PATCH 00/01] Move Exit Connectors
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jay Lan <jlan@engr.sgi.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>, elsa-devel@lists.sourceforge.net,
       lse-tech@lists.sourceforge.net,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       Erik Jacobson <erikj@sgi.com>, Jack Steiner <steiner@sgi.com>,
       John Hesterberg <jh@sgi.com>
In-Reply-To: <20060104151730.77df5bf6.akpm@osdl.org>
References: <43BB05D8.6070101@watson.ibm.com>
	 <43BB09D4.2060209@watson.ibm.com> <43BC1C43.9020101@engr.sgi.com>
	 <1136414431.22868.115.camel@stark>  <20060104151730.77df5bf6.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 10:42:46 -0800
Message-Id: <1136486566.22868.127.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-04 at 15:17 -0800, Andrew Morton wrote:
> Matt Helsley <matthltc@us.ibm.com> wrote:
> >
> > > We need to move both proc_exit_connector(tsk) and
> > > cnstats_exit_connector(tsk) up to before exit_mm(tsk) statement.
> > > There are task statistics collected in task->mm and those stats
> > > will be lost after exit_mm(tsk).
> > > 
> > > Thanks,
> > >  - jay
> > > 
> > > > 	exit_notify(tsk);
> > > > #ifdef CONFIG_NUMA
> > > > 	mpol_free(tsk->mempolicy);
> > > >-
> > 
> > 	Good point. The assignment of the task exit code will also have to move
> > up before exit_mm(tsk) because the process event connector exit function
> > retrieves the exit code from the task struct.
> 
> Could someone please volunteer to do the patch?

Here are two separate patches (not a series).

The first simply moves the process event connector north of exit_mm().
It applies to a clean 2.6.15 kernel. Please consider it for -mm.

The second patch moves both -- it's intended to be applied on top of
Shailabh's series of patches.

Cheers,
	-Matt Helsley

