Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbULARFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbULARFo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 12:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbULARFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 12:05:44 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:51102 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261304AbULARFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 12:05:41 -0500
Subject: Re: cd burning, capabilities and available modes
From: Lee Revell <rlrevell@joe-job.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1101908433l.8423l.0l@werewolf.able.es>
References: <1101908433l.8423l.0l@werewolf.able.es>
Content-Type: text/plain
Date: Wed, 01 Dec 2004 12:05:38 -0500
Message-Id: <1101920739.18170.29.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-01 at 13:40 +0000, J.A. Magallon wrote:
> As user:
> werewolf:/store/tmp> cdrecord -dummy dev=ATAPI:1,0,0 *.iso
> ...
> cdrecord: Cannot allocate memory. WARNING: Cannot do mlockall(2).
> cdrecord: WARNING: This causes a high risk for buffer underruns.
> cdrecord: Operation not permitted. WARNING: Cannot set RR-scheduler
> cdrecord: Permission denied. WARNING: Cannot set priority using setpriority().
> cdrecord: WARNING: This causes a high risk for buffer underruns.

You can use the realtime LSM (see list archives) to let specific groups
of users use mlockall and run RT tasks.  Just load it like:

modprobe realtime gid=29

and make gid 29 your "cdrecord" group.

This should make CD burning as joeuser reliable as root.  Most people
use this for low latency audio but I think cd burning is a wider and
completely unexplored application.

Lee

