Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262636AbVDAFXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbVDAFXV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 00:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbVDAFUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 00:20:36 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:27586 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262629AbVDAFPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 00:15:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=K4zz3VT11tYAMFLe1EdqOukabP8IPmAF4hfaBbCXTuHXkcjFkywMDLHGFhHMFp08EsuIfbSgpmllr8Ot7oqXMb8ggZ93v/GxjJVYHdArdreX//Qj/REkM3bN4aa26Pw3ZAQfaslTZ6237xU46heUJWVwJGO4g1KkM6Is5n17Yjg=
Date: Fri, 1 Apr 2005 14:15:32 +0900
From: Tejun Heo <htejun@gmail.com>
To: Christoph Hellwig <hch@infradead.org>, James.Bottomley@steeleye.com,
       axboe@suse.de, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH scsi-misc-2.6 04/13] scsi: remove meaningless volatile qualifiers from structure definitions
Message-ID: <20050401051532.GD11318@htj.dyndns.org>
References: <20050331090647.FEDC3964@htj.dyndns.org> <20050331090647.57213FBA@htj.dyndns.org> <20050331101145.GA13842@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050331101145.GA13842@infradead.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Chritoph.

On Thu, Mar 31, 2005 at 11:11:45AM +0100, Christoph Hellwig wrote:
> On Thu, Mar 31, 2005 at 06:08:10PM +0900, Tejun Heo wrote:
> >  	struct list_head    siblings;   /* list of all devices on this host */
> >  	struct list_head    same_target_siblings; /* just the devices sharing same target id */
> >  
> > -	volatile unsigned short device_busy;	/* commands actually active on low-level */
> > +	unsigned short device_busy;	/* commands actually active on
> > +					 * low-level. protected by sdev_lock. */
> 
> You should probably switch it to just unsigned.  The other 16bit are wasted
> due to alignment anyway, and some architectures produce better code for 32bit
> accesses.
> 
> > -	volatile unsigned short host_busy;   /* commands actually active on low-level */
> > -	volatile unsigned short host_failed; /* commands that failed. */
> > +
> > +	/*
> > +	 * The following two fields are protected with host_lock;
> > +	 * however, eh routines can safely access during eh processing
> > +	 * without acquiring the lock.
> > +	 */
> > +	unsigned short host_busy;	   /* commands actually active on low-level */
> > +	unsigned short host_failed;	   /* commands that failed. */
> 
> Here it would actually increase the struct size but might make sense anyway.

 Sure, I'll make them unsigned.

 Thanks.

-- 
tejun

