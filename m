Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291970AbSBNXco>; Thu, 14 Feb 2002 18:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291971AbSBNXcf>; Thu, 14 Feb 2002 18:32:35 -0500
Received: from zeus.kernel.org ([204.152.189.113]:20618 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S291970AbSBNXcT>;
	Thu, 14 Feb 2002 18:32:19 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Henrik Nordstrom <hno@marasystems.com>
Organization: MARA Systems AB
Message-Id: <200202150006.35881@henrik.marasystems.com>
To: Chris Chabot <chabotc@reviewboard.com>,
        Nick Craig-Wood <ncw@axis.demon.co.uk>
Subject: Re: 2.4.18-pre9: iptables screwed?
Date: Fri, 15 Feb 2002 00:11:25 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Harald Welte <laforge@gnumonks.org>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, netfilter-devel@lists.samba.org
In-Reply-To: <a3vjts$r7l$1@cesium.transmeta.com> <20020214161225.A2867@axis.demon.co.uk> <3C6C0977.7030004@reviewboard.com>
In-Reply-To: <3C6C0977.7030004@reviewboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This topic has been discussed on netfilter-devel quite recently.

The RedHat RPM for some reason compiles the iptables package with 
debugging enabled. This makes the program overly paranoid about 
different revisions of the netfilter kernel components.

Details:

When you build iptables from the source tarball then the Makefile 
includes -DNDEBUG to disable all debugging. Unfortunately the RPM 
build process overrides the compilation options set in the Makefile 
and leaves NDEBUG undefined, causing a lot of debug code to be 
compiled in.

Regards
Henrik Nordström



On Thursday 14 February 2002 20.01, Chris Chabot wrote:
> I ran into the same problems with 2.4.18pre9, however upgrading to
> iptables 1.2.5 fixed the problem. (there's no redhat packages for
> it yet, i did a compile of the source pkg)
>
> 	-- Chris
>
> Nick Craig-Wood wrote:
> > On Fri, Feb 08, 2002 at 09:46:49AM +0100, Harald Welte wrote:
> >>On Thu, Feb 07, 2002 at 08:24:28PM -0800, H. Peter Anvin wrote:
> >>>I get the following error with iptables on 2.4.18-pre9:
> >>>
> >>>sudo iptables-restore < /etc/sysconfig/iptables
> >>>iptables-restore: libiptc/libip4tc.c:384: do_check: Assertion
> >>>`h->info.valid_hooks == (1 << 0 | 1 << 3)' failed.
> >>>Abort (core dumped)
> >
> > I've noticed this too.
> >
> > Specifically it is fine with 2.4.17 but broken with
> > 2.4.18-pre7-ac2
> >
> > I use the mangle table to set the TOS for a few things but it
> > gives this error :-
> >
> >   iptables -t mangle -A add-tos -p tcp --dport ssh -m tos --tos
> > Minimize-Delay
> >
> >   iptables: libiptc/libip4tc.c:384: do_check: Assertion
> > `h->info.valid_hooks == (1 << 0 | 1 << 3)' failed.
> >
> >>Could you please tell me, what iptables version are you using?
> >>(btw: please follow-up to netfilter-devel@lists.samba.org)
> >
> > This is using Redhat 7.2 iptables v1.2.4 from the redhat package
> > iptables-1.2.4-2.
> >
> > Apologies if this info is too late but I didn't see a followup to
> > lkml.
