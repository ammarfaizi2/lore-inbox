Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161557AbWAMKim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161557AbWAMKim (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 05:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161558AbWAMKim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 05:38:42 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:46292 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1161559AbWAMKil
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 05:38:41 -0500
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Shailabh Nagar <nagar@watson.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Jay Lan <jlan@engr.sgi.com>, LKML <linux-kernel@vger.kernel.org>,
       elsa-devel@lists.sourceforge.net, lse-tech@lists.sourceforge.net,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       Erik Jacobson <erikj@sgi.com>, Jack Steiner <steiner@sgi.com>,
       John Hesterberg <jh@sgi.com>
Subject: Re: [Lse-tech] Re: [ckrm-tech] Re: [PATCH 00/01] Move Exit Connectors
References: <43BB05D8.6070101@watson.ibm.com>
	<43BB09D4.2060209@watson.ibm.com> <43BC1C43.9020101@engr.sgi.com>
	<1136414431.22868.115.camel@stark>
	<20060104151730.77df5bf6.akpm@osdl.org>
	<1136486566.22868.127.camel@stark> <1136488842.22868.142.camel@stark>
	<20060105151016.732612fd.akpm@osdl.org>
	<1136505973.22868.192.camel@stark> <yq08xttybrx.fsf@jaguar.mkp.net>
	<43BE9E91.9060302@watson.ibm.com> <yq0wth72gr6.fsf@jaguar.mkp.net>
	<1137013330.6673.80.camel@stark> <yq0k6d53hb1.fsf@jaguar.mkp.net>
	<1137106871.6673.238.camel@stark>
From: Jes Sorensen <jes@trained-monkey.org>
Date: 13 Jan 2006 05:38:39 -0500
In-Reply-To: <1137106871.6673.238.camel@stark>
Message-ID: <yq03bjs2z0w.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Matt" == Matt Helsley <matthltc@us.ibm.com> writes:

Matt> On Thu, 2006-01-12 at 04:51 -0500, Jes Sorensen wrote:
Matt> Have you looked at Alan Stern's notifier chain fix patch?  Could
Matt> that be used in task_notify?
>>  No sorry, do you have a pointer?

Matt> No problem. Here it is:
Matt> http://marc.theaimsgroup.com/?l=linux-kernel&m=113407207418475&w=2

Matt> I think it would be ideal if task_notify could simply be a
Matt> notifier chain for notifying users of task events/changes.

Ok, went back and looked at this. I think the core concept is fine,
but there are details such as having a data pointer associated with
the notifier block which is too important to leave out. Otherwise we
have to stick things into the task struct in many cases which is a
waste of space. I also think it needs to be possible to search the
list for special slow path uses to avoid us adding excessive amounts
of callbacks that are only used in one place by one client.

If we can cross-API it for task-group-notifiers then that should be
fine.

Cheers,
Jes
