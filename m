Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVCFBCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVCFBCY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 20:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVCFBCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 20:02:23 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:51359 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S261242AbVCFBCQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 20:02:16 -0500
Message-ID: <422A5697.2000905@cs.wisc.edu>
Date: Sat, 05 Mar 2005 17:02:15 -0800
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: open-iscsi@googlegroups.com
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       device-mapper development <dm-devel@redhat.com>
Subject: Re: [ANNOUNCE 0/6] Open-iSCSI High-Performance Initiator for Linux
References: <4229e34e.7e535078.5bc3.0b5eSMTPIN_ADDED@mx.googlegroups.com>
In-Reply-To: <4229e34e.7e535078.5bc3.0b5eSMTPIN_ADDED@mx.googlegroups.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Aizman wrote:
> This is to announce Open-iSCSI project: High-Performance iSCSI Initiator for
> Linux.
> 
> MOTIVATION
> ==========
> 
> Our initial motivations for the project were: (1) implement the right
> user/kernel split, and (2) design iSCSI data path for performance. Recently
> we added (3): get accepted into the mainline kernel.
>  
> As far as user/kernel, the existing iSCSI initiators bloat the kernel with
> ever-growing control plane code, including but not limited to: iSCSI
> discovery, Login (Authentication and Operational), session and connection
> management,

For iscsi-sfnet, I know it does login and auth and session and connection
management/recovery in kernel becuase nobody has been able to write a usersapce
daemon that can survive memory allocation failures and being paged out - are
there other problems when dealing with usersapce like this. Open-iscsi seems
to suffer from those problems too, but they seem like they can be fixed relatively
quickly. Do you know how long it will take? Is it still two months with some of
the items I descibed on the open-iscsi list in mind and after looking at what dm
multipath has had to do to perform failback and path checking?

As you know I agree it should be done in usersapce so please spare me the usual
advertisements and magic I normally get ;) I do not need to be sold on the
concept. I am just trying to get a better picture of if people will merge the
kernel part with a unreliable userspace component. If so then many sourceforge
devs can help test as there is no point in target vendors on that list
fixing the same bugs on multiple stacks like I have been doing (almost had
Pyx fixed with IBM DS300 too).

If the problems of doing recovery/login/auth in usersapce are solved and
well known should dm multipath move its failover to usersapce too? Doing
explicit failover is essentialy the same problem and there is no point in
sticking in a kernel interface for dm hw handlers when it can be done in
usersapce. I mention this becuase of the MCS embargo, and the fact the
I cannot imagine many storage admins running iSCSI without some sort
of multipath or failover so I would like to get that ironed out too.
