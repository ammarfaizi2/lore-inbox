Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290592AbSBSWGQ>; Tue, 19 Feb 2002 17:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290593AbSBSWF4>; Tue, 19 Feb 2002 17:05:56 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:45062 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S290592AbSBSWFx>;
	Tue, 19 Feb 2002 17:05:53 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: David Mosberger <davidm@hpl.hp.com>, Dan Maas <dmaas@dcine.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ben Collins <bcollins@debian.org>
Subject: Re: readl/writel and memory barriers 
In-Reply-To: Your message of "Tue, 19 Feb 2002 10:35:06 -0800."
             <20020219103506.A1511175@sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 20 Feb 2002 09:05:37 +1100
Message-ID: <13997.1014156337@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2002 10:35:06 -0800, 
Jesse Barnes <jbarnes@sgi.com> wrote:
>Making a variable volatile doesn't guarantee that the compiler won't
>reorder references to it, AFAIK.  And on some platforms, even uncached
>I/O references aren't necessarily ordered.

Ignoring the issue of hardware that reorders I/O, volatile accesses
must not be reordered by the compiler.  From a C9X draft (1999, anybody
have the current C standard online?) :-

  5.1.2.3 [#2]

  Accessing  a volatile object, modifying an object, modifying a file,
  or calling a function that does any of those operations are all side
  effects which are changes in the state of the execution environment.
  Evaluation of an expression may produce side effects.  At certain
  specified points in the execution sequence called sequence points,
  all side effects of previous evaluations shall be complete and no
  side effects of subsequent evaluations shall have taken place.

  5.1.2.3 [#6]

  The least requirements on a conforming implementation are:

    -- At sequence points, volatile objects are stable in the sense
       that previous accesses are complete and subsequent accesses have
       not yet occurred.

The compiler may not reorder volatile accesses across sequence points.

volatile int *a, *b;
int c;

c = *a + *b;	// no sequence point, access order to a, b is undefined

c = *a;		// compiler must not convert to the above format, it
c += *b;	// must access a then b


