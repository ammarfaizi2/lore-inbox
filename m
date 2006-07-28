Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161242AbWG1TFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161242AbWG1TFg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 15:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161246AbWG1TFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 15:05:36 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:26811 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161242AbWG1TFf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 15:05:35 -0400
Subject: Re: [RFC][PATCH 3/6] SLIM main patch
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
In-Reply-To: <20060728060134.GB4623@ucw.cz>
References: <1153763487.5171.17.camel@localhost.localdomain>
	 <20060728060134.GB4623@ucw.cz>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 12:05:31 -0700
Message-Id: <1154113531.4695.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 06:01 +0000, Pavel Machek wrote:
> Hi!
> 
> > SLIM is an LSM module which provides an enhanced low water-mark
> > integrity and high water-mark secrecy mandatory access control
> > model.
> 
> Still no Documentation/ changes. Uses // comments to comment out code.
> 
We'll add a description similar to what was in the Patch 3 email to file
slim.txt in Documentation and make sure to remove all // comments in the
next release.

> > +static char *get_token(char *buf_start, char *buf_end, char delimiter,
> > +		       int *token_len)
> > +{
> > +	char *bufp = buf_start;
> > +	char *token = NULL;
> > +
> > +	while (!token && (bufp < buf_end)) {	/* Get start of token */
> > +		switch (*bufp) {
> > +		case ' ':
> > +		case '\n':
> > +		case '\t':
> > +			bufp++;
> > +			break;
> > +		case '#':
> > +			while ((*bufp != '\n') && (bufp++ < buf_end)) ;
> > +			bufp++;
> > +			break;
> > +		default:
> > +			token = bufp;
> > +			break;
> > +		}
> > +	}
> > +	if (!token)
> > +		return NULL;
> > +
> > +	*token_len = 0;
> > +	while ((*token_len == 0) && (bufp <= buf_end)) {
> > +		if ((*bufp == delimiter) || (*bufp == '\n'))
> > +			*token_len = bufp - token;
> > +		if (bufp == buf_end)
> > +			*token_len = bufp - token;
> > +		bufp++;
> > +	}
> > +	if (*token_len == 0)
> > +		token = NULL;
> > +	return token;
> > +}
> 
> What are these tokens and why do we want to play with strings in
> kernel?
> 
The xattrs must be parsed.  They are strings for portability and
readability.  SELinux does this as well.  Note: we are in the process of
removing the time stuff from the xattr for the next release for this
reason as well.

Thanks,
Kylie

> 							Pavel
> 

