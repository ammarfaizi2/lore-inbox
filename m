Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135654AbRDXOpj>; Tue, 24 Apr 2001 10:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135657AbRDXOpa>; Tue, 24 Apr 2001 10:45:30 -0400
Received: from ma-northadams1-47.nad.adelphia.net ([24.51.236.47]:64008 "EHLO
	sparrow.net") by vger.kernel.org with ESMTP id <S135654AbRDXOpU>;
	Tue, 24 Apr 2001 10:45:20 -0400
Date: Tue, 24 Apr 2001 10:45:18 -0400
From: Eric Buddington <eric@sparrow.nad.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: capabilities carried over execve()
Message-ID: <20010424104518.J18326@sparrow.nad.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am attempting to write an init replacement that is capability-smart.
Though I'm pleased that prctl() lets me keep capabilities across a
setreuid(), maintaining caps over execve() seems impossible to do right.

I currently see a few options:
	- use the CLOEXEC-pipe hack that execcap uses (parent notices
	  when pipe closes then rushes to set caps on child before
	  child notices they're gone). This looks like a race to me.
	- tweak linux/fs/exec.c (prepare_binprm) to pretend that all
	  files have cap_inheritable and cap_effective fully set.
	  This seems a more elegant solution, but requires a kernel
	  patch.
	- exec the child in a stopped state, mess with caps, then
	  send it SIGCONT. AFAIK, there is no way to do
	  execve_and_stop.

Is there a better solution available, or one in the works?
I think capabilites may be a key to achieving Pretty Good (tm) security
- but then again, so is running bind as non-root, and nobody even
bothers to do that...

-Eric
