Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWEMLiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWEMLiW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 07:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWEMLiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 07:38:22 -0400
Received: from cantor2.suse.de ([195.135.220.15]:10898 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932386AbWEMLiV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 07:38:21 -0400
From: Neil Brown <neilb@suse.de>
To: Stefan Smietanowski <stesmi@stesmi.com>
Date: Sat, 13 May 2006 21:37:45 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17509.50441.790871.230011@cse.unsw.edu.au>
Cc: Douglas McNaught <doug@mcnaught.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Mark Rosenstand <mark@borkware.net>, linux-kernel@vger.kernel.org
Subject: Re: Executable shell scripts
In-Reply-To: message from Stefan Smietanowski on Saturday May 13
References: <20060513103841.B6683146AF@hunin.borkware.net>
	<1147517786.3217.0.camel@laptopd505.fenrus.org>
	<20060513110324.10A38146AF@hunin.borkware.net>
	<1147518432.3217.2.camel@laptopd505.fenrus.org>
	<87r72yi346.fsf@suzuka.mcnaught.org>
	<4465C2E8.8070106@stesmi.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday May 13, stesmi@stesmi.com wrote:
> > 
> > Every Unix I've ever seen works this way.  It'd be nice to have
> > unreadable executable scripts, but no one's ever done it.
> 
> The solution would be to either stick bash in the kernel (YUCK!)
> or to have the kernel basically copy the read-only script to /tmp
> or somewhere else, set permissions to sane values and
> /bin/sh /tmp/foo.a12345.

... or open the script file (which there kernel has to do anyway),
attach it to some unused fd (e.g. fd3) and pass  "/dev/fd/3" to the
interpreter rather than "/the/shell/script".

Then the interpreter doesn't need to be able to open the file for
read.

However it isn't clear that this is really a gain, as the person
running the script could use ptrace or similar to take a copy of the
script, the bypassing the missing 'r' permission.

Mind you, with ptrace, it isn't too hard to get a copy of a normal
executable that is mode '111'....

The whole concept of having files that are executable but not readable
is completely broken - it gives the appearance of protection without
the reality.

NeilBrown
