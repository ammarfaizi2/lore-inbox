Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWDJIoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWDJIoY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 04:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWDJIoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 04:44:23 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:15303 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1751097AbWDJIoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 04:44:23 -0400
Message-ID: <443A1AA5.8060707@s5r6.in-berlin.de>
Date: Mon, 10 Apr 2006 10:43:17 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: de, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
CC: linux-scsi@vger.kernel.org, gibbs@scsiguy.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deinline some functions in aic7xxx drivers, save 80k
 of text
References: <200604100844.12151.vda@ilport.com.ua>
In-Reply-To: <200604100844.12151.vda@ilport.com.ua>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
...
> +++ linux-2.6.16.aic7/drivers/scsi/aic7xxx/aic79xx_core.c	Sun Apr  9 21:49:25 2006
...
> +#include "aic79xx_osm_o.c"
> +#include "aic79xx_inline.c"
...
> +++ linux-2.6.16.aic7/drivers/scsi/aic7xxx/aic7xxx_core.c	Sun Apr  9 21:49:25 2006
...
> +#include "aic7xxx_osm_o.c"
> +#include "aic7xxx_inline.c"
...

Instead of including c files with function definitions, you should add
function prototypes to header files (it seems you already did so) and
include only the header files. Include these header files in the c files
which call the functions as well as in the c files which define the
functions.

It is obviously necessary to modify the Makefile to have aic7?xx_osm_o.o
and aic7?xx_inline.o linked to an appropriate .ko file.

Furthermore, aic7?xx_inline.c are not very fitting file names since they
do not contain inline functions. aic7?xx_osm_o.c are somewhat strange
names either. Can't you move the functions into existing c files? E.g.
into those which contain most of the calls to the now de-inlined
functions. From the point of view of cross-OS driver maintenance (but
not necessarily from the point of view of Linux driver maintenance), it
may be useful to distinguish between functions used across OSs and those
used only in Linux when deciding where to move the functions.
-- 
Stefan Richter
-=====-=-==- -=-- -=-=-
http://arcgraph.de/sr/
