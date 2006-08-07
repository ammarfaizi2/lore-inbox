Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWHGSoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWHGSoI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 14:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWHGSoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 14:44:07 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:25058 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932306AbWHGSoG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 14:44:06 -0400
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A
	cpu controller
From: Dave Hansen <haveblue@us.ibm.com>
To: rohitseth@google.com
Cc: Kirill Korotaev <dev@sw.ru>, "Martin J. Bligh" <mbligh@mbligh.org>,
       vatsa@in.ibm.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, mingo@elte.hu, nickpiggin@yahoo.com.au,
       sam@vilain.net, linux-kernel@vger.kernel.org, dev@openvz.org,
       efault@gmx.de, balbir@in.ibm.com, sekharan@us.ibm.com,
       nagar@watson.ibm.com, pj@sgi.com, Andrey Savochkin <saw@sw.ru>
In-Reply-To: <1154975486.31962.40.camel@galaxy.corp.google.com>
References: <20060804050753.GD27194@in.ibm.com>
	 <20060803223650.423f2e6a.akpm@osdl.org>
	 <20060803224253.49068b98.akpm@osdl.org>
	 <1154684950.23655.178.camel@localhost.localdomain>
	 <20060804114109.GA28988@in.ibm.com> <44D35F0B.5000801@sw.ru>
	 <44D388DF.8010406@mbligh.org> <44D6EAFA.8080607@sw.ru>
	 <44D74F77.7080000@mbligh.org>  <44D76B43.5080507@sw.ru>
	 <1154975486.31962.40.camel@galaxy.corp.google.com>
Content-Type: text/plain
Date: Mon, 07 Aug 2006 11:43:56 -0700
Message-Id: <1154976236.19249.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-07 at 11:31 -0700, Rohit Seth wrote:
> I think it is not a problem for OpenVZ because there is not that much
> of
> sharing going between containers as you mentioned (btw, this least
> amount of sharing is a very good thing).  Though I'm not sure if one
> has
> to go to the extent of doing fractions with memory accounting.  If the
> containers are set up in such a way that there is some sharing across
> containers then it is okay to be unfair and charge one of those
> containers for the specific resource completely. 

Right, and if you do reclaim against containers which are over their
limits, the containers being unfairly charged will tend to get hit
first.  But, once this happens, I would hope that the ownership of those
shared pages should settle out among all of the users.

If you have 100 containers sharing 100 pages, container0 might be
charged for all 100 pages at first, but I'd hope that eventually
containers 0->99 would each get charged for a single page. 

-- Dave

