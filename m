Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbWCTNI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWCTNI6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWCTNI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:08:58 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:12257 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932285AbWCTNI5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:08:57 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [PATCH]use kzalloc in vfs where appropriate
Date: Mon, 20 Mar 2006 15:08:47 +0200
User-Agent: KMail/1.8.2
Cc: "Oliver Neukum" <oliver@neukum.org>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Matthew Wilcox" <matthew@wil.cx>, viro@zeniv.linux.org.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0603172153160.30725@fachschaft.cup.uni-muenchen.de> <200603192150.23444.oliver@neukum.org> <84144f020603192325h54fd3212l1f4846fd40b9f074@mail.gmail.com>
In-Reply-To: <84144f020603192325h54fd3212l1f4846fd40b9f074@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603201508.47960.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 March 2006 09:25, Pekka Enberg wrote:
> > Rewriting the test as:
> > n!=0 && n > INT_MAX / size
> > saves the division because size is much likelier to be a constant, and indeed
> > the code is better:
> >
> >         cmpq    $268435455, %rax
> >         movq    $0, 40(%rsp)
> >         ja      .L313
> >
> > Is there anything I am missing?

You may drop "n!=0" part, but you must check size!=0.
Since if size is 0, kcalloc returns NULL, then

        if (!size || n > INT_MAX / size)
                return NULL;

--
vda
