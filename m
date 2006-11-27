Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755776AbWK0BeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755776AbWK0BeG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 20:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755779AbWK0BeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 20:34:06 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:42928 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1755773AbWK0BeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 20:34:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FXCSnXwJ9JTDYsi3nx91kpf11xLhGgwX+q9GFMi/Wqz6ZWCw1jnZcnhvY9p68P7G4OvMuXw4rYwzJ1ajxuGye9Phem8EYxO+I3EVnhCFjZYBwpmMFL4NGbN5ry+WSDBDfyI/lTebx/y9ISSj/2PHEesM4FHJKk8kH8NueGsOrgU=
Message-ID: <8bd0f97a0611261734i292a5c14s196ae037608c2c32@mail.gmail.com>
Date: Sun, 26 Nov 2006 20:34:02 -0500
From: "Mike Frysinger" <vapier.adi@gmail.com>
To: "Peter Zijlstra" <a.p.zijlstra@chello.nl>
Subject: Re: The VFS cache is not freed when there is not enough free memory to allocate
Cc: Aubrey <aubreylee@gmail.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mel <mel@csn.ul.ie>,
       "Andy Whitcroft" <apw@shadowen.org>
In-Reply-To: <1164192171.5968.186.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6d6a94c50611212351if1701ecx7b89b3fe79371554@mail.gmail.com>
	 <1164185036.5968.179.camel@twins>
	 <6d6a94c50611220202t1d076b4cye70dcdcc19f56e55@mail.gmail.com>
	 <1164192171.5968.186.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/06, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> Yes it does that, but there is no guarantee that those 50MB have a
> single 1M contiguous region amongst them.

right ... the testcase posted is more to quickly illustrate the
problem ... the requested size doesnt really matter, what does matter
is that we cant seem to reclaim memory from the VFS cache in scenarios
where the VFS cache is eating a ton of memory and we need some more

another scenario is where an application is constantly reading data
from a cd, re-encoding it to mp3, and then writing it to disk.  the
VFS cache here quickly eats up the available memory.
-mike
