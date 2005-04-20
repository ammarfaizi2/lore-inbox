Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbVDTRVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVDTRVq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 13:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbVDTRTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 13:19:33 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:40844 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261746AbVDTRSr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 13:18:47 -0400
Subject: Re: [RFC][PATCH] nameing reserved pages [0/3]
From: Dave Hansen <haveblue@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Hariprasad Nellitheertha [imap]" <hari@in.ibm.com>
In-Reply-To: <1114007431.6238.79.camel@laptopd505.fenrus.org>
References: <426644DA.70105@jp.fujitsu.com>
	 <1114000447.6238.64.camel@laptopd505.fenrus.org>
	 <426663E8.3080502@jp.fujitsu.com>
	 <1114007431.6238.79.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Wed, 20 Apr 2005 10:18:25 -0700
Message-Id: <1114017505.6927.20.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-20 at 16:30 +0200, Arjan van de Ven wrote:
> Why do you want this exported to userspace? There is absolutely no way
> you can get this exported race free without shutting the VM down, and
> without being race free this information has absolutely no meaning !!
> (and when you shut the VM down you really shouldn't depend on userspace
> anymore either)

The two cases where this is expected to be used are not concerned with
races.  The first is when a memory remove operation occurs.  It first
looks at the hotplug area, and removes all the pages that it can from
the allocator.  Then, it sets about migrating all of the other pages
that are being used for things like page cache or anonymous memory.

After that, the question sometimes remains why particular pages can't be
removed.  Kame's patch is an attempt to help figure that out.

That's one reason I suggested having an individual device file for each
of the memory areas that get added or removed.  It would keep the
confusion to a minimum, and you'd be more sure that what you were
looking at was information only for the memory area that is *almost*
removed.

I don't know what state the system is in when the kdump folks want to
read this information.

-- Dave

