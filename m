Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbVESKkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbVESKkf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 06:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbVESKke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 06:40:34 -0400
Received: from gs.bofh.at ([193.154.150.68]:23466 "EHLO gs.bofh.at")
	by vger.kernel.org with ESMTP id S262045AbVESKkT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 06:40:19 -0400
Subject: Re: [patch 1/7] BSD Secure Levels: printk overhaul
From: Bernd Petrovitsch <bernd@firmix.at>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Michael Halcrow <mhalcrow@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Serge Hallyn <serue@us.ibm.com>
In-Reply-To: <1116466180.26955.104.camel@localhost>
References: <20050517152303.GA2814@halcrow.us>
	 <1116466180.26955.104.camel@localhost>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Thu, 19 May 2005 12:39:45 +0200
Message-Id: <1116499185.26770.24.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-18 at 18:29 -0700, Dave Hansen wrote:
> On Tue, 2005-05-17 at 10:23 -0500, Michael Halcrow wrote:
[...]
> > @@ -198,15 +196,15 @@
> >  static int seclvl_sanity(int reqlvl)
> >  {
> >  	if ((reqlvl < -1) || (reqlvl > 2)) {
> > -		seclvl_printk(1, KERN_WARNING, "Attempt to set seclvl out of "
> > -			      "range: [%d]\n", reqlvl);
> > +		seclvl_printk(1, KERN_WARNING "%s: Attempt to set seclvl out "
> > +			      "of range: [%d]\n", __FUNCTION__, reqlvl);
> 
> Instead of changing each and every seclvl_printk() call to add
> __FUNCTION__, why not do this:
> 
> +static void __seclvl_printk(int verb, const char *fmt, ...)
> ...
> 
> #define seclvl_printk(verb, fmt, arg...) \
> 	__seclvl_printk(verb, __FUNCTION__ ": " fmt, arg)
> 
> It requires that the fmt be a string literal, but it saves a lot of code
> duplication.  I'm sure there are some more examples of this around as

And it duplicates identical format strings in different functions
(besides violating another unwritten rule). What about:
----  snip  ----
#define seclvl_printk(verb, fmt, arg...) \
	__seclvl_printk((verb), "%s: " fmt, __FUNCTION__, arg)
----  snip  ----

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services




