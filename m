Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262901AbVCWUTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbVCWUTV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 15:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262891AbVCWURR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 15:17:17 -0500
Received: from smtp-out.tiscali.no ([213.142.64.144]:23570 "EHLO
	smtp-out.tiscali.no") by vger.kernel.org with ESMTP id S262892AbVCWUQD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 15:16:03 -0500
Subject: Re: forkbombing Linux distributions
From: Natanael Copa <mlists@tanael.org>
To: aq <aquynh@gmail.com>
Cc: Paul Jackson <pj@engr.sgi.com>, Hikaru1@verizon.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <9cde8bff05032310442a4247f2@mail.gmail.com>
References: <e0716e9f05032019064c7b1cec@mail.gmail.com>
	 <Pine.LNX.4.61.0503221247450.5858@yvahk01.tjqt.qr>
	 <20050322124812.GB18256@roll> <20050322125025.GA9038@roll>
	 <9cde8bff050323025663637241@mail.gmail.com> <1111581459.27969.36.camel@nc>
	 <9cde8bff05032305044f55acf3@mail.gmail.com> <1111586058.27969.72.camel@nc>
	 <9cde8bff05032309056c9643a7@mail.gmail.com>
	 <20050323100543.04e582e9.pj@engr.sgi.com>
	 <9cde8bff05032310442a4247f2@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 23 Mar 2005 21:15:58 +0100
Message-Id: <1111608959.20101.11.camel@nc>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-24 at 03:44 +0900, aq wrote:
> On Wed, 23 Mar 2005 10:05:43 -0800, Paul Jackson <pj@engr.sgi.com> wrote:
> > > int main() { while(1) { fork(); fork(); exit(); } }
> > > ...
> > > the above forkbomb will stop quickly
> > 
> > Yep.
> > 
> > Try this forkbomb:
> > 
> >   int main() { while(1) { if (!fork()) continue; if (!fork()) continue; exit(); } }
> > 
> 
> yep, that is better. but system can still be recovered by killall. 
> 
> a little "sleep" will render the system completely useless, like this:
> 
> int main() { while(1) { if (!fork()) continue; if (!fork()) continue;
> sleep(5); exit(0); } }

Interesting.

With the patch I suggested earlier, reducing default max_threads to the
half in kernel/fork.c, my system survived. (without
touching /etc/security/limits.conf) Mail notification died because it
couldn't start any new threads but that was the only thing that
happened.

--
Natanael Copa


