Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbTHTRRZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 13:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbTHTRRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 13:17:25 -0400
Received: from havoc.gtf.org ([63.247.75.124]:10369 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262091AbTHTRRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 13:17:16 -0400
Date: Wed, 20 Aug 2003 13:17:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: M?ns Rullg?rd <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to turn off, or to clear read cache?
Message-ID: <20030820171713.GA21822@gtf.org>
References: <200308201322.h7KDMQga000797@81-2-122-30.bradfords.org.uk> <3F437646.4050107@gamic.com> <yw1x8ypocv63.fsf@users.sourceforge.net> <20030820164949.GA5613@lsd.di.uminho.pt> <yw1xptj0b72s.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1xptj0b72s.fsf@users.sourceforge.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 20, 2003 at 06:57:15PM +0200, M?ns Rullg?rd wrote:
> Luciano Miguel Ferreira Rocha <luciano@lsd.di.uminho.pt> writes:
> > Will it clear the cache?
> 
> It will probably clear some cache to make room for cache from hda.
> 
> perl -e '@f[0..100000000]=0'
> 
> will do it faster.

Using fillmem will do it better :)

	Jeff




/* fillmem.c usage: "fillmem <number-of-megabytes>" */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

#define MEGS 140	/* default; override on command line */
#define MEG (1024 * 1024)

int main (int argc, char *argv[])
{
	void **data;
	int i, r;
	size_t megs = MEGS;

	if ((argc >= 2) && (atoi(argv[1]) > 0))
		megs = atoi(argv[1]);

	data = malloc (megs * sizeof (void*));
	if (!data) abort();

	memset (data, 0, megs * sizeof (void*));

	srand(time(NULL));

	for (i = 0; i < megs; i++) {
		data[i] = malloc(MEG);
		memset (data[i], i, MEG);
		printf("malloc/memset %03d/%03lu\n", i+1, megs);
	}
	for (i = megs - 1; i >= 0; i--) {
		r = rand() % 200;
		memset (data[i], r, MEG);
		printf("memset #2 %03d/%03lu = %d\n", i+1, megs, r);
	}
	printf("done\n");
	return 0;
}
