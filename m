Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262097AbVDRPSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbVDRPSJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 11:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbVDRPSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 11:18:09 -0400
Received: from fire.osdl.org ([65.172.181.4]:47592 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262097AbVDRPRy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 11:17:54 -0400
Date: Mon, 18 Apr 2005 08:17:26 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Igor Shmukler <igor.shmukler@gmail.com>
Cc: riel@redhat.com, thehazard@gmail.com, arjan@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: intercepting syscalls
Message-Id: <20050418081726.7d3125bd.rddunlap@osdl.org>
In-Reply-To: <6533c1c905041807487a872025@mail.gmail.com>
References: <6533c1c905041511041b846967@mail.gmail.com>
	<1113588694.6694.75.camel@laptopd505.fenrus.org>
	<6533c1c905041512411ec2a8db@mail.gmail.com>
	<e1e1d5f40504151251617def40@mail.gmail.com>
	<6533c1c905041512594bb7abb4@mail.gmail.com>
	<Pine.LNX.4.61.0504180752220.3232@chimarrao.boston.redhat.com>
	<6533c1c905041807487a872025@mail.gmail.com>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: SvC&!/v_Hr`MvpQ*|}uez16KH[#EmO2Tn~(r-y+&Jb}?Zhn}c:Eee&zq`cMb_[5`tT(22ms
 (.P84,bq_GBdk@Kgplnrbj;Y`9IF`Q4;Iys|#3\?*[:ixU(UR.7qJT665DxUP%K}kC0j5,UI+"y-Sw
 mn?l6JGvyI^f~2sSJ8vd7s[/CDY]apD`a;s1Wf)K[,.|-yOLmBl0<axLBACB5o^ZAs#&m?e""k/2vP
 E#eG?=1oJ6}suhI%5o#svQ(LvGa=r
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Apr 2005 10:48:03 -0400 Igor Shmukler wrote:

| Rik, (and everyone),
| 
| Everything is IMHO only.
| 
| It all boils down to whether:
| 1. it is hard to correctly implement such LKM so that it can be safely
| loaded and unloaded and when these modules are combined they may not
| work together until there is an interoperability workshop (like the
| one networking folks do).
| 2. it's not possible to do this right, hence no point to allow this in
| a first place.
| 
| I am not a Linux expert by a long-shot, but on many other Unices it's
| being done and works. I am only asking because I am involved with a
| Linux port.
| 
| I think if consensus is on choice one, then hiding the table is a
| mistake. We should not just close  abusable interfaces. Rootkits do
| not need these, and if someone makes poor software we do not have to
| install it.
| 
| Intercepting system call table is an elegant way to solve many
| problems. Any driver software has to be developed by expert
| programmers and can cause all the problems imaginable if it was not
| down right.
| 
| Again, it's all IMHO. Nobody has to agree.


And 'nobody' has submitted patches that handle all of the described
problems...

1.  racy
2.  architecture-independent
3.  stackable (implies/includes unstackable :)

You won't get very far in this discussion without some code...


| Igor
| 
| On 4/18/05, Rik van Riel <riel@redhat.com> wrote:
| > On Fri, 15 Apr 2005, Igor Shmukler wrote:
| > 
| > > Thank you very much. I will check this out.
| > > A thanks to everyone else who contributed. I would still love to know
| > > why this is a bad idea.
| > 
| > Because there is no safe way in which you could have multiple
| > of these modules loaded simultaneously - say one security
| > module and AFS.  There is an SMP race during the installing
| > of the hooks, and the modules can still wreak havoc if they
| > get unloaded in the wrong order...
| > 
| > There just isn't a good way to hook into the syscall table.


---
~Randy
