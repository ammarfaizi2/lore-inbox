Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbWAWJlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWAWJlx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 04:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWAWJlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 04:41:53 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45216 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932419AbWAWJlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 04:41:52 -0500
Subject: Re: [PATCH 4/4] pmap: reduced permissions
From: Arjan van de Ven <arjan@infradead.org>
To: Albert Cahalan <acahalan@gmail.com>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, Al Viro <viro@ftp.linux.org.uk>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <787b0d920601230128o5a12513fjae3708e3fb552dca@mail.gmail.com>
References: <200601222219.k0MMJ3Qg209555@saturn.cs.uml.edu>
	 <1137996654.2977.0.camel@laptopd505.fenrus.org>
	 <787b0d920601230128o5a12513fjae3708e3fb552dca@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 23 Jan 2006 10:41:45 +0100
Message-Id: <1138009305.2977.28.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-23 at 04:28 -0500, Albert Cahalan wrote:
> On 1/23/06, Arjan van de Ven <arjan@infradead.org> wrote:
> > On Sun, 2006-01-22 at 17:19 -0500, Albert D. Cahalan wrote:
> > > This patch changes all 3 remaining maps files to be readable
> > > only for the file owner. There have been privacy concerns.
> > >
> > > Fedora Core 4 has been shipping with such permissions on
> > > the /proc/*/maps file already. General system monitoring
> > > tools seldom use these files.
> >
> > changing /maps to 0400 breaks glibc; there are cases where this would
> > lead to /proc/self/maps to be not readable (setuid like apps) so this
> > needs a more elaborate fix.
> 
> Wow. Well, that's why I put the patch last in the series.
> The other 3 don't depend on it at all.
> 
> I tend to think that glibc should not be reading this file.
> What excuse is there?

glibc needs to be able to find out if a certain address is writable. (eg
mapped "w"). The only way available for that is... reading the maps
file.


> In any case, the many existing statically linked executables
> do cause trouble. Setuid apps are the ones you'd most want
> to protect.

for this 0400 isn't enough; because you can open this file, send the fd
over a unix socket, and then exec. The process you sent the fd to can
then read the setuid's program maps file. 

This thing is all a bit more complex than just the file mode ;(

