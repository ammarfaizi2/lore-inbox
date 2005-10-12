Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbVJLA3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbVJLA3A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 20:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbVJLA3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 20:29:00 -0400
Received: from gate.crashing.org ([63.228.1.57]:28560 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932370AbVJLA27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 20:28:59 -0400
Subject: Re: [PATCH] ppc64: Thermal control for SMU based machines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
In-Reply-To: <20051011171315.2fe087e7.akpm@osdl.org>
References: <1128404215.31063.32.camel@gaston>
	 <20051011171315.2fe087e7.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 12 Oct 2005 10:24:51 +1000
Message-Id: <1129076691.17365.250.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-11 at 17:13 -0700, Andrew Morton wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > +#define BUILD_SHOW_FUNC_FIX(name, data)				\
> > +static ssize_t show_##name(struct device *dev,                  \
> > +			   struct device_attribute *attr,       \
> > +			   char *buf)	                        \
> > +{								\
> > +	ssize_t r;						\
> > +        s32 val = 0;                                            \
> > +        data->ops->get_value(data, &val);                       \
> > +	r = sprintf(buf, "%d.%03d", FIX32TOPRINT(val)); 	\
> > +	return r;						\
> > +}                                                               \
> > +static DEVICE_ATTR(name,S_IRUGO,show_##name, NULL);
> > +
> > +
> > +#define BUILD_SHOW_FUNC_INT(name, data)				\
> > +static ssize_t show_##name(struct device *dev,                  \
> > +			   struct device_attribute *attr,       \
> > +			   char *buf)	                        \
> > +{								\
> > +        s32 val = 0;                                            \
> > +        data->ops->get_value(data, &val);                       \
> > +	return sprintf(buf, "%d", val);  			\
> > +}                                                               \
> 
> Someone needs a tab key ;)

Ahh no, the problem here is that stupid emacs is very bad with tab
and multi-line macros and just turns the whole thing into shit, so
I used spaces. Sorry, I'm not an emacs guru and don't know how to
work around that ...

Ben.


