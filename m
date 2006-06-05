Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750990AbWFELpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWFELpW (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 07:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbWFELpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 07:45:22 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:27520 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750990AbWFELpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 07:45:22 -0400
Date: Mon, 5 Jun 2006 20:46:36 +0900
From: "Akiyama, Nobuyuki" <akiyama.nobuyuk@jp.fujitsu.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Preben.Trarup@ericsson.com, fastboot@lists.osdl.org,
        linux-kernel@vger.kernel.org, vgoyal@in.ibm.com
Subject: Re: [Fastboot] [RFC][PATCH] Add missing notifier before crashing
Message-Id: <20060605204636.3d50fd59.akiyama.nobuyuk@jp.fujitsu.com>
In-Reply-To: <m1fyin6agv.fsf@ebiederm.dsl.xmission.com>
References: <20060530183359.a8d5d736.akiyama.nobuyuk@jp.fujitsu.com>
	<20060530145658.GC6536@in.ibm.com>
	<20060531182045.9db2fac9.akiyama.nobuyuk@jp.fujitsu.com>
	<20060531154322.GA8475@in.ibm.com>
	<20060601213730.dc9f1ec4.akiyama.nobuyuk@jp.fujitsu.com>
	<20060601151605.GA7380@in.ibm.com>
	<20060602141301.cdecf0e1.akiyama.nobuyuk@jp.fujitsu.com>
	<44800E1A.1080306@ericsson.com>
	<m1fyin6agv.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Jun 2006 05:52:32 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> Preben Traerup <Preben.Trarup@ericsson.com> writes:
> 
> > Since I'm one of the people who very much would like best of both worlds,
> > I do belive Vivek Goyal's concern about the reliability of kdump must be
> > adressed properly.
> >
> > I do belive the crash notifier should at least be a list of its own.
> >   Attaching element to the list proves your are kdump aware - in theory
> >
> > However:
> >
> > Conceptually I do not like the princip of implementing crash notifier
> > as a list simply because for all (our) practical usage there will only
> > be one element attached to the list anyway.
> >
> > And as I belive crash notifiers only will be used by a very limited
> > number of users, I suggested in another mail that a simple
> >
> > if (function pointer)
> >    call functon
> >
> > approach to be used for this special case to keep things very simple.
> 
> I am completely against crash notifiers.  The code crash_kexec switches to
> is what is notified and it can do whatever it likes.  The premise is
> that the kernel does not work.  Therefore  we cannot safely notify
> kernel code.  We do the very minimal to get out of the kernel,
> and it is my opinion we still do to much.
> 
> The crash_kexec entry point is not about taking crash dumps.  It is
> about implementing policy when the kernel panics.  Generally the
> policy we want is a crash dump but the mechanism is general purpose
> and not limited to that.

I understand it is more reliable that the notifier is executed
by crash_kexec(). But I guess it take longer time than a clustering
system demand and it is more complex to implement the notifier.
The crash notifier I proposed is very simple and lightweight,
and it is easy to use for all people.

Regards,

Akiyama, Nobuyuki

