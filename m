Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbWFPXrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbWFPXrz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 19:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbWFPXrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 19:47:55 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:53183 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932477AbWFPXry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 19:47:54 -0400
Date: Sat, 17 Jun 2006 08:47:48 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: clameter@sgi.com, linux-kernel@vger.kernel.org, ashok.raj@intel.com,
       ak@suse.de
Subject: Re: [RFC][PATCH] avoid cpu hot remove of cpus which have special RT
 tasks.
Message-Id: <20060617084748.a4c68977.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060616102934.A2940@unix-os.sc.intel.com>
References: <20060616162343.02c3ce62.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0606160908120.14330@schroedinger.engr.sgi.com>
	<20060617014623.8f820e8b.kamezawa.hiroyu@jp.fujitsu.com>
	<20060616102934.A2940@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2006 10:29:35 -0700
Ashok Raj <ashok.raj@intel.com> wrote:
> Should we have this flag on a per-task so we know if this task should be 
> killed, or could be migrated without damage (assuming its going to run slow, 
> but nothing critically bad will happen)
> 
> Iam just worried if killing them globally without giving them a chance is 
> any good and favorite apps such as databases will have probably have
> ill effects.
> 
In the big servers which equips cpu-hotplug, apps should work as they designed.
If not, apps are already in buggy state.
IMHO, just stopping it is better than allowing execution in buggy state.

I used SIGSTOP. If a system admin or SIGCONT handler can modify cpu_allowed of
stopped thread, apps can go on. I think this is a realistic workaround.
(if the process is stopped, parent process of it can catch it by waitpid.)

p.s.
I think prefer cpu + allowed cpu will help this kind of probem, but there is no
interface..

-Kame

