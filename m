Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVA2VYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVA2VYf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 16:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVA2VYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 16:24:35 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:46137 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261568AbVA2VYc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 16:24:32 -0500
Date: Sat, 29 Jan 2005 22:26:02 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: kbuild: Implicit dependence on the C compiler
Message-ID: <20050129212602.GA9610@mars.ravnborg.org>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <cshbd7$nff$1@terminus.zytor.com> <20050117220052.GB18293@mars.ravnborg.org> <41EC363D.1090106@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EC363D.1090106@zytor.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 02:03:41PM -0800, H. Peter Anvin wrote:
> >There is no way to tell kbuild "ignore gcc change"
> 
> There really needs to be one.

make KBUILD_NOCMDDEP=1
will do what you want - at least I have it in my tree now.
I could not just ignore 'gcc' - but had to ignore the full commandline.

This is due to more complex commands like:
rm -f file; $(LD) ...

Within the Makefile.lib when I check KBUILD_NOCMDDEP there is no
knowledge of the actual command being executed. And an implmentation
that just filtered out $(CC) was too ugly.
And due to the above mentioned command I could not just skip the first
word on the command line.


I will push my bk tree soon and it will show up in next -mm.

It is not perfect in the sense that the last part of the build will get
redone (GEN .version and onwards). This is fixable but not worth it
right now.

So with current implmentation executing:

make

make KBUILD_NOCMDDEP=1 CROSS_COMPILE=i586-pc-linux-gnu-

will result in only a few files being rebuild - and not the whole
kernel as before.

	Sam
