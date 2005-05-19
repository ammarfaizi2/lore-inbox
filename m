Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262430AbVESBaC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbVESBaC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 21:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbVESBaC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 21:30:02 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:51153 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262430AbVESB36
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 21:29:58 -0400
Subject: Re: [patch 1/7] BSD Secure Levels: printk overhaul
From: Dave Hansen <haveblue@us.ibm.com>
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Serge Hallyn <serue@us.ibm.com>
In-Reply-To: <20050517152303.GA2814@halcrow.us>
References: <20050517152303.GA2814@halcrow.us>
Content-Type: text/plain
Date: Wed, 18 May 2005 18:29:40 -0700
Message-Id: <1116466180.26955.104.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-17 at 10:23 -0500, Michael Halcrow wrote:
>  struct seclvl_attribute {
>  	struct attribute attr;
> -	ssize_t(*show) (struct seclvl_obj *, char *);
> -	ssize_t(*store) (struct seclvl_obj *, const char *, size_t);
> +	 ssize_t(*show) (struct seclvl_obj *, char *);
> +	 ssize_t(*store) (struct seclvl_obj *, const char *, size_t);
>  };

You've changed tabs to spaces.

>  /**
> @@ -198,15 +196,15 @@
>  static int seclvl_sanity(int reqlvl)
>  {
>  	if ((reqlvl < -1) || (reqlvl > 2)) {
> -		seclvl_printk(1, KERN_WARNING, "Attempt to set seclvl out of "
> -			      "range: [%d]\n", reqlvl);
> +		seclvl_printk(1, KERN_WARNING "%s: Attempt to set seclvl out "
> +			      "of range: [%d]\n", __FUNCTION__, reqlvl);

Instead of changing each and every seclvl_printk() call to add
__FUNCTION__, why not do this:

+static void __seclvl_printk(int verb, const char *fmt, ...)
...

#define seclvl_printk(verb, fmt, arg...) \
	__seclvl_printk(verb, __FUNCTION__ ": " fmt, arg)

It requires that the fmt be a string literal, but it saves a lot of code
duplication.  I'm sure there are some more examples of this around as
well.

-- Dave

