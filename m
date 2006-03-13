Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbWCMWSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWCMWSl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWCMWSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:18:38 -0500
Received: from ms-smtp-02-lbl.southeast.rr.com ([24.25.9.101]:21671 "EHLO
	ms-smtp-02-eri0.southeast.rr.com") by vger.kernel.org with ESMTP
	id S964802AbWCMWSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:18:34 -0500
Subject: Re: [patch 16/17] s390: multiple subchannel sets support.
From: Greg Smith <gsmith@nc.rr.com>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
In-Reply-To: <20060227091546.2d63209b@gondolin.boeblingen.de.ibm.com>
References: <1140865922.3513.87.camel@localhost.localdomain>
	 <20060227091546.2d63209b@gondolin.boeblingen.de.ibm.com>
Content-Type: text/plain
Date: Mon, 13 Mar 2006 17:18:28 -0500
Message-Id: <1142288308.3510.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-27 at 09:15 +0100, Cornelia Huck wrote:
> On Sat, 25 Feb 2006 06:12:02 -0500
> Greg Smith <gsmith@nc.rr.com> wrote:
> 
> > However, __init_channel_subsystem does not recognize the -EIO return
> > code from css_alloc_subchannel.
> 
> Good catch.

It seems this patch got dropped (it was in addition to the `s390:
improve response code handling in chsc_enable_facility()' patch).

Greg Smith

diff -u -r a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
--- a/drivers/s390/cio/css.c	2006-03-13 12:54:16.000000000 -0500
+++ b/drivers/s390/cio/css.c	2006-03-13 12:55:03.000000000 -0500
@@ -409,6 +409,9 @@
 		/* -ENXIO: no more subchannels. */
 		case -ENXIO:
 			return ret;
+		/* -EIO: this subchannel set not supported. */
+		case -EIO:
+			return ret;
 		default:
 			return 0;
 		}


