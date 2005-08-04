Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262651AbVHDUCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbVHDUCo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 16:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbVHDUCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 16:02:44 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:33889 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262651AbVHDUCn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 16:02:43 -0400
Date: Thu, 4 Aug 2005 22:02:45 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Christopher Friesen <cfriesen@nortel.com>
Cc: Roland Dreier <rolandd@cisco.com>, Arjan van de Ven <arjan@infradead.org>,
       openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Move InfiniBand .h files
Message-ID: <20050804200245.GA4622@mars.ravnborg.org>
References: <52iryla9r5.fsf@cisco.com> <1123178038.3318.40.camel@laptopd505.fenrus.org> <52acjxa70j.fsf@cisco.com> <1123180717.3318.43.camel@laptopd505.fenrus.org> <52wtn18r7w.fsf@cisco.com> <20050804192229.GA26714@mars.ravnborg.org> <42F27290.2070002@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F27290.2070002@nortel.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 01:54:56PM -0600, Christopher Friesen wrote:
> Sam Ravnborg wrote:
> >On Thu, Aug 04, 2005 at 11:57:55AM -0700, Roland Dreier wrote:
> 
> >>Sorry, I was too terse about the problem.  You're right, but typical
> >>distros don't ship full kernel source in their "support kernel builds"
> >>package.  And if I use an external build directory (ie "O=") then
> >>the symlink just points to my external build directory, which doesn't
> >>include the source to drivers/, just links to include/
> >
> >
> >If the external module uses a Kbuild file as explained in
> >Documentation/kbuild/makefiles.txt and then uses both O= and M=
> >when compiling the module there is no issue.
> >
> >With respect to moving the .h files - please do so.
> >drivers/infiniband should only include header used in that same
> >directory. Not header files potentially uased by fs/.
> 
> I think Roland was talking about the case where the running kernel was 
> built with "O=", in which case the /lib/modules.../build symlink points 
> to the build directory rather than the original source tree.
> 
> Does Kbuild handle this case properly?

Yes it does.
/lib/modules/.../ contains two symlinks these days:

build -> always point to the directory containing the output of the build
source -> always point to the kernel source

In the 'make' case where the kernel is built without using O= they point
to the same directory.
In the 'make O=' case they point to different directories.

SUSE does ship with a make O= build kernel these days.
Fedora IIRC has done an ugly hack and just copied over a number of files
so a compile works in most cases - but then also use both symlink.

It has never been easier to build a module if the target is only the
running kernel. Only when you adds backwards compatibility it gets messy :-(

	Sam
