Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759178AbWK3Ivk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759178AbWK3Ivk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 03:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759180AbWK3Ivk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 03:51:40 -0500
Received: from smtp-out.google.com ([216.239.33.17]:41945 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1759177AbWK3Ivj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 03:51:39 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=pdfzSyiuDzuw35a3fzwpnZQY9+T8fWzEtT8QIsmCgkmQejqgPC99b/KdYg41TUOP3
	ee0OyRLGgbjuJYLrVxpow==
Message-ID: <6599ad830611300051q5f48fb45gbfae9649e0e14524@mail.gmail.com>
Date: Thu, 30 Nov 2006 00:51:26 -0800
From: "Paul Menage" <menage@google.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [PATCH 0/7] Generic Process Containers (+ ResGroups/BeanCounters)
Cc: akpm@osdl.org, sekharan@us.ibm.com, dev@sw.ru, xemul@sw.ru,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net,
       devel@openvz.org, mbligh@google.com, winget@google.com,
       rohitseth@google.com
In-Reply-To: <20061129233229.a47e0f1b.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061123120848.051048000@menage.corp.google.com>
	 <20061129233229.a47e0f1b.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/06, Paul Jackson <pj@sgi.com> wrote:
>
> 2) I wedged the kernel on the container_lock, doing a removal of a cpuset
>    using notify_on_release.

I couldn't reproduce this, with a /sbin/cpuset_release_agent that does:

#!/bin/bash
logger cpuset_release_agent $1
rmdir /dev/cpuset/$1

and running the commands:

while true; do
  mkdir -p /dev/cpuset/bar/foo
  echo 1 > /dev/cpuset/bar/notify_on_release
  rmdir /dev/cpuset/bar/foo
  usleep 1000
done

Is it actually reproducible for you? If so, could you get a fuller backtrace?

Thanks,

Paul
