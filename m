Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316882AbSHTLzu>; Tue, 20 Aug 2002 07:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316883AbSHTLzu>; Tue, 20 Aug 2002 07:55:50 -0400
Received: from newman.edw2.uc.edu ([129.137.2.198]:57865 "EHLO smtp.uc.edu")
	by vger.kernel.org with ESMTP id <S316882AbSHTLzt>;
	Tue, 20 Aug 2002 07:55:49 -0400
From: kuebelr@email.uc.edu
Date: Tue, 20 Aug 2002 07:59:42 -0400
To: Kristian Peters <kristian.peters@korseby.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] cdrom per drive sysctl's
Message-Id: <20020820115942.GA27724@cartman>
References: <20020819200927.GA8771@cartman> <20020820093539.5b8fef35.kristian.peters@korseby.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020820093539.5b8fef35.kristian.peters@korseby.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2002 at 09:35:39AM +0200, Kristian Peters wrote:
...
> > +	/* copy the default settings for the new drive */
> > +	memcpy(cst, &cdrom_table, sizeof(struct cdrom_sysctl_table));
> 
> Hm. I don't understand this. Why are you applying the default settings to a new entry hence they're overwritten later ?
> 
> > +	cst->options_table[0].data = &cst->options.autoclose;
> > +	cst->options_table[1].data = &cst->options.autoeject;
> > +	cst->options_table[2].data = &cst->options.debug;
> > +	cst->options_table[3].data = &cst->options.lock;
> > +	cst->options_table[4].data = &cst->options.check_media;
> > +	cst->options_table[5].procname = "info";
> > +	cst->options_table[5].extra1 = cdi;
> > +	cst->drive_table[0].child = cst->options_table;
> > +	cst->drive_table[0].procname = cdi->name;
> > +	cst->drive_table[0].ctl_name = kdev_t_to_nr(cdi->dev);
> > +	cst->cdrom_table[0].child = cst->drive_table;
> > +	cst->dev_table[0].child = cst->cdrom_table;
> > +
...

the values of the default settings are copied w/ memcpy(), but the new
structure has to point to its own settings (so changing sr0/debug
changes sr0's data not the default settings). that is why i manipulate
the pointers later.

rob.
