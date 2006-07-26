Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbWGZLW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbWGZLW6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 07:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWGZLW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 07:22:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:53833 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932525AbWGZLW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 07:22:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=nJ5JnOXb1nFAQpD7Ux4eNHdp28BX/kq/72r6iUF+pQ9DGRCvhmDWbyRkCQ/XsW471vFoe1pCASh6/V4yETWEZC5IyJm4Sozwkg+Avr/eUEATUpVIQ56SuF7mrO6NIKZtvknF//Ius9txG7ccD+CcheD12NdMTlTkquhqndiV9Z8=
Message-ID: <84144f020607260422t668c4d8dldfcdedfe3713b73e@mail.gmail.com>
Date: Wed, 26 Jul 2006 14:22:55 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Heiko Carstens" <heiko.carstens@de.ibm.com>
Subject: Re: [patch] slab: always follow arch requested alignments
Cc: "Christoph Lameter" <clameter@sgi.com>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060722162607.GA10550@osiris.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060722110601.GA9572@osiris.boeblingen.de.ibm.com>
	 <Pine.LNX.4.64.0607220748160.13737@schroedinger.engr.sgi.com>
	 <20060722162607.GA10550@osiris.ibm.com>
X-Google-Sender-Auth: 422342f2550c23e2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On 7/22/06, Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> Sorry, I should have mentioned it: on s390 (32 bit) we set
> #define ARCH_KMALLOC_MINALIGN 8.
> This is needed since our common I/O layer allocates data structures that need
> to have an eight byte alignment. Now, if I turn on DEBUG_SLAB, nothing works
> anymore, simply because the slab cache code ignores ARCH_KMALLOC_MINALIGN and
> uses an BYTES_PER_WORD alignment instead, which it shouldn't:

This is the bit I missed, sorry. I thought that the s390 hardware
mandates 8 byte alignment, but it really doesn't. So you're absolutely
right, you don't need to set ARCH_SLAB_MINALIGN and the alignment
calculation in slab is indeed broken for both, architecture and caller
mandated alignments.

                                     Pekka
