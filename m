Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424462AbWKJWqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424462AbWKJWqj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 17:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424463AbWKJWqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 17:46:39 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:36337 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1424462AbWKJWqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 17:46:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Fg7wRhzpL72zeUJC7S/Zp9Lkkwd00zGMXuvsSWO4jSR+JXpJA1qZ4Bz/mVo+h2Q20d5nXeJbSCmiJYsCiM20xlFnXRWI4QLSe+x+Ci2iz579Ew434GozeoPmLyLs6NSL4DUZhC3vZ3yxkL3MQQ0XbC4sdgMZ6aasCOwi72bJGrs=
Message-ID: <84144f020611101446o3a1c05d0i592ea0ca853b73c@mail.gmail.com>
Date: Sat, 11 Nov 2006 00:46:36 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Kirill Korotaev" <dev@sw.ru>
Subject: Re: [PATCH 6/13] BC: kmemsize accounting (core)
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, xemul@openvz.org,
       devel@openvz.org, oleg@tv-sign.ru, hch@infradead.org,
       matthltc@us.ibm.com, ckrm-tech@lists.sourceforge.net
In-Reply-To: <45535EA3.10300@sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45535C18.4040000@sw.ru> <45535EA3.10300@sw.ru>
X-Google-Sender-Auth: 9fdac3ac41490a22
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/9/06, Kirill Korotaev <dev@sw.ru> wrote:
> +#ifdef CONFIG_BEANCOUNTERS
> +#define BC_EXTRASIZE   sizeof(struct beancounter *)
> +static inline size_t slab_mgmt_size_noalign(int flags, size_t nr_objs)
> +{
> +       size_t size;
> +
> +       size = slab_mgmt_size_raw(nr_objs);
> +       if (flags & SLAB_BC)
> +               size = ALIGN(size, BC_EXTRASIZE) + nr_objs * BC_EXTRASIZE;
> +       return size;

Why do we want to track each allocated _object_ in the slab? Isn't
tracking pages enough?
