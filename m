Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263133AbVBCVt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263133AbVBCVt4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 16:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263120AbVBCVtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 16:49:55 -0500
Received: from gizmo06bw.bigpond.com ([144.140.70.41]:26787 "HELO
	gizmo06bw.bigpond.com") by vger.kernel.org with SMTP
	id S263397AbVBCVs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 16:48:27 -0500
Message-ID: <42029C23.1000300@bigpond.net.au>
Date: Fri, 04 Feb 2005 08:48:19 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Davis <paul@linuxaudiosystems.com>
CC: "Bill Huey (hui)" <bhuey@lnxw.com>, Ingo Molnar <mingo@elte.hu>,
       "Jack O'Quin" <joq@io.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
References: <200502031420.j13EKwFx005545@localhost.localdomain>
In-Reply-To: <200502031420.j13EKwFx005545@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Davis wrote:
> 
> There are several kernel-side attributes that would make JACK better from
> my perspective:
> 
> 	* better ways to acquire and release RT scheduling

I'm no expert on the topic but it would seem to me that the mechanisms 
associated with the capable() function are intended to provide a 
consistent and extensible interface to the control of privileged 
operations with possible finer grained control than "root 'yes' and 
everybody else 'no'".  Maybe the way to solve this problem is to modify 
the interpretation of capable(CAP_SYS_NICE) so that it returns true when 
invoked by a task setuid to a nominated uid in addition to zero?

By default, this additional uid would be set to zero (i.e. not change to 
current capabilities) but a mechanism to allow a suitable privileged 
user to change it could be provided.  Programs which the sysadmin wishes 
to be allowed to acquire RT scheduling even when used by ordinary users 
could be setuid to this "RT user".  If the account for the "RT user" was 
properly configured (e.g. not allowed to log in, no home directory, 
etc.) then the damage that could be done by tasks run as setuid "RT 
user" would be limited.

Peter
PS Maybe SELinux already provides this functionality or something better?
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
