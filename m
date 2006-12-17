Return-Path: <linux-kernel-owner+w=401wt.eu-S1752525AbWLQMYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525AbWLQMYZ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 07:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752521AbWLQMYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 07:24:25 -0500
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:47863 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbWLQMYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 07:24:24 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Dec 2006 07:24:23 EST
From: Ingo Oeser <ioe-lkml@rameria.de>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 2.6.19] e1000: replace kmalloc with kzalloc
Date: Sun, 17 Dec 2006 13:17:29 +0100
User-Agent: KMail/1.9.5
Cc: "Yan Burman" <burman.yan@gmail.com>, linux-kernel@vger.kernel.org,
       trivial@kernel.org, cramerj@intel.com
References: <1165942389.5611.4.camel@localhost> <84144f020612120934n612f513er606d2653f527eb67@mail.gmail.com>
In-Reply-To: <84144f020612120934n612f513er606d2653f527eb67@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612171317.32003.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 12. December 2006 18:34, Pekka Enberg wrote:
> On 12/12/06, Yan Burman <burman.yan@gmail.com> wrote:
> >         size = txdr->count * sizeof(struct e1000_buffer);
> > -       if (!(txdr->buffer_info = kmalloc(size, GFP_KERNEL))) {
> > +       if (!(txdr->buffer_info = kzalloc(size, GFP_KERNEL))) {
> >                 ret_val = 1;
> >                 goto err_nomem;
> >         }
> > -       memset(txdr->buffer_info, 0, size);
> 
> No one seems to be using size elsewhere so why not convert to
> kcalloc() and get rid of it? (Seems to apply to other places as well.)

Because if done properly that often exceeds the 80 column limit.
The intermediate variable should be optimized away from the compiler.

But kcalloc() is better for another reason: Overflow checking.

Regards

Ingo Oeser
