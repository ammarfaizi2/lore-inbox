Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264916AbUAFSKn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 13:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUAFSKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 13:10:43 -0500
Received: from dsl-hkigw4g29.dial.inet.fi ([80.222.54.41]:10886 "EHLO
	dsl-hkigw4g29.dial.inet.fi") by vger.kernel.org with ESMTP
	id S264916AbUAFSKl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 13:10:41 -0500
Date: Tue, 6 Jan 2004 20:10:39 +0200 (EET)
From: Petri Koistinen <petri.koistinen@iki.fi>
X-X-Sender: petri@dsl-hkigw4g29.dial.inet.fi
To: "Zhu, Yi" <yi.zhu@intel.com>
Cc: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [Bugfix] Set more than 32K pid_max (reformatted)
In-Reply-To: <fa.ler12im.1q0qip6@ifi.uio.no>
Message-ID: <Pine.LNX.4.58.0401062006020.7307@dsl-hkigw4g29.dial.inet.fi>
References: <fa.pigdtgt.1qkefhl@ifi.uio.no> <fa.ler12im.1q0qip6@ifi.uio.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue, 6 Jan 2004, Zhu, Yi wrote:

> On Tue, 6 Jan 2004, Marcos D. Marado Torres wrote:
>
> > >         if (!offset || !atomic_read(&map->nr_free))=
>  {
> > > +               if (!offser)
> >
> > I suppose it should be "if (!offset)"...
>
> Yes, my mistake. Thanks!

Nope, my fault. Here it goes one more time, hopefully right.

Petri

--- linux-2.6/kernel/pid.c.orig 2004-01-05 17:54:46.000000000 +0200
+++ linux-2.6/kernel/pid.c      2004-01-05 17:55:35.000000000 +0200
@@ -122,6 +122,8 @@
        }

        if (!offset || !atomic_read(&map->nr_free)) {
+               if (!offset)
+                       map--;
 next_map:
                map = next_free_map(map, &max_steps);
                if (!map)

