Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268087AbUGWVcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268087AbUGWVcN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 17:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268088AbUGWVcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 17:32:13 -0400
Received: from imap.gmx.net ([213.165.64.20]:18321 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268087AbUGWVcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 17:32:11 -0400
X-Authenticated: #12437197
Date: Sat, 24 Jul 2004 00:32:23 +0300
From: Dan Aloni <da-x@gmx.net>
To: Robert Love <rml@ximian.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel events layer
Message-ID: <20040723213223.GA637@callisto.yi.org>
References: <1090604517.13415.0.camel@lucy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090604517.13415.0.camel@lucy>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2004 at 01:41:57PM -0400, Robert Love wrote:

> +void send_kmessage(int type, const char *object, const char *signal,
> +		   const char *fmt, ...)
> +{
> +	char *buffer;
> +	int len;
> +	int ret;
> +
> +	if (!object)
> +		return;
> +
> +	if (!signal)
> +		return;
> +
> +	if (strlen(object) > PAGE_SIZE)
> +		return;
> +
> +	buffer = (char *) get_zeroed_page(GFP_ATOMIC);
> +	if (!buffer)
> +		return;
> +
> +	len = sprintf(buffer, "From: %s\n", object);
> +	len += sprintf(&buffer[len], "Signal: %s\n", signal);

IMHO you either should not assume anything about the length of the object 
string, _or_ do the complete safe string assembly e.g:

        len += snprintf(buffer, PAGE_SIZE, "From: %s\nSignal: %s\n", 
                        object, signal);


-- 
Dan Aloni
da-x@colinux.org
