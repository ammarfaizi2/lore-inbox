Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423580AbWJaQfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423580AbWJaQfJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 11:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423584AbWJaQfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 11:35:08 -0500
Received: from smtp-out.google.com ([216.239.45.12]:29512 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1423580AbWJaQfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 11:35:06 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=turaI3gx5hvKYFYPmZaDupKIa3X54BjKkbO7jDsr9qxcknfChEU+un61EgBz2hv3f
	HVLZ4Nm6oOULyod50pRjg==
Message-ID: <6599ad830610310834g12a66aan29b568d7f9a5525@mail.gmail.com>
Date: Tue, 31 Oct 2006 08:34:52 -0800
From: "Paul Menage" <menage@google.com>
To: "Pavel Emelianov" <xemul@openvz.org>
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Cc: dev@openvz.org, vatsa@in.ibm.com, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com, devel@openvz.org
In-Reply-To: <454709E0.1000409@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061030103356.GA16833@in.ibm.com> <45460743.8000501@openvz.org>
	 <6599ad830610301001i2ad35290u63839e920d82a5f4@mail.gmail.com>
	 <454709E0.1000409@openvz.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/06, Pavel Emelianov <xemul@openvz.org> wrote:
>
> That's functionality user may want. I agree that some users
> may want to create some kind of "persistent" beancounters, but
> this must not be the only way to control them. I like the way
> TUN devices are done. Each has TUN_PERSIST flag controlling
> whether or not to destroy device right on closing. I think that
> we may have something similar - a flag BC_PERSISTENT to keep
> beancounters with zero refcounter in memory to reuse them.

How about the cpusets approach, where once a cpuset has no children
and no processes, a usermode helper can be executed - this could
immediately remove the container/bean-counter if that's what the user
wants. My generic containers patch copies this from cpusets.

>
> Moreover, I hope you agree that beancounters can't be made as
> module. If so user will have to built-in configfs, and thus
> CONFIG_CONFIGFS_FS essentially becomes "bool", not a "tristate".

How about a small custom filesystem as part of the containers support,
then? I'm not wedded to using configfs itself, but I do think that a
filesystem interface is much more debuggable and extensible than a
system call interface, and the simple filesystem is only a couple of
hundred lines.

Paul
