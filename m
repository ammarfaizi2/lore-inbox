Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262193AbVC2IOC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbVC2IOC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 03:14:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262199AbVC2INb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 03:13:31 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:56800 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S262197AbVC2IFP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 03:05:15 -0500
Subject: Re: [patch 1/2] fork_connector: add a fork connector
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Paul Jackson <pj@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Jay Lan <jlan@engr.sgi.com>,
       Erich Focht <efocht@hpce.nec.com>, Ram <linuxram@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       dean gaudet <dean-list-linux-kernel@arctic.org>
In-Reply-To: <20050328134242.4c6f7583.pj@engr.sgi.com>
References: <1111745010.684.49.camel@frecb000711.frec.bull.fr>
	 <20050328134242.4c6f7583.pj@engr.sgi.com>
Date: Tue, 29 Mar 2005 10:05:03 +0200
Message-Id: <1112083503.20919.23.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/03/2005 10:14:43,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/03/2005 10:14:48,
	Serialize complete at 29/03/2005 10:14:48
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-28 at 13:42 -0800, Paul Jackson wrote:
> Guillaume wrote:
> >   The lmbench shows that the overhead (the construction and the sending
> > of the message) in the fork() routine is around 7%.
> 
> Thanks for including the numbers.  The 7% seems a bit costly, for a bit
> more accounting information.  Perhaps dean's suggestion, to not use
> ascii, will help.  I hope so, though I doubt it will make a huge
> difference.  Was this 7% loss with or without a user level program
> consuming the sent messages?  I would think that the number of interest
> would include a minimal consumer task.

Yes, dean's suggestion helps. The overhead is now around 4%

fork_connector disabled:
  Process fork+exit: 149.4444 microseconds

fork_connector enabled:
  Process fork+exit: 154.9167 microseconds

> Having the "#ifdef CONFIG_FORK_CONNECTOR" chunk of code right in fork.c
> seems unfortunate.  Can the real fork_connector() be put elsewhere, and
> the ifdef put in a header file that makes it a no-op if not configured,
> or simply a function declaration, if configured?

I think that it can be moved in include/linux/connector.h 

Guillaume

