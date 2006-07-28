Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161148AbWG1No4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161148AbWG1No4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 09:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161146AbWG1No4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 09:44:56 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60166 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1161142AbWG1Noz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 09:44:55 -0400
Date: Fri, 28 Jul 2006 06:01:35 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
Subject: Re: [RFC][PATCH 3/6] SLIM main patch
Message-ID: <20060728060134.GB4623@ucw.cz>
References: <1153763487.5171.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153763487.5171.17.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> SLIM is an LSM module which provides an enhanced low water-mark
> integrity and high water-mark secrecy mandatory access control
> model.

Still no Documentation/ changes. Uses // comments to comment out code.

> +static char *get_token(char *buf_start, char *buf_end, char delimiter,
> +		       int *token_len)
> +{
> +	char *bufp = buf_start;
> +	char *token = NULL;
> +
> +	while (!token && (bufp < buf_end)) {	/* Get start of token */
> +		switch (*bufp) {
> +		case ' ':
> +		case '\n':
> +		case '\t':
> +			bufp++;
> +			break;
> +		case '#':
> +			while ((*bufp != '\n') && (bufp++ < buf_end)) ;
> +			bufp++;
> +			break;
> +		default:
> +			token = bufp;
> +			break;
> +		}
> +	}
> +	if (!token)
> +		return NULL;
> +
> +	*token_len = 0;
> +	while ((*token_len == 0) && (bufp <= buf_end)) {
> +		if ((*bufp == delimiter) || (*bufp == '\n'))
> +			*token_len = bufp - token;
> +		if (bufp == buf_end)
> +			*token_len = bufp - token;
> +		bufp++;
> +	}
> +	if (*token_len == 0)
> +		token = NULL;
> +	return token;
> +}

What are these tokens and why do we want to play with strings in
kernel?

							Pavel

-- 
Thanks for all the (sleeping) penguins.
