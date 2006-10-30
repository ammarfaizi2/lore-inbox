Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbWJ3MH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWJ3MH3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 07:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWJ3MH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 07:07:29 -0500
Received: from smtp-out.google.com ([216.239.33.17]:50170 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750980AbWJ3MH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 07:07:26 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=ktgnDc9uWILYKAsxFWewkxHfghTunfNiqkO+8Guc8/nEaMFKEbsXU65+h3nIz7GXO
	DWO/mATwutsbq6tSQFmPg==
Message-ID: <6599ad830610300407x674059ebh8337d05a4e8ebe85@mail.gmail.com>
Date: Mon, 30 Oct 2006 04:07:20 -0800
From: "Paul Menage" <menage@google.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Cc: vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
In-Reply-To: <20061030030635.98563962.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061030103356.GA16833@in.ibm.com>
	 <6599ad830610300251w1f4e0a70ka1d64b15d8da2b77@mail.gmail.com>
	 <20061030030635.98563962.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/06, Paul Jackson <pj@sgi.com> wrote:
> I get away with this in the cpuset code because:
>  1) I have the cpuset pointer directly in 'task_struct', so don't
>     have to chase down anything, for each task, while scanning the
>     task list.  I just have to ask, for each task, if its cpuset
>     pointer points to the cpuset of interest.

That's the same when it's transferred to containers - each task_struct
now has a container pointer, and you can just see whether the
container pointer matches the container that you're interested in.

>  2) I don't care if I get an inconsistent answer, so I don't have
>     to lock each task, nor do I even lockout the rest of the cpuset
>     code.  All I know, at the end of the scan, is that each task that
>     I claim is attached to the cpuset in question was attached to it at
>     some point during my scan, not necessarilly all at the same time.

Well, anything that can be accomplished from within the tasklist_lock
can get a consistent result without any additional lists or
synchronization - it seems that it would be good to come up with a
real-world example of something that *can't* make do with this before
adding extra book-keeping.

Paul
