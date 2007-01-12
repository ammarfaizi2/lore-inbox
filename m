Return-Path: <linux-kernel-owner+w=401wt.eu-S932825AbXALIP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932825AbXALIP0 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 03:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932826AbXALIP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 03:15:26 -0500
Received: from smtp-out.google.com ([216.239.33.17]:54329 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932825AbXALIPZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 03:15:25 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=DTiFBpiVQMCgA9E+fJq3inKWnl5wT6GPOphdowAyY0oRt9at6Eed9ksih3IwvoVo2
	3NFibsoM1eH1q+hofnTng==
Message-ID: <6599ad830701120015k440a16c8sec25a4db23865ebd@mail.gmail.com>
Date: Fri, 12 Jan 2007 00:15:14 -0800
From: "Paul Menage" <menage@google.com>
To: balbir@in.ibm.com
Subject: Re: [ckrm-tech] [PATCH 4/6] containers: Simple CPU accounting container subsystem
Cc: akpm@osdl.org, pj@sgi.com, sekharan@us.ibm.com, dev@sw.ru, xemul@sw.ru,
       serue@us.ibm.com, vatsa@in.ibm.com, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rohitseth@google.com, mbligh@google.com,
       winget@google.com, containers@lists.osdl.org, devel@openvz.org
In-Reply-To: <45A729A9.5070902@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061222141442.753211763@menage.corp.google.com>
	 <20061222145216.755437205@menage.corp.google.com>
	 <45A4F675.3080503@in.ibm.com>
	 <6599ad830701111633j2ae65807sad393d2dad44a260@mail.gmail.com>
	 <45A729A9.5070902@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/07, Balbir Singh <balbir@in.ibm.com> wrote:
>
> I tried something similar, I added an activated field, which is set
> to true when the ->create() callback is invoked. That did not help
> either, the machine still panic'ed.

I think that marking it active when create() is called may be too soon.

Is this with my unchanged cpuacct subsystem, or with the version that
you've extended to track load over defined periods? I don't see it
when I test under VMware (with two processors in the VM), but I
suspect that's not going to be quite as parallel as a real SMP system.

>
> I see the need for it, but I wonder if we should start with that
> right away. I understand that people might want to group cpusets
> differently from their grouping of let's say the cpu resource
> manager. I would still prefer to start with one hierarchy and then
> move to multiple hierarchies. I am concerned that adding complexity
> upfront might turn off people from using the infrastructure.

That's what I had originally and people objected to the lack of flexibility :-)

The presence or absence of multiple hierarchies is pretty much exposed
to userspace, and presenting the right interface to userspace is a
fairly important thing to get right from the start.

Paul
