Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbTFIVEx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 17:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbTFIVEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 17:04:53 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:47760 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S262030AbTFIVEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 17:04:51 -0400
Date: Mon, 9 Jun 2003 22:18:23 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Dan Carpenter <dcarpenter@penguincomputing.com>
Cc: linux-kernel@vger.kernel.org, ppokorny@penguincomputing.com
Subject: Re: memtest86 on the opteron
Message-ID: <20030609211823.GA2182@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Dan Carpenter <dcarpenter@penguincomputing.com>,
	linux-kernel@vger.kernel.org, ppokorny@penguincomputing.com
References: <Pine.LNX.4.33.0306091320500.2640-100000@ddcarpen1.penguincompting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0306091320500.2640-100000@ddcarpen1.penguincompting.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 09, 2003 at 01:26:37PM -0700, Dan Carpenter wrote:
 > --- init.c.orig	Mon Jun  9 10:23:10 2003
 > +++ init.c	Mon Jun  9 10:25:44 2003
 > @@ -402,6 +402,16 @@
 >  			}
 >  			l1_cache = cpu_id.cache_info[3];
 >  			l1_cache += cpu_id.cache_info[7];
 > +                case 15:
 > +                        switch(cpu_id.model) {
 > +                        case 5:
 > +				cprint(LINE_CPU, 0, "AMD Opteron");
 > +				off = 11;
 > +				l1_cache = cpu_id.cache_info[3];
 > +				l1_cache += cpu_id.cache_info[7];
 > +				l2_cache = (cpu_id.cache_info[11] << 8);
 > +				l2_cache += cpu_id.cache_info[10];
 > +                        }
 >  		}

Any reason to restrict it to a single stepping ?
This means you have to upgrade memtest every time a new model
is released, which seems a bit of a pain.

Chances are it'll work fine on subsequent family 15 AMD CPUs.

		Dave

