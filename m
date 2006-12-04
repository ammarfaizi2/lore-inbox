Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937021AbWLDPa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937021AbWLDPa1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 10:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937023AbWLDPa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 10:30:26 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:9186 "EHLO
	mtagate6.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937021AbWLDPaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 10:30:24 -0500
Subject: Re: [S390] cio: Make ccw_dev_id_is_equal() more robust.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org, cornelia.huck@de.ibm.com
In-Reply-To: <20061204152348.GA30961@filer.fsl.cs.sunysb.edu>
References: <20061204145624.GB32059@skybase>
	 <20061204152348.GA30961@filer.fsl.cs.sunysb.edu>
Content-Type: text/plain
Organization: IBM Corporation
Date: Mon, 04 Dec 2006 16:30:18 +0100
Message-Id: <1165246218.8364.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-04 at 10:23 -0500, Josef Sipek wrote:
> > diff -urpN linux-2.6/include/asm-s390/cio.h linux-2.6-patched/include/asm-s390/cio.h
> > --- linux-2.6/include/asm-s390/cio.h	2006-12-04 14:50:48.000000000 +0100
> > +++ linux-2.6-patched/include/asm-s390/cio.h	2006-12-04 14:51:00.000000000 +0100
> > @@ -278,7 +278,10 @@ struct ccw_dev_id {
> >  static inline int ccw_dev_id_is_equal(struct ccw_dev_id *dev_id1,
> >  				      struct ccw_dev_id *dev_id2)
> >  {
> > -	return !memcmp(dev_id1, dev_id2, sizeof(struct ccw_dev_id));
> > +	if ((dev_id1->ssid == dev_id2->ssid) &&
> > +	    (dev_id1->devno == dev_id2->devno))
> > +		return 1;
> > +	return 0;
> >  }
> 
> Why not just:
> 
> return ((dev_id1->ssid == ......) && (...));

Yes, why not. It would be a little bit shorter. The compiler probably
won't care and generate the same code..

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


