Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbTFKQKl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 12:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbTFKQKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 12:10:41 -0400
Received: from gateway.penguincomputing.com ([64.243.132.186]:32675 "EHLO
	inside.penguincomputing.com") by vger.kernel.org with ESMTP
	id S262256AbTFKQKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 12:10:39 -0400
Date: Wed, 11 Jun 2003 08:51:17 -0700 (PDT)
From: Dan Carpenter <dcarpenter@penguincomputing.com>
X-X-Sender: <dcarpenter@ddcarpen1.penguincompting.com>
To: "Bryan O'Sullivan" <bos@serpentine.com>
cc: Dave Jones <davej@codemonkey.org.uk>, <linux-kernel@vger.kernel.org>,
       <ppokorny@penguincomputing.com>
Subject: Re: memtest86 on the opteron
In-Reply-To: <1055194161.32291.11.camel@serpentine.internal.keyresearch.com>
Message-ID: <Pine.LNX.4.33.0306110844310.2820-100000@ddcarpen1.penguincompting.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Jun 2003, Bryan O'Sullivan wrote:

> On Mon, 2003-06-09 at 14:18, Dave Jones wrote:
>
> > Any reason to restrict it to a single stepping ?
> > This means you have to upgrade memtest every time a new model
> > is released, which seems a bit of a pain.
>
> This is the patch I use, which seems to make sense, since I don't know
> of any other steppings.  No point in parameterising the code until you
> have some parameters.
>

Grand.  I threw in a break statement so it handles Athlons again.
Here is the patch against the original memtest for the mail archives.

thanks,
dan carpenter
Penguin Computing

--- init.c.orig	Wed Jun 11 08:49:02 2003
+++ init.c	Wed Jun 11 08:43:39 2003
@@ -402,6 +402,14 @@
 			}
 			l1_cache = cpu_id.cache_info[3];
 			l1_cache += cpu_id.cache_info[7];
+			break;
+                case 15:
+			cprint(LINE_CPU, 0, "AMD Opteron");
+			off = 11;
+			l1_cache = cpu_id.cache_info[3];
+			l1_cache += cpu_id.cache_info[7];
+			l2_cache = (cpu_id.cache_info[11] << 8);
+			l2_cache += cpu_id.cache_info[10];
 		}
 		break;



