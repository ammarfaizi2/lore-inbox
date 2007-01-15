Return-Path: <linux-kernel-owner+w=401wt.eu-S932174AbXAOKBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbXAOKBi (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 05:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbXAOKBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 05:01:38 -0500
Received: from smtp-out.google.com ([216.239.33.17]:6884 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932174AbXAOKBh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 05:01:37 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=kJZ2wIv3DHsNHtAeOdbFVdR3QMCTIVlgOf7n37qhEAqUxgmzWbpyYIyXHys2f4S7Z
	5hW0P2pvIIRkd6K09kJnw==
Message-ID: <6599ad830701150201i2b1cd11dk61ab8cef611c84d6@mail.gmail.com>
Date: Mon, 15 Jan 2007 02:01:19 -0800
From: "Paul Menage" <menage@google.com>
To: balbir@in.ibm.com
Subject: Re: [ckrm-tech] [PATCH 1/1] Fix a panic while mouting containers on powerpc and some other small cleanups (Re: [PATCH 4/6] containers: Simple CPU accounting container subsystem)
Cc: vatsa@in.ibm.com, sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, xemul@sw.ru, dev@sw.ru,
       containers@lists.osdl.org, pj@sgi.com, mbligh@google.com,
       winget@google.com, rohitseth@google.com, serue@us.ibm.com,
       devel@openvz.org
In-Reply-To: <45AB4EA0.3030704@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061222141442.753211763@menage.corp.google.com>
	 <20061222145216.755437205@menage.corp.google.com>
	 <45A4F675.3080503@in.ibm.com>
	 <6599ad830701111633j2ae65807sad393d2dad44a260@mail.gmail.com>
	 <45AB42E6.4020507@in.ibm.com> <45AB43B5.3070007@in.ibm.com>
	 <6599ad830701150122g7156a599t1b3dd3af9f5f821b@mail.gmail.com>
	 <45AB4EA0.3030704@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/07, Balbir Singh <balbir@in.ibm.com> wrote:
>
> While writing/extending the cpuacct container, I found it useful to
> know if the container resource group we are controlling is really mounted.
> Controllers can try and avoid doing work when not mounted and start
> when the subsystem is mounted. Also, without these callbacks, one has no
> definite way of checking if the top_container is dummy or for real.
>

That's somewhat intentional - my aim was that the controllers
shouldn't really care whether they're connected to the default
hierarchy or have been bound to some mounted hierarchy. Having said
thay, they can determine it by checking <foo>_subsys.hierarchy if they
really want to. If that's 0 then they're in the default hierarchy (and
can assume that all tasks are in one top-level container).

Paul
