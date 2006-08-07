Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWHGTDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWHGTDb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 15:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWHGTDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 15:03:31 -0400
Received: from smtp-out.google.com ([216.239.45.12]:30312 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932210AbWHGTDa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 15:03:30 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=GU4yv6LrmJoje5vOkQf50aTcun62/tuRcXNl9/JIZ93JHyMKakQHXuq5GlkUyS6zs
	mIELDnzU/CkwRsfSmavTA==
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A
	cpu controller
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>, "Martin J. Bligh" <mbligh@mbligh.org>,
       vatsa@in.ibm.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, mingo@elte.hu, nickpiggin@yahoo.com.au,
       sam@vilain.net, linux-kernel@vger.kernel.org, dev@openvz.org,
       efault@gmx.de, balbir@in.ibm.com, sekharan@us.ibm.com,
       nagar@watson.ibm.com, pj@sgi.com, Andrey Savochkin <saw@sw.ru>
In-Reply-To: <1154976236.19249.9.camel@localhost.localdomain>
References: <20060804050753.GD27194@in.ibm.com>
	 <20060803223650.423f2e6a.akpm@osdl.org>
	 <20060803224253.49068b98.akpm@osdl.org>
	 <1154684950.23655.178.camel@localhost.localdomain>
	 <20060804114109.GA28988@in.ibm.com> <44D35F0B.5000801@sw.ru>
	 <44D388DF.8010406@mbligh.org> <44D6EAFA.8080607@sw.ru>
	 <44D74F77.7080000@mbligh.org>  <44D76B43.5080507@sw.ru>
	 <1154975486.31962.40.camel@galaxy.corp.google.com>
	 <1154976236.19249.9.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Google Inc
Date: Mon, 07 Aug 2006 12:00:57 -0700
Message-Id: <1154977257.31962.57.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-07 at 11:43 -0700, Dave Hansen wrote:
> On Mon, 2006-08-07 at 11:31 -0700, Rohit Seth wrote:
> > I think it is not a problem for OpenVZ because there is not that much
> > of
> > sharing going between containers as you mentioned (btw, this least
> > amount of sharing is a very good thing).  Though I'm not sure if one
> > has
> > to go to the extent of doing fractions with memory accounting.  If the
> > containers are set up in such a way that there is some sharing across
> > containers then it is okay to be unfair and charge one of those
> > containers for the specific resource completely. 
> 
> Right, and if you do reclaim against containers which are over their
> limits, the containers being unfairly charged will tend to get hit
> first.  But, once this happens, I would hope that the ownership of those
> shared pages should settle out among all of the users.
> 

I think there is lot of simplicity and value add by charging one
container (even unfairly) for one resource completely.  This puts the
onus on system admin to set up the containers appropriately.

> If you have 100 containers sharing 100 pages, container0 might be
> charged for all 100 pages at first, but I'd hope that eventually
> containers 0->99 would each get charged for a single page. 
> 

You would be better off having a notion of "shared" container where
these kind of resources get charged. So, if 100 processes are all
touching pages from some common file then the file could be part of
self-contained container with its own limits etc. 

-rohit

