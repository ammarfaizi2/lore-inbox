Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261845AbTCHAzD>; Fri, 7 Mar 2003 19:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261583AbTCHAxj>; Fri, 7 Mar 2003 19:53:39 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:39180 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261576AbTCHAw7>;
	Fri, 7 Mar 2003 19:52:59 -0500
Date: Fri, 7 Mar 2003 16:53:33 -0800
From: Greg KH <greg@kroah.com>
To: Andries.Brouwer@cwi.nl
Cc: alan@lxorguk.ukuu.org.uk, akpm@digeo.com, hch@infradead.org,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030308005333.GF23071@kroah.com>
References: <UTC200303080057.h280v0o28591.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200303080057.h280v0o28591.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 01:57:00AM +0100, Andries.Brouwer@cwi.nl wrote:
> So my first job is to make sure that no bad minor is ever used
> as array index. Fortunately registration is not by major but
> by dev_t interval, so things tend to be correct automatically.

But register_chrdev() only allocates based on a major.  If a character
driver asks for a major, today it only thinks it has 256 minors, so that
number is usually hard coded in an array.  If a open() happens on a
minor outside that range, the driver will die a horrible death, right?

thanks,

greg k-h
