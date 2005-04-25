Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262764AbVDYTa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262764AbVDYTa2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 15:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVDYT1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 15:27:53 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:37816 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262749AbVDYTXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 15:23:03 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [patch 7/7] uml ubd: handle readonly status
Date: Mon, 25 Apr 2005 21:20:15 +0200
User-Agent: KMail/1.8
Cc: akpm@osdl.org, jdike@addtoit.com, bstroesser@fujitsu-siemens.com,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
References: <20050424181924.EAFCB55D06@zion> <20050425101625.GD1671@suse.de>
In-Reply-To: <20050425101625.GD1671@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504252120.15493.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 April 2005 12:16, Jens Axboe wrote:
> On Sun, Apr 24 2005, blaisorblade@yahoo.it wrote:
> > @@ -1099,6 +1104,7 @@ static int prepare_request(struct reques
> >  	if((rq_data_dir(req) == WRITE) && !dev->openflags.w){
> >  		printk("Write attempted on readonly ubd device %s\n",
> >  		       disk->disk_name);
> > +		WARN_ON(1); /* This should be impossible now */
> >  		end_request(req, 0);
> >  		return(1);
> >  	}
>
> I don't think that's a sound change. The WARN_ON() is strictly only
> really useful for when you need the stack trace for something
> interesting. As the io happens async, you will get a boring trace that
> doesn't contain any valuable information.
Ok, removed, and resending the patch, is the rest ok? I.e. is that supposed to 
work? I gave a walk around and it seemed that the code handles 
set_{disk,device}_ro() even during the open, but I'm no block layer expert.

Thanks for the review.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

