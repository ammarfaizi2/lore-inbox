Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWEMWmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWEMWmx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 18:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWEMWmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 18:42:52 -0400
Received: from ns.suse.de ([195.135.220.2]:22403 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964786AbWEMWmw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 18:42:52 -0400
From: Neil Brown <neilb@suse.de>
To: Mark Rosenstand <mark@borkware.net>
Date: Sun, 14 May 2006 08:42:21 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17510.24781.295255.225387@cse.unsw.edu.au>
Cc: Theodore Tso <tytso@mit.edu>, doug@mcnaught.org, arjan@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: Executable shell scripts
In-Reply-To: message from Mark Rosenstand on Saturday May 13
References: <20060513103841.B6683146AF@hunin.borkware.net>
	<1147517786.3217.0.camel@laptopd505.fenrus.org>
	<20060513110324.10A38146AF@hunin.borkware.net>
	<1147518432.3217.2.camel@laptopd505.fenrus.org>
	<87r72yi346.fsf@suzuka.mcnaught.org>
	<20060513112754.1CA99146AF@hunin.borkware.net>
	<20060513125911.GA2871@thunk.org>
	<20060513131850.2E732146AF@hunin.borkware.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday May 13, mark@borkware.net wrote:
> 
> Anyhow, I don't really mind the 111 mode, the point was to show shell
> scripts being treated as executables. What I do want this feature for
> is the "more useful case" that somehow got stripped off in the replies,
> namely setuid and setgid scripts.
> -

setXid scripts are trivially exploitable unless the "/dev/fd/X"
approach is used to pass the file to the interpreter.

A classic approach is

 ln -s /bin/setuid-script ~/bin/-i
 -i

This will run the interpreter with a first argument of
   -i
which (if it is the shell) will just run an interactive shell for
you!!!
Now several shells have hacks to try to detect that case and reject it,
but there are other approaches..

Create a symlink to the script, and just at the right time between the
interpreter starting setuid and the interpreter opening the script,
you redirect the symlink somewhere else.  You might have to try a few
times to win the race, but it is sure to be possible.

Again, several shells have hacks in place to detect and avoid that
condition. 

But it has turned into an arms race - Can you be sure that the
interpreter you are using correctly detects and avoids all possible
subversion attempts?  It seems unlikely.

It is much safer to have a compiled program be the setuid bit, and it
does appropriate checks and runs a script in a highly controlled
manner.  I have a program called 'priv' which runs scripts out of
/usr/local/priv  after doing some access checks listed at the top of
the script.  It makes it quite easy and fairly safe (you still need to
check all command line args carefully) to write setuid-root script.

NeilBrown
