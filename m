Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752785AbWKBL0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785AbWKBL0w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 06:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752855AbWKBL0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 06:26:52 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:18901 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752785AbWKBL0v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 06:26:51 -0500
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
From: Matt Helsley <matthltc@us.ibm.com>
To: Pavel Emelianov <xemul@openvz.org>
Cc: Paul Menage <menage@google.com>, vatsa@in.ibm.com, dev@openvz.org,
       sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org, pj@sgi.com,
       dipankar@in.ibm.com, rohitseth@google.com
In-Reply-To: <4549B5A3.2010908@openvz.org>
References: <20061030103356.GA16833@in.ibm.com>
	 <45486925.4000201@openvz.org>	 <20061101181236.GC22976@in.ibm.com>
	 <1162419565.12419.154.camel@localhost.localdomain>
	 <6599ad830611011550m69876b1ase3579167903a7cd7@mail.gmail.com>
	 <4549B5A3.2010908@openvz.org>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Thu, 02 Nov 2006 03:26:47 -0800
Message-Id: <1162466807.12419.194.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-02 at 12:08 +0300, Pavel Emelianov wrote:
> [snip]
> 
> > I think that having a "tasks" file and a "threads" file in each
> > container directory would be a clean way to handle it:
> > 
> > "tasks" : read/write complete process members
> > "threads" : read/write individual thread members
> 
> I've just thought of it.
> 
> Beancounter may have more than 409 tasks, while configfs
> doesn't allow attributes to store more than PAGE_SIZE bytes
> on read. So how would you fill so many tasks in one page?

	To be clear that's a limitation of configfs as an interface. In the
Resource Groups code, for example, there is no hard limitation on length
of the underlying list. This is why we're talking about a filesystem
interface and not necessarily a configfs interface.

> I like the idea of writing pids/tids to these files, but
> printing them back is not that easy.

	That depends on how you do it. For instance, if you don't have an
explicit list of tasks in the group (rough cost: 1 list head per task)
then yes, it could be difficult.

Cheers,
	-Matt Helsley

