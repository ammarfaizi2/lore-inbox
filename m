Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135395AbRD0OOM>; Fri, 27 Apr 2001 10:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136036AbRD0OOC>; Fri, 27 Apr 2001 10:14:02 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:4100 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S135395AbRD0ONu>;
	Fri, 27 Apr 2001 10:13:50 -0400
Message-ID: <20010426221049.E803@bug.ucw.cz>
Date: Thu, 26 Apr 2001 22:10:49 +0200
From: Pavel Machek <pavel@suse.cz>
To: ebuddington@wesleyan.edu, linux-kernel@vger.kernel.org
Subject: Re: capabilities carried over execve()
In-Reply-To: <20010424104518.J18326@sparrow.nad.adelphia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010424104518.J18326@sparrow.nad.adelphia.net>; from Eric Buddington on Tue, Apr 24, 2001 at 10:45:18AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I am attempting to write an init replacement that is capability-smart.
> Though I'm pleased that prctl() lets me keep capabilities across a
> setreuid(), maintaining caps over execve() seems impossible to do right.
> 
> I currently see a few options:
> 	- use the CLOEXEC-pipe hack that execcap uses (parent notices
> 	  when pipe closes then rushes to set caps on child before
> 	  child notices they're gone). This looks like a race to me.
> 	- tweak linux/fs/exec.c (prepare_binprm) to pretend that all
> 	  files have cap_inheritable and cap_effective fully set.
> 	  This seems a more elegant solution, but requires a kernel
> 	  patch.
> 	- exec the child in a stopped state, mess with caps, then
> 	  send it SIGCONT. AFAIK, there is no way to do
> 	  execve_and_stop.

What about ptrace? It should be able to do this kind of stuff... but
it is going to be messy.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
