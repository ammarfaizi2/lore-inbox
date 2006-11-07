Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753224AbWKGUmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224AbWKGUmF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 15:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753201AbWKGUmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 15:42:05 -0500
Received: from smtp-out.google.com ([216.239.45.12]:44816 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1753196AbWKGUmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 15:42:02 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=NnAHwXjypL2o/oj3QJ9ZFTRpKgB43dNagmskUYfwaPklaDD55YwGixvxZXZFFbdHE
	j7tfP6OH81FbWInGScbAg==
Message-ID: <6599ad830611071241p255b205em52ed3ba13e02cdc2@mail.gmail.com>
Date: Tue, 7 Nov 2006 12:41:37 -0800
From: "Paul Menage" <menage@google.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Cc: vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
In-Reply-To: <20061107123458.e369f62a.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061030031531.8c671815.pj@sgi.com>
	 <20061031115342.GB9588@in.ibm.com>
	 <6599ad830610310846m5d718d22p5e1b569d4ef4e63@mail.gmail.com>
	 <20061101172540.GA8904@in.ibm.com>
	 <6599ad830611011537i2de812fck99822d3dd1314992@mail.gmail.com>
	 <20061106124948.GA3027@in.ibm.com>
	 <6599ad830611061223m77c0ef1ei72bd7729d9284ec6@mail.gmail.com>
	 <20061107104118.f02a1114.pj@sgi.com>
	 <6599ad830611071107u4226ec17h5facc7ee2ad53174@mail.gmail.com>
	 <20061107123458.e369f62a.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/06, Paul Jackson <pj@sgi.com> wrote:
> How about /proc/<pid>/containers being a directory, with each
> controller having one regular file entry (so long as we haven't done
> the multiple controller instances in my item (5)) containing the path,
> relative to some container file system mount point (which container
> mount is up to user space code to track) of the container that contains
> that task?

Hmm. Seems a bit fancier than necessary, but maybe reasonable. I'll
probably start with a single file listing all the different container
associations and we can turn it into a directory later as a finishing
touch.

>
> Or how about each controller type, such as cpusets, having its own
> /proc/<pid>/<controller-type> file, with no generic file
> /proc</pid>/container at all.  Just extend the current model
> seen in /proc/<pid>/cpuset ?

Is it possible to dynamically extend the /proc/<pid>/ directory? If
not, then every container subsystem would involve a patch in
fs/proc/base.c, which seems a bit nasty.

> However this fits in nicely with my expectation that we will have
> only limited need, if any, in the short term, to run systems with
> both cpusets and resource groups at the same time.

We're currently planning on using cpusets for the memory node
isolation properties, but we have a whole bunch of other resource
controllers that we'd like to be able to hang off the same
infrastructure, so I don't think the need is that limited.

>
> And while we're here, how about each controller naming itself with a
> well known string compiled into its kernel code, and a file such
> as /proc/containers listing what controllers are known to it?  Not

The naming is already in my patch. You can tell from the top-level
directory which containers are registered, since each one has an
xxx_enabled file to control whether it's in use; there's not a
separate /proc/containers file yet.

Paul
