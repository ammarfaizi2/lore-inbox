Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277109AbRJDETJ>; Thu, 4 Oct 2001 00:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277107AbRJDES7>; Thu, 4 Oct 2001 00:18:59 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:17903 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S277109AbRJDESt>;
	Thu, 4 Oct 2001 00:18:49 -0400
Date: Thu, 4 Oct 2001 00:19:13 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: landley@trommello.org, drepper@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Security question: "Text file busy" overwriting executables but
 not shared libraries?
In-Reply-To: <m1itdw13dj.fsf@frodo.biederman.org>
Message-ID: <Pine.GSO.4.21.0110040004430.26177-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 3 Oct 2001, Eric W. Biederman quoted:

> > >/* The right way to map in the shared library files is MAP_COPY, which
> > >   makes a virtual copy of the data at the time of the mmap call; this
> > >   guarantees the mapped pages will be consistent even if the file is
> > >   overwritten.  Some losing VM systems like Linux's lack MAP_COPY.  All we
> > >   get is MAP_PRIVATE, which copies each page when it is modified; this
> > >   means if the file is overwritten, we may at some point get some pages
> > >   from the new version after starting with pages from the old version.  */

IMO it needs a slight correction.

+ /* Unfortunately, that is not an option, since losing bloatware like GNU's
+    relies heavily on equally bloated shared libraries and use of MAP_COPY
+    would eat memory with no mercy.  OTOH, implementing it might be a good
+    idea, since results would force people to switch to something less obese */

