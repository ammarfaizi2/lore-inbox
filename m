Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279317AbRKIFkL>; Fri, 9 Nov 2001 00:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279370AbRKIFkC>; Fri, 9 Nov 2001 00:40:02 -0500
Received: from zero.tech9.net ([209.61.188.187]:4625 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S279317AbRKIFjy>;
	Fri, 9 Nov 2001 00:39:54 -0500
Subject: Re: Modutils can't handle long kernel names
From: Robert Love <rml@tech9.net>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011108212328.B514@mikef-linux.matchmail.com>
In-Reply-To: <20011108204210.A514@mikef-linux.matchmail.com> 
	<20011108212328.B514@mikef-linux.matchmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.07.16.47 (Preview Release)
Date: 09 Nov 2001 00:40:12 -0500
Message-Id: <1005284413.1209.2.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-11-09 at 00:23, Mike Fedyk wrote:
> I've gotten into the habbit of adding the names of the patches I add to my
> kernel to the extraversion string in the top level Makefile in my kernels.

Everything in-kernel is going to be OK because we set the version string
like so:

	char version[] = UTS_RELEASE;

where UTS_RELEASE is set from the variables in your Makefile.  Thus, the
string is set to the exact size of your version on compile.  If you find
anywhere _inside the kernel_ that breaks with long strings, it is
probably a bug.

Userspace is a different story.  In general, most programs probably do
not have dynamic off-the-heap storage for the version string size. 
Added such a feature may be advantageous in some cases, but in many it
is overkill and not worth the dynamic memory management.

I would consider the case where a large string crashes a user space
program a bug.  While the program may choose to set some limit, it
should certainly check its buffers.  I would also consider an abnormally
small legal string size a bug, but I honestly don't see your version
size fitting that description. :)

Anyhow, if you want to change it in a given app, its a simple size that
needs to be changed and then recompile.

	Robert Love

