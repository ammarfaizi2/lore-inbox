Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311729AbSCTQBp>; Wed, 20 Mar 2002 11:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311725AbSCTQBe>; Wed, 20 Mar 2002 11:01:34 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51249 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S311721AbSCTQBM>; Wed, 20 Mar 2002 11:01:12 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: extending callbacks?
In-Reply-To: <Pine.GSO.4.44.0203191111320.20995-100000@speedy>
	<a78gd7$jk$1@cesium.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Mar 2002 08:55:08 -0700
Message-ID: <m1d6xzw7xf.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Followup to:  <Pine.GSO.4.44.0203191111320.20995-100000@speedy>
> By author:    Matthias Scheidegger <mscheid@iam.unibe.ch>
> In newsgroup: linux.dev.kernel
> > 
> > I've got the following problem: I want to register a callback in a kernel
> > structure, but I need to supply an additional argument to my own code. I.e. I
> > need a callback
> > 
> > int (*cb)(int u)
> > 
> > to really call
> > 
> > int (*real_cb)(int u, void* my_arg)
> > 
> > At the moment, I'm only focussing on the i386 architecture.
> > In user space, I'd do this by generating some machine code, which takes the
> > original args, pushes my_fixed_arg and calls real_cb (using mprotect to make
> > the generated code callable). That way I'd use a function
> > 
> > int (*)(int) create_callback(int (*real_cb)(int, void*), void *arg);
> > 
> > Is there a good way to do that in the kernel?
> > Not necessarily using self modifying code, I'll only use it if I must.
> > 
> 
> In general, it's impossible.  On a lot of architectures, it happens to
> "just work" with the appropriate cast, but that's completely dependent
> on the ABI.
> 
> The extra arguemnt, of course, contains garbage.

???

static void *my_fixed_arg;
int temp_cb(int u)
{
        return real_cb(u, my_fixed_arg);
}

Generally works.  The variant that builds that code on the fly for
create_callback is a little more interesting of course.


Eric



