Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWAWJfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWAWJfU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 04:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWAWJfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 04:35:20 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:23076 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932136AbWAWJfS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 04:35:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TmoD+QlmKn56sKmUyzMj0X+HpRGz5hGx/UEhhL3ZDuPdPXw3dtztoYHXbieBiinWwYi8N0+18dWqYb+YV0y2/8Au1QQOTWMj8WQ8JkF32wGKnNoP1oVJEnzz8jhmgSzt+XuqpcB0tKDDLj1hrnFzzkHX78TU8BXpg0YGsFgOBaU=
Message-ID: <787b0d920601230128o5a12513fjae3708e3fb552dca@mail.gmail.com>
Date: Mon, 23 Jan 2006 04:28:33 -0500
From: Albert Cahalan <acahalan@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 4/4] pmap: reduced permissions
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, Al Viro <viro@ftp.linux.org.uk>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1137996654.2977.0.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601222219.k0MMJ3Qg209555@saturn.cs.uml.edu>
	 <1137996654.2977.0.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Sun, 2006-01-22 at 17:19 -0500, Albert D. Cahalan wrote:
> > This patch changes all 3 remaining maps files to be readable
> > only for the file owner. There have been privacy concerns.
> >
> > Fedora Core 4 has been shipping with such permissions on
> > the /proc/*/maps file already. General system monitoring
> > tools seldom use these files.
>
> changing /maps to 0400 breaks glibc; there are cases where this would
> lead to /proc/self/maps to be not readable (setuid like apps) so this
> needs a more elaborate fix.

Wow. Well, that's why I put the patch last in the series.
The other 3 don't depend on it at all.

I tend to think that glibc should not be reading this file.
What excuse is there?

In any case, the many existing statically linked executables
do cause trouble. Setuid apps are the ones you'd most want
to protect. Allowing them to read their own files can cause
plenty of trouble; perhaps you remember the XFree86 config
file bug that exposed the content of files that were not meant
to be readable.

On the other hand, these apps are the ones you'd most want
to recompile with modern tools. (PIE executable, stack canary,
no-execute stack flag, etc.)

I'm actually surprised that processes don't always get to read
their own files. If somebody hacks this up, be sure to base it
on the tgid. (or, better, on the struct mm)
